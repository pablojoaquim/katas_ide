#include "../acutest.h"
#include "../src/addition.h"

void test_addition(void) {
    TEST_CHECK(addition(2, 3) == 5);
    TEST_CHECK(addition(-1, 1) == 0);
    TEST_CHECK(addition(0, 0) == 0);
}

TEST_LIST = {
    { "Testing a basic addition", test_addition },
    { NULL, NULL }  // terminador
};
