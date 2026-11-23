# SageMath Check: int_absolute_value_zero_implies_zero

## 対象

**対象ラベル**: `int_absolute_value_zero_implies_zero` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_integer_absolute_value_zero_implies_zero`（`x ∈ ℤ` について `|x| = 0 ⇒ x = 0`）
- 範囲: 主張と、証明の二つの場合の鎖

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| `0 ≤ x` の場合の鎖 `x = |x| = 0` | `check_proof_lines.sage` | 1 段目（`def_int_absolute_value` の場合分けの式）は整数 `0..40` の全ての標本、2 段目（主張の仮定）は仮定を満たす標本 | **PASS** | 41 件・1 件 |
| `¬(0 ≤ x)` の場合の準備 `−x = |x| = 0` と鎖 `x = x + 0 = x + (−x) = 0` | 同上 | 場合分けの式・和の単位元・加法の逆元は整数 `−40..−1` の全ての標本と `ZZ[x]` の恒等式。仮定から出る `−x = 0` を使う段は `ZZ[x, nx]`（`nx` は `−x`）でイデアル `(nx)` への所属 | **PASS** | 標本 40 件（各 2 確認）、厳密 3 段 |
| 主張 `x = 0` | 同上 | 整数 `−40..40` で仮定 `|x| = 0` を満たすのが `x = 0` だけであること | **PASS** | 81 件 |
| 否定コントロール | 同上 | `−x = 0` を使わずに `x + 0 = x + (−x)` が出ない。場合分けの二つ目の式を `0` にすると主張が崩れる | **PASS** | 2 件 |

## 計算の帰属と範囲

- **厳密**: `ZZ`、多項式環 `ZZ[x]` の恒等式、多項式環 `ZZ[x, nx]` のイデアルの所属判定だけで計算した。浮動小数点は使わない。
- 範囲外: 整数では仮定 `|x| = 0` を満たすのが `x = 0` だけなので、`¬(0 ≤ x)` の場合の鎖のうち仮定を使う段は、
  標本ではなく多項式環での所属の判定だけが確かめている。検算は式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh int_absolute_value_zero_implies_zero
```

実行ログは `logs/` に保存する（2026-11-23、SageMath 10.9）。
