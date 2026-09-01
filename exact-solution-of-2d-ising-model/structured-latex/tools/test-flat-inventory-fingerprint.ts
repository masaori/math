import blocks from "../content/002_linear_space_general.ts";
import {
  assertReviewedContentFingerprint,
  centralizerIsScalarExpectedSha256,
  contentFingerprint,
} from "./reviewed-content-fingerprint.ts";

const entryId = "linear_space_general_004_lemma_centralizer_is_scalar";
const block = blocks.find((candidate) => candidate.id === entryId);

if (block === undefined) {
  throw new Error(`回帰対象の外部入力本文がありません: ${entryId}`);
}

const inspected = JSON.stringify({
  title: block.title,
  statement: block.statement,
  proof: block.proof,
});
const actualSha256 = contentFingerprint(inspected);
assertReviewedContentFingerprint(entryId, actualSha256, centralizerIsScalarExpectedSha256);

for (const [name, mutatedInspected, mutatedExpected] of [
  ["本文変異", contentFingerprint(`${inspected}\n`), centralizerIsScalarExpectedSha256],
  ["期待値変異", actualSha256, `0${centralizerIsScalarExpectedSha256.slice(1)}`],
] as const) {
  let rejected = false;
  try {
    assertReviewedContentFingerprint(entryId, mutatedInspected, mutatedExpected);
  } catch {
    rejected = true;
  }
  if (!rejected) {
    throw new Error(`回帰対象の${name}を生成器と共通の検査関数が拒否しませんでした: ${entryId}`);
  }
}

console.log(`棚卸し外部入力 fingerprint 回帰テスト: PASS (${entryId})`);
