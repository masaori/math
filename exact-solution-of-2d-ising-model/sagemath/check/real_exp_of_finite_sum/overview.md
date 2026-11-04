# SageMath Check: real_exp_of_finite_sum

## 対象

**対象ラベル**: `real_exp_of_finite_sum` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/003_exp_linear_map.ts`
- ブロック: `exp_linear_map_claim_real_exp_of_finite_sum`（実数の有限和の exp は exp の有限積）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `m = 1` の 2 行（`def_finite_sum_of_real_numbers` → `def_finite_product_of_real_numbers` を右辺から左辺へ）と、`m → m+1` の 4 行（`def_finite_sum_of_real_numbers` → `scalar_exp_product` を右辺から左辺へ → 帰納法の仮定 → `def_finite_product_of_real_numbers` を右辺から左辺へ） | `check_chain.sage` | 有理数の組 6 通りを `x_j` に置き、`m = 1` と `m = 1,…,6` の `m → m+1` で隣り合う行の球が交わる。和・積は定義どおり左から畳み込む。帰納法の仮定の行は `m` 個の場合を先に確かめる。2 行目の `exp(a + b)` を `exp(a) + exp(b)` に壊すと交わらない否定コントロールも見る | **PASS** | 192 個の等号を確かめた。否定コントロール 36 件 |

## 計算の帰属と範囲

`x_j` は有理数で与えるが、`exp` の値は ℝ への脱出なので、区間演算 `RealBallField(200)` の球で扱った（丸めの誤差を球の半径に含め、真の値を必ず囲む）。等号の行は球が共通部分を持つことで確かめ、半径が `1e-40` 未満であることも確かめた。

## 確かめられない行と理由

1 行目と 2 行目（和の定義）、最後の 2 行（積の定義）は、検算でも定義どおりに畳み込んだ値どうしなので同語反復である。実質の比較は `scalar_exp_product` の行と帰納法の仮定の行である。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh real_exp_of_finite_sum
```

実行ログは `sagemath/check/real_exp_of_finite_sum/logs/` に保存する。
