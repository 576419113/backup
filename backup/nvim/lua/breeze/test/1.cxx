// cpp: @attribute, @boolean, @character, @constant, @constant.builtin, @constant.macro, @constructor, @function, @function.builtin, @function.call, @function.macro, @function.method, @function.method.call, @keyword, @keyword.conditional, @keyword.conditional.ternary, @keyword.coroutine, @keyword.exception, @keyword.modifier, @keyword.operator, @keyword.repeat, @keyword.return, @keyword.type, @label, @module, @number, @operator, @property, @punctuation.bracket, @punctuation.delimiter, @punctuation.special, @spell, @string.escape, @type, @type.builtin, @type.definition, @variable.builtin, @variable.member

// @keyword.import
#include <iostream>                // @string
#include <cmath>
// @keyword.directive
#define MAX_SIZE 1024              // @constant.macro @number
#define SQUARE(x) ((x) * (x))      // @function.macro @variable.parameter @variable
#ifdef WINDOWS
    #define OS_TYPE WINDOWS
#else
    #define OS_TYPE LINUX
#endif

// @comment
// This is a comment

/**
 * @comment.document
 * This is a document comment
 */

static constexpr int kGlobalConst = 42; // @constant
const double PI = 3.1415926;            // @constant.builtin (semantic)

enum class Status : int {              // @type.definition
    OK = 0,                           // @constant
    ERROR = 1
};

struct Point {                         // @type.definition
    int x;                             // @variable.member
    int y;                             // @variable.member
};

class Animal {                         // @type.definition
public:
    Animal() = default;                // @constructor
    virtual ~Animal() = default;       // @function.builtin

    virtual void speak() = 0;         // @function.method
    void move(int dx, int dy);         // @function.method

protected:
    int legs;                          // @variable.member
};

class Dog : public Animal {            // @keyword.modifier
public:
    Dog() : Animal() {}                // @constructor

    void speak() override {            // @function.method
        std::cout << "Bark\n";         // @string
    }

    void move(int dx, int dy) override {
        x += dx;                       // @variable.member
        y += dy;
    }

private:
    int x = 0;                         // @variable.member
    int y = 0;
};

template<typename T>                   // @keyword.type
class Box {                            // @type.definition
public:
    explicit Box(T value)              // @constructor
        : data(value) {}

    T get() const {                    // @function.method
        return data;                   // @variable.member
    }

private:
    T data;                            // @variable.member
};

namespace math {                       // @module
    constexpr int abs(int x) {         // @function
        return x < 0 ? -x : x;         // @keyword.conditional.ternary
    }
}

int main() {                           // @function
    // @keyword
    if (true) {                        // @keyword.conditional
        // @variable
        int i = 0;                    // @number

        // @operator
        i += 1;                       // @keyword.operator

        // @function.call
std::cout << "Hello, C++\n";  // @string

        // @function.builtin
        double root = std::sqrt(2.0); // @number

        // @constant.macro
        int arr[MAX_SIZE];

        // @function.macro
        int val = SQUARE(5);

        // @boolean
        bool flag = false;

        // @character
        char c = 'A';

        // @string.escape
        std::cout << "Tab\tLine\n";

        // @keyword.coroutine (C++20)
        // co_await / co_yield / co_return
        // (compiler-dependent)

        // @keyword.exception
        try {
            throw 1;                   // @keyword.operator
        } catch (int e) {
            std::cout << "Caught\n";
        }

        // @label
        goto end;

    end:
        return 0;                      // @keyword.return
    }
}
