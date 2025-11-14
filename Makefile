# ===============================
# Makefile for Windows + MinGW
# ===============================
CC = gcc
CFLAGS = -I. -Isrc -Wall -Wextra -std=c11

SRC_DIR = src
TEST_DIR = test

# All the .c within src directory
SRC_FILES = $(wildcard $(SRC_DIR)/*.c)

# Specific files to add
MAIN = $(SRC_DIR)/main.c
TEST_FILES = $(wildcard $(TEST_DIR)/test_*.c)

# Outputs
TARGET = main.exe
TEST_TARGET = tests.exe

# =================================
# Compiling the Main application
# =================================
all: $(TARGET)

$(TARGET): $(SRC_FILES)
	$(CC) $(CFLAGS) $(SRC_FILES) -o $(TARGET)
	@echo ==== Compilation completed: $(TARGET) ====

# =================================
# Compiling tests (without main.c)
# =================================
tests: $(filter-out $(MAIN),$(SRC_FILES)) $(TEST_FILES)
	$(CC) $(CFLAGS) $(filter-out $(MAIN),$(SRC_FILES)) $(TEST_FILES) -o $(TEST_TARGET)
	@echo ==== Compilation completed: $(TEST_TARGET) ====

# =================================
# Execute tests
# =================================
run-tests: build-tests
	@echo ==== Executing tests ====
	@cd $(TEST_DIR) && test_suma.exe

# =================================
# Execute main application
# =================================
run: $(TARGET)
	@echo ==== Executing Application ====
	@./$(TARGET)

# =================================
# Clean everything
# =================================
clean:
	@echo ==== Cleaning binnaries ====
	@if exist "$(TARGET)" ( del /Q "$(TARGET)" )
	@if exist "$(subst /,\\,$(TEST_TARGET))" ( del /Q "$(subst /,\\,$(TEST_TARGET))" )
