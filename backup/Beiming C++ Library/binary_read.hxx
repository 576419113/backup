#pragma once
#include <array>
#include <cmath>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>
using namespace std;

/*! 全局命名空间 */
namespace BinaryRead
{

/*! 常规工具命名空间 */
namespace Tool
{
/*! 将整数转换为m位二进制数组 */
vector<u_int8_t> byte_split(u_int64_t byte, u_int64_t width)
{
    vector<u_int8_t> byte_list(width, 0);
    int index = width -1;
    while (byte > 0) {
        byte_list[index] = (byte & 1 ? 1 : 0);
        byte >>= 1;
        index--;
    }
    return byte_list;
}

/*! 将八位数组转换为整数 */
u_int8_t byte_combine(array<int, 8> byte_list)
{
    return byte_list[7] + byte_list[6] * 2 + byte_list[5] * 4 + byte_list[4] * 8 + byte_list[3] * 16 + byte_list[2] * 32 + byte_list[1] * 64 + byte_list[0] * 128;
}

} // namespace Tool

/*! 定位封装的相对位置枚举类型 */
enum delta_loc { start, current, end };

/*! 定义端序的枚举类型 */
enum endian { BE, LE };

/*! 封装二进制数据读取的类 */
class BinaryRead
{
public:
    BinaryRead(string filename);
    ~BinaryRead();
    void locate(int64_t locate_width, delta_loc loc);
    void close();
    u_int8_t get_byte();
    std::vector<u_int8_t> get_bytes(u_int64_t width);
    u_int64_t get_int64(int width, endian direction);
    std::string get_ascii(int width);
    std::string get_utf16(u_int64_t width, endian direction);
    u_int64_t get_pos();
private:
    ifstream binary_file;
};

/*! 用于关闭文件 */
void BinaryRead::close()
{
    binary_file.close();
}

/*！构造函数，主要传递二进制文件 */
BinaryRead::BinaryRead(string filename)
{
    binary_file.open(filename, ios::binary);
}

/*! 析构函数，关闭文件 */
BinaryRead::~BinaryRead()
{
    binary_file.close();
}

/*! 用于定位的方法，数值+delta_loc::{start|current|start} */
void BinaryRead::BinaryRead::locate(int64_t locate_width, delta_loc loc)
{
    switch (loc) {
        case delta_loc::start:
            binary_file.seekg(locate_width, ios::beg);
            break;
        case delta_loc::current:
            binary_file.seekg(locate_width, ios::cur);
            break;
        case delta_loc::end:
            binary_file.seekg(locate_width, ios::end);
            break;
    }
}

/*! 获取1字节数据，返回整数0~255 */
u_int8_t BinaryRead::get_byte()
{
    u_int8_t byte;
    binary_file.read(reinterpret_cast<char*>(&byte), 1);
    return static_cast<u_int8_t>(byte);
}

/*! 获取n字节数据，返回vector容器 */
vector<u_int8_t> BinaryRead::get_bytes(u_int64_t width)
{
    vector<u_int8_t> bytes(width);
    binary_file.read(reinterpret_cast<char*>(bytes.data()), width);
    return bytes;
}

/*! 获取n字节数据，返回ascii字符串 */
string BinaryRead::get_ascii(int width)
{
    vector<char> string_list(width);
    binary_file.read(string_list.data(), width);
    string ascii_str(string_list.begin(), string_list.begin() + width);
    return ascii_str;
}

/*! 获取至多8字节数据，BE大端、LE小端, 返回int64_t */
u_int64_t BinaryRead::get_int64(int width, endian direction)
{
    try {
        if (width > 8) {
            throw "u_int64_t get_int64 allows only 8 bytes!";
        }
    } catch (const char* err_msg) {
        cout << err_msg << endl;
        binary_file.close();
        exit(EXIT_FAILURE);
    }
    int64_t result = 0;
    if (direction == endian::BE) {
        for (int i = 0; i < width; i++) {
            result += static_cast<u_int64_t>(get_byte() * pow(256, width - i - 1));
        }
    } else {
        for (int i = 0; i < width; i++) {
            result += static_cast<u_int64_t>(get_byte() * pow(256, i));
        }
    }
    return result;
}

/*! 获取n字节utf16数据, BE大端、LE小端，返回string */
std::string BinaryRead::get_utf16(u_int64_t width, endian direction = endian::BE)
{
    vector<u_int8_t> bytes = get_bytes(width);
    std::string result;
    for (u_int64_t i = 0; i < bytes.size(); i += 2) {
        u_int32_t code_point;
        if (i + 1 < bytes.size()) {
            // 读取两个字节
            u_int16_t ch;
            switch (direction) {
                case endian::LE:
                    ch = static_cast<u_int16_t>(bytes[i]) | (static_cast<u_int16_t>(bytes[i + 1]) << 8);
                    break;
                case endian::BE:
                    ch = (static_cast<u_int16_t>(bytes[i]) << 8) | static_cast<u_int16_t>(bytes[i + 1]);
                    break;
            }
            // 检测代理对
            if (ch >= 0xD800 && ch <= 0xDBFF && i + 3 < bytes.size()) {
                u_int16_t highSurrogate = ch;
                u_int16_t lowSurrogate = static_cast<u_int16_t>(bytes[i + 2]) |  (static_cast<u_int16_t>(bytes[i + 3]) << 8);
                if (lowSurrogate >= 0xDC00 && lowSurrogate <= 0xDFFF) {
                    // 计算实际的Unicode码点
                    code_point = 0x10000 + ((highSurrogate - 0xD800) << 10) + (lowSurrogate - 0xDC00);
                    i += 2;
                } else {
                    code_point = ch;
                }
            } else {
                code_point = ch;
            }
            // 转换成utf8输出
            if (code_point <= 0x7F) {
                result += static_cast<char>(code_point);
            } else if (code_point <= 0x7FF) {
                vector<u_int8_t> bytelist = Tool::byte_split(code_point, 11);
                array<int, 8> arr1 = {1, 1, 0, bytelist[0], bytelist[1], bytelist[2], bytelist[3], bytelist[4]};
                array<int, 8> arr2 = {1, 0, bytelist[5], bytelist[6], bytelist[7], bytelist[8], bytelist[9], bytelist[10]};
                result += Tool::byte_combine(arr1);
                result += Tool::byte_combine(arr2);
            } else if (code_point <= 0xFFFF) {
                vector<u_int8_t> bytelist = Tool::byte_split(code_point, 16);
                array<int, 8> arr1 = {1, 1, 1, 0, bytelist[0], bytelist[1], bytelist[2], bytelist[3]};
                array<int, 8> arr2 = {1, 0, bytelist[4], bytelist[5], bytelist[6], bytelist[7], bytelist[8], bytelist[9]};
                array<int, 8> arr3 = {1, 0, bytelist[10], bytelist[11], bytelist[12], bytelist[13], bytelist[14], bytelist[15]};
                result += Tool::byte_combine(arr1);
                result += Tool::byte_combine(arr2);
                result += Tool::byte_combine(arr3);
            } else if (code_point <= 0xFFFF) {
                vector<u_int8_t> bytelist = Tool::byte_split(code_point, 21);
                array<int, 8> arr1 = {1, 1, 1, 1, 0, bytelist[0], bytelist[1], bytelist[2]};
                array<int, 8> arr2 = {1, 0, bytelist[3], bytelist[4], bytelist[5], bytelist[6], bytelist[7], bytelist[8]};
                array<int, 8> arr3 = {1, 0, bytelist[9], bytelist[10], bytelist[11], bytelist[12], bytelist[13], bytelist[14]};
                array<int, 8> arr4 = {1, 0, bytelist[15], bytelist[16], bytelist[17], bytelist[18], bytelist[19], bytelist[20]};
                result += Tool::byte_combine(arr1);
                result += Tool::byte_combine(arr2);
                result += Tool::byte_combine(arr3);
                result += Tool::byte_combine(arr4);
            }
        }
    }
    return result;
}

u_int64_t BinaryRead::get_pos()
{
    std::streampos currentPos = binary_file.tellg();
    return static_cast<u_int64_t>(currentPos);
}

} // namespace BinaryRead
