#! /usr/bin/env bash

base_dir=$(cd "`dirname "0"`" && pwd)
cpp_out="$base_dir/generated-src/cpp"
cpp_extended="$base_dir/src/"
jni_out="$base_dir/generated-src/jni"
objc_out="$base_dir/generated-src/objc"
java_out="$base_dir/generated-src/java/dyno/fun/lapse"
yaml_out="$base_dir/generated-src/yaml"
java_package="dyno.fun.lapse"
namespace="lpase"
objc_prefix="LPA"
djinni_file="djinni/lapse.djinni"
 
gearsbox/deps/djinni/src/run \
   --java-out $java_out \
   --java-package $java_package \
   --ident-java-field mFooBar \
   \
   --cpp-out $cpp_out \
   --cpp-namespace $namespace \
   --cpp-optional-template "std::experimental::optional" \
   --cpp-optional-header "<experimental/optional>" \
   \
   --jni-out $jni_out \
   --ident-jni-class NativeFooBar \
   --ident-jni-file NativeFooBar \
   \
   --objc-out $objc_out \
   --objc-type-prefix $objc_prefix \
   \
   --objcpp-out $objc_out \
   \
   --yaml-out "$yaml_out/yaml" \
   --yaml-out-file "yaml-lapse.yaml" \
   --yaml-prefix "lapse_" \
   \
   --idl $djinni_file