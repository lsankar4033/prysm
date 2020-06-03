FROM gcr.io/prysmaticlabs/build-agent AS builder

WORKDIR /workspace
COPY . /workspace/.

RUN bazel build --define ssz=minimal //beacon-chain

FROM gcr.io/whiteblock/base:ubuntu1804

COPY --from=builder /workspace/bazel-bin/beacon-chain/linux_amd64_stripped/beacon-chain .
COPY scripts/minimal_beacon_runner.sh run.sh

ENTRYPOINT ["./run.sh"]
