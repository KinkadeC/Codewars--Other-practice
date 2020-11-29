class Solution:
    def reverse(self, x: int) -> int:
        if x<0:
            x = x*-1
            s = int('-'+str(x)[::-1])
        else:
            s = int(str(x)[::-1])
        if s<(-2**31) or s>(2**31-1):
            return 0
        return s
        