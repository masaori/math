# 積差四十八をもつ双曲正則型の分類の検算

**対象ラベル**: `theorem_product_difference_forty_eight_hyperbolic_types`
- 対象: 正整数の因数対から面次数と頂点次数を復元する有限分類
- 記号の所属: 因数と次数は `NN`、積差は標準単射で `ZZ` に移して計算する

| 検算 | 状態 | 結果 |
| --- | --- | --- |
| 正の因数対 | PASS | `48` の正の順序付き因数対は `(1,48),(2,24),(3,16),(4,12),(6,8),(8,6),(12,4),(16,3),(24,2),(48,1)` に限る |
| 次数対の復元 | PASS | 各成分へ `2` を加えると `(3,50),(4,26),(5,18),(6,14),(8,10),(10,8),(14,6),(18,5),(26,4),(50,3)` を得る |
| 双曲不等式 | PASS | 復元した全次数対で自然数不等式 `2(p+q)<pq` |
| 整数積差 | PASS | 復元した全次数対で `(p-2)(q-2)=48` |

## 実行履歴

- 2026-08-25: 四つの検算を実行し、すべて PASS。
- 2026-08-25: 共通規約のルート相対例にある `structured-latex/tools/validate-content.mjs`、`structured-latex/tools/verify-no-lost-proofs.mjs`、`sagemath/tools/verify-check-linkage.mjs` をリポジトリ直下から実行し、三ファイルが存在しないため `MODULE_NOT_FOUND` で ERROR。対象プロジェクトの正本コマンドである `npm run check` と `sagemath/tools/verify-check-linkage.ts` は PASS。

## 実行コマンド

```sh
for f in countable-ising-on-hyperbolic-surfaces/sagemath/check/product-difference-forty-eight-hyperbolic-types/*.sage; do
  sage "$f"
done
```
