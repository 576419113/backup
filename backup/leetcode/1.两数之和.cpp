#include <vector>
#include <unordered_map>
using namespace std;
/*
 * @lc app=leetcode.cn id=1 lang=cpp
 *
 * [1] 两数之和
 */

// @lc code=start
class Solution
{
public:
    vector<int> twoSum(vector<int>& nums, int target)
    {
        /*! 一般方法
        for (int i = 0; i < nums.size(); i++) {
            for (int j = i + 1; j < nums.size(); j++) {
                if (nums[i] + nums[j] == target) {
                    vector<int> result = { i, j };
                    return result;
                }
            }
        }
        */
        /*! 哈希表 */
        unordered_map<int, int> hash_map;
        for (int i = 0; i < nums.size(); i++) {
            int pair = target - nums[i];
            if (hash_map.find(pair) != hash_map.end()) {
                return { i, hash_map[pair] };
            }
            hash_map[nums[i]] = i;
        }
        return { 0, 0 };
    }
};
// @lc code=end
