# SageMath Check: int_less_than_one_of_product_less_than_nonnegative_factor

## 対象

**対象ラベル**: `int_less_than_one_of_product_less_than_nonnegative_factor` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_integer_less_than_one_of_product_less_than_nonnegative_factor`（`x, c ∈ ℤ`、`0_ℤ ≤ c`、`x·c < c` なら `x < 1_ℤ`）
- 範囲: 主張と、証明の場合分けの全ての鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 主張の仮定 `x·c < c` を `def_int_strict_order` で `x·c + 1 ≤ c` に書き直す | `check_proof_lines.sage` | `x ∈ −30..30`・`c ∈ 0..30` の全ての組で二つが同値であること | **PASS** | 1,891 件 |
| `x = n + 1`（`0 ≤ n`）の側の `0 ≤ n·c` と鎖 `c = 0 + c ≤ n·c + c = n·c + 1·c = (n + 1)·c = x·c` | 同上 | `x ≥ 1` の全ての組で鎖の全ての段が成り立ち、仮定 `x·c < c` が成り立たないこと。等号の段の根拠（和の単位元・乗法の単位元・分配律）は `ZZ[n, c]` で恒等的に確かめる | **PASS** | 930 件、恒等式 3 つ |
| 鎖 `1 = 0 + 1 = ((−c) + c) + 1 = (−c) + (c + 1) = (c + 1) + (−c)`、`c + (−c) = 0` の等号 | 同上 | `ZZ[n, c]` で恒等的に成り立つこと（仮定を満たす標本はこの枝に入らない） | **PASS** | 恒等式 5 つ |
| `x ≤ 0` の場合（`x = 0` を含む）と最後の鎖 `x + 1 ≤ 0 + 1 = 1`、主張 `x < 1` | 同上 | 仮定を満たす全ての組で `x ≤ 0`、鎖の段、主張が成り立ち、`x ≤ 0` と `x = 0` の枝に標本が入ったこと | **PASS** | 930 件（うち `x = 0` が 30 件） |
| 否定コントロール | 同上 | 仮定 `0 ≤ c` を外した組（`x = 2, c = −1`）と、`<` を `x + 1 ≤ y` と読んだ有理数（0 以上の元の分解だけが成り立たない）の組 `x = 1/2, c = 2` で主張が崩れる | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: 整数 `ZZ`、有理数 `QQ`（否定コントロールだけ）と多項式環 `ZZ[n, c]` で計算した。浮動小数点は使わない。
- 範囲外: `|x| > 30`、`c > 30`。検算は式変形の書き間違いの裏取りであり、証明ではない。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh int_less_than_one_of_product_less_than_nonnegative_factor
```

実行ログは `logs/` に保存する（2026-11-23、SageMath 10.9）。
