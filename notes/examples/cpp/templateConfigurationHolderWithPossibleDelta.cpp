#include <optional>

template <template <typename> typename Field> struct Config {
  Field<int> a;
  Field<int> b;
};

template <typename T> struct Static {
  T value;
  T &operator->() { return value; }

  Static<T> &operator=(const T &t) {
    value = t;
    return *this;
  }
};

int main() {

  Config<Static> c;
  c.a = 1;
  c.b = 2;

  Config<std::optional> delta;

  delta.b = 3;
}
