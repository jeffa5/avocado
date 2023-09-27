#!/usr/bin/env sh

set -eu

if [ $1 == "virtual" ]; then
  scone=ON
elif [ $1 == "sgx" ]; then
  scone=OFF
fi

mkdir -p build
cd build
cmake .. -DSCONE=$scone
cmake --build . --parallel

mkdir /app
mv src/server /app/.
mv src/client /app/.

rm -rf /build
