/*
 * @lc app=leetcode.cn id=2 lang=cpp
 *
 * [2] 两数相加
 */
struct ListNode
{
    int val;
    ListNode *next;
    ListNode(): val(0), next(nullptr)
    {
    }
    ListNode(int x): val(x), next(nullptr)
    {
    }
    ListNode(int x, ListNode *next): val(x), next(next)
    {
    }
};
// @lc code=start
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode() : val(0), next(nullptr) {}
 *     ListNode(int x) : val(x), next(nullptr) {}
 *     ListNode(int x, ListNode *next) : val(x), next(next) {}
 * };
 */
class Solution
{
public:
    ListNode *addTwoNumbers(ListNode *l1, ListNode *l2)
    {
        bool jinwei = false;
        ListNode *head = new ListNode;
        ListNode *p = head;
        while (true) {
            p->val = l1->val + l2->val;
            if (jinwei) {
                p->val += 1;
            }
            jinwei = false;
            if (p->val / 10) {
                jinwei = true;
                p->val -= 10;
            }
            if (!l1->next && !l2->next) {
                if (jinwei) {
                    p->next = new ListNode(1);
                }
                break;
            }
            p->next = new ListNode;
            p = p->next;
            if (l1->next) {
                l1 = l1->next;
            } else {
                l1 = new ListNode(0);
            }
            if (l2->next) {
                l2 = l2->next;
            } else {
                l2 = new ListNode(0);
            }
        }
        return head;
    }
};
// @lc code=end
