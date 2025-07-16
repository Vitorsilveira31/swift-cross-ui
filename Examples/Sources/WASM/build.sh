#!/bin/bash
set -e

swift package --swift-sdk swift-6.2-DEVELOPMENT-SNAPSHOT-2025-07-09-a_wasm js --use-cdn
npx serve