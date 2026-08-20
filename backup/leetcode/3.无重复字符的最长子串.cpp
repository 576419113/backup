#include <string>
#include <map>
using namespace std;
/*
 * @lc app=leetcode.cn id=3 lang=cpp
 *
 * [3] 无重复字符的最长子串
 */

// @lc code=start
class Solution {
public:
    int lengthOfLongestSubstring(string s) {
        map<char, bool> temp;
        for (int i = 32; i <= 126; i++) {
            temp[i] = false;
        }
        int length = 0;
        int max = 0;
        string s1 = s;
        for (char c : s1) {
            if (!temp[c]) {
                length += 1;
            } else {
                int index = s.find(c);
                length -= index;
                for (char j: s.substr(0, index + 1)) {
                    temp[j] = false;
                }
                s.erase(0, index + 1);
            }
            temp[c] = true;
            if (length > max) {
                max = length;
            }
        }
        return max;
    }
};
// @lc code=end

