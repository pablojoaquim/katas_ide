# ===============================
# Makefile for Windows + MinGW
# ===============================
CC = gcc
CFLAGS = -Wall -Wextra -std=c11

# ===============================
# Detect OS
# ===============================
ifeq ($(OS),Windows_NT)
    RM = del /Q
    EXE_EXT = .exe
	MKDIR = mkdir
else
    RM = rm -f
    EXE_EXT =
    MKDIR = mkdir -p
endif

# ===============================
# Source directories
# EDIT ONLY HERE!!!!!!!!!!!
# ===============================
SRC_DIRS  = src
TEST_DIRS = test
MAIN = src/main.c

# ===============================
# Windows \ → /
# ===============================
SRC_DIRS := $(subst \,/,$(SRC_DIRS))
TEST_DIRS := $(subst \,/,$(TEST_DIRS))

# ===============================
# Search for all the .c inside 
# the src directories
# ===============================
SRC_FILES  = $(foreach d,$(SRC_DIRS),$(wildcard $(d)/*.c))
TEST_FILES = $(foreach d,$(TEST_DIRS),$(wildcard $(d)/test_*.c))

# ===============================
# Automatic Includes
# ===============================
CFLAGS += $(foreach dir,$(SRC_DIRS), -I$(dir))
CXXFLAGS += $(foreach d,$(SRC_DIRS), -I$(d))

# ===============================
# Outputs
# ===============================
TARGET       = $(BUILD_DIR)/main$(EXE_EXT)
TEST_TARGET  = $(BUILD_DIR)/tests$(EXE_EXT)

# ===============================
# Object files
# ===============================
OBJ_SRC  = $(patsubst %.c,$(OBJ_DIR)/%.o,$(SRC_FILES))
OBJ_TEST = $(patsubst %.c,$(OBJ_DIR)/%.o,$(TEST_FILES))

# ===============================
# Create directories automatically
# ===============================
BUILD_DIR     = build
OBJ_DIR       = $(BUILD_DIR)/obj
COVERAGE_DIR  = $(BUILD_DIR)/coverage

# Ensure build dirs exist before compiling
.dirs:
	$(MKDIR) $(BUILD_DIR)
	$(MKDIR) $(OBJ_DIR)
	@for d in $(SRC_DIRS); do \
		$(MKDIR) "$(OBJ_DIR)/$$d"; \
	done
	@for d in $(TEST_DIRS); do \
		$(MKDIR) "$(OBJ_DIR)/$$d"; \
	done

# =================================
# Build rules
# =================================
all: .dirs $(TARGET)

$(TARGET): $(OBJ_SRC)
	$(CC) $(CFLAGS) $(OBJ_SRC) -o $(TARGET)
	@echo ==== Compilation completed: $(TARGET) ====

$(OBJ_DIR)/%.o: %.c | dirs
	$(CC) $(CFLAGS) -c $< -o $@

# =================================
# Build tests (no main.cpp)
# =================================
tests: .dirs $(OBJ_SRC) $(OBJ_TEST)
	$(CC) $(CFLAGS) \
		$(filter-out $(OBJ_DIR)/$(MAIN:.c=.o),$(OBJ_SRC)) \
		$(OBJ_TEST) -o $(TEST_TARGET)
	@echo ==== Tests built: $(TEST_TARGET) ====

# =================================
# Run tests
# =================================
run-tests: tests
	@echo ==== Executing tests ====
	@./$(TEST_TARGET)

# ===============================
# Valgrind (Linux only)
# ===============================
valgrind: tests
	@echo ==== Running under Valgrind ====
	valgrind --leak-check=full ./$(TEST_TARGET)

# ===============================
# Coverage (gcov + gcovr)
# ===============================
coverage:
	@echo ==== Generating coverage ====
	$(MAKE) clean
	$(MAKE) CXXFLAGS="$(CXXFLAGS) -fprofile-arcs -ftest-coverage" tests
	./$(TEST_TARGET)
	gcovr --html-details --output $(COVERAGE_DIR)/coverage.html
	@echo ==== Coverage report generated ====

# =================================
# Run main application
# =================================
run: $(TARGET)
	@echo ==== Running Application ====
	@./$(TARGET)

# =================================
# Clean everything
# =================================
clean:
	@echo ==== Cleaning build directory ====
	-$(RM) $(TARGET)
	-$(RM) $(TEST_TARGET)
	-$(RM) $(BUILD_DIR)$(PATHSEP)*.gcno
	-$(RM) $(BUILD_DIR)$(PATHSEP)*.gcda
	-$(RM) $(BUILD_DIR)$(PATHSEP)*.gcov
	-$(RM) $(OBJ_DIR)$(PATHSEP)*.o

