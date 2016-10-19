{
  "targets": [
    {
      "target_name": "lapse",
      "type": "static_library",
      "dependencies": [
        "gearsbox/gearsbox.gyp:gearsbox"
      ],
      "sources": [
        "<!@(python ./gearsbox/deps/djinni/example/glob.py ./generated-src/cpp   '*.cpp' '*.hpp' '*.h')",
        "<!@(python ./gearsbox/deps/djinni/example/glob.py ./src/cpp '*.cpp' '*.hpp' '*.c' '*.h')",
        "<!@(python ./gearsbox/deps/djinni/example/glob.py ./interface '*.hpp' '*.h')",
      ],
      "include_dirs": [
        "generated-src/cpp",
        "src/cpp",
        'gearsbox/src/cpp/ui',
      ],
    },
    {
    "target_name": "lapse_objc",
      "type": "static_library",
      "dependencies": [
        "lapse",
        "gearsbox/gearsbox.gyp:gearsbox_objc"
      ],
      "sources": [
        "<!@(python ./gearsbox/deps/djinni/example/glob.py ./generated-src/objc  '*.cpp' '*.h' '*.mm' '*.m')",
      ],
      "include_dirs": [
        "generated-src/objc",
        "generated-src/cpp",
        "src/cpp",
        "gearsbox/deps/djinni/support-lib/objc",
        'gearsbox/src/cpp/ui',
      ],
    },
    {
      "target_name": "lapse_jni",
      "type": "static_library",
      "dependencies": [
        "lapse",
        "./gearsbox/gearsbox.gyp:gearsbox_jni"
      ],
      "ldflags" : [ "-llog", "-Wl,--build-id,--gc-sections,--exclude-libs,ALL" ],
      "sources": [
        "<!@(python ./gearsbox/deps/djinni/example/glob.py ./generated-src/jni   '*.cpp')",
      ],
      "include_dirs": [
        "generated-src/jni",
        "generated-src/cpp",
        "src/cpp",
        "./gearsbox/deps/djinni/support-lib/jni",
      ],
    },
    {
      'target_name': 'gtest',
      'type': 'executable',
      'dependencies': [
        'lapse',
        "gearsbox/gearsbox.gyp:gtest",
        'gearsbox/deps/gtest.gyp:gtest',
      ],
      'cflags_cc!': [ '-Werror', '-Wextra' ],
      'xcode_settings': {
        'OTHER_CPLUSPLUSFLAGS!' : ['-Werror', '-Wextra'],
      },
      'include_dirs': [
        '.',
        'gtest',
      ],
      "defines": [
        'TEST_STAND_ALONE',
        'GEARSBOX_TEST',
      ],
      'sources': [
        '<!@(python gearsbox/deps/djinni/example/glob.py gtest *.cpp *.hpp *.h)',
      ]
    },
    {
      'target_name': 'test',
      'type': 'executable',
      'dependencies': [
        'lapse',
        "gearsbox/gearsbox.gyp:test",
      ],
      'cflags_cc!': [ '-Werror', '-Wextra' ],
      'xcode_settings': {
        'OTHER_CPLUSPLUSFLAGS!' : ['-Werror', '-Wextra'],
      },
      'include_dirs': [
        '.',
      ],
      "defines": [
        
      ],
      'sources': [
        '<!@(python gearsbox/deps/djinni/example/glob.py test *.cpp *.hpp *.h)',
      ]
    },
  ],
}