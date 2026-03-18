#pragma once
#include <array>
#include <fstream>
#include <string>
#include <vector>
using namespace std;

/*! 全局命名空间 */
namespace BinaryRead
{

/*! 常规工具命名空间 */
namespace Tool
{
/*! 将1字节转换为8位数组 */
array<int, 8> byte_split(int byte)
{
    array<int, 8> byte_list;
    byte_list.fill(0);
    int index = 7;
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
enum delta_loc { start,
                 current,
                 end };

/*! 封装二进制数据读取的类 */
class BinaryRead
{
public:
    BinaryRead(string filename);
    void locate(int locate_width, delta_loc loc);
    u_int8_t get_byte();
    int get_int(int width);
    string get_ascii(int width);
private:
    ifstream binary_file;
};

/*！构造函数，主要传递二进制文件 */
BinaryRead::BinaryRead(string filename)
{
    binary_file.open(filename, ios::binary);
}

/*! 用于定位的方法，数值+delta_loc::{start|current|start} */
void BinaryRead::locate(int locate_width, delta_loc loc)
{
    switch (loc) {
        case delta_loc::start:
            binary_file.seekg(locate_width, ios::beg);
        case delta_loc::current:
            binary_file.seekg(locate_width, ios::cur);
        case delta_loc::end:
            binary_file.seekg(locate_width, ios::end);
    }
}

/*! 获取1字节数据，返回整数0~255 */
u_int8_t BinaryRead::get_byte()
{
    u_int8_t byte;
    binary_file.read(reinterpret_cast<char*>(&byte), 1);
    return static_cast<u_int8_t>(byte);
}

/*! 获取n字节数据，返回ascii字符串 */
string BinaryRead::get_ascii(int width)
{
    vector<char> string_list(width);
    binary_file.read(string_list.data(), width);
    string ascii_str(string_list.begin(), string_list.begin() + width);
    return ascii_str;
}

int BinaryRead::get_int(int width)
{
    u_int8_t byte;
    binary_file.read(reinterpret_cast<char*>(&byte), width);
    return static_cast<u_int8_t>(byte);
}

} // namespace BinaryRead
