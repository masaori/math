# SageMath Check: int_absolute_value_of_product_with_nonnegative

## 対象

**対象ラベル**: `int_absolute_value_of_product_with_nonnegative` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_integer_absolute_value_of_product_with_nonnegative`（`x, y ∈ ℤ`、`0_ℤ ≤ y` なら `|x·y| = |x|·y`）
- 範囲: 主張と、証明の場合分けの全ての鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `0 ≤ x` の場合（`0 ≤ xy`、鎖 `|xy| = xy = |x|y`） | `check_proof_lines.sage` | 絶対値を `def_int_absolute_value` の場合分けで自前に定義し、`x ∈ −30..30`・`y ∈ 0..30` のうち `0 ≤ x` の全ての組で、`0 ≤ xy` と鎖の全ての行が等しいことを確かめる | **PASS** | 961 件 |
| `¬(0 ≤ x)` の準備（`|x|y = (−x)y = −(xy)`、`0 ≤ |x|y = −(xy)`） | 同上 | `x < 0` の全ての組で、鎖の全ての行が等しく、`0 ≤ |x|`・`0 ≤ |x|y`・`0 ≤ −(xy)` であること | **PASS** | 930 件 |
| `¬(0 ≤ x)` かつ `¬(0 ≤ xy)` の鎖 `|xy| = −(xy) = |x|y` | 同上 | その枝に入る全ての組で全ての行が等しいこと | **PASS** | 900 件 |
| `¬(0 ≤ x)` かつ `0 ≤ xy` の鎖（`xy = 0 + xy ≤ (−(xy)) + xy = 0`、反対称律で `xy = 0`、`|xy| = xy = 0 = xy + (−(xy)) = 0 + (−(xy)) = −(xy) = |x|y`） | 同上 | その枝に入る全ての組（`y = 0` のとき）で、`≤` の段と全ての等号が成り立つこと。代数の段（`(−x)y = −(xy)`、和の単位元、加法の逆元）は `ZZ[x, y]` で恒等的に確かめる | **PASS** | 30 件、恒等式 4 つ |
| 主張 `|xy| = |x|y` | 同上 | 全ての組で成り立ち、自前の絶対値が Sage の `abs` と一致すること。どの枝にも標本が入ったこと | **PASS** | 1,891 件 |
| 否定コントロール | 同上 | 仮定 `0 ≤ y` を外した組（`x = 2, y = −3`）で主張が崩れる。準備の鎖で `|x|` を `x` に取り違えると `(−x)y` と一致しない | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: 整数 `ZZ` と多項式環 `ZZ[x, y]` だけで計算した。浮動小数点は使わない。
- 範囲外: `|x| > 30`、`y > 30`。検算は式変形の書き間違いの裏取りであり、証明ではない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh int_absolute_value_of_product_with_nonnegative
```

実行ログは `logs/` に保存する（2026-11-23、SageMath 10.9）。
