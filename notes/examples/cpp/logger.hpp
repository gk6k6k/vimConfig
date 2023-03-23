#include <iostream>

template <typename... Ts> void __lcp(const char *file, int line, Ts &&...args) {
  std::cout << "==>" << file << ":" << line;
  using expander = int[];
  (void)expander{0, (void(std::cout << ' ' << std::forward<Ts>(args)), 0)...};
  std::cout << std::endl;
}

#define log(...) __lcp(__FILE__, __LINE__, __VA_ARGS__)
