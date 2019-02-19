def Settings( **kwargs ):
  return {
      'flags': [ '-x', 'c++', \
          '-Wall', '-Wextra', '-Werror', \
          '-std=c++17', '-pthread', \
          '-fexceptions', \
          '-isystem', '/usr/local/lib/gcc/x86_64-pc-linux-gnu/8.2.0/include', \
          '-I', 'src', \
          '-I', 'include', \
          '-isystem', '/usr/include', \
          '-isystem', '/usr/local/include',],
  }
