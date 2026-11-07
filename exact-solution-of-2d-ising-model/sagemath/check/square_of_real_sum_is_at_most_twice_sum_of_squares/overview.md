# SageMath Check: square_of_real_sum_is_at_most_twice_sum_of_squares

## 対象

**対象ラベル**: `square_of_real_sum_is_at_most_twice_sum_of_squares` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_00_09.ts`
- ブロック: `calc_formulae_claim_square_of_real_sum_is_at_most_twice_sum_of_squares`（`(a + b)^2 ≤ 2a^2 + 2b^2`）
- 範囲: 証明の準備 `0 ≤ (a - b)^2` と 4 行の鎖（主張の左辺から右辺まで）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 鎖の等号 3 行 | `check_proof_lines.sage` | `QQ[a, b]` の多項式として等しいことを確かめる。3・4 行目は乗法の可換性を使わないので、非可換な多項式環 `QQ<a, b>`（`FreeAlgebra`）でも確かめる | **PASS** | 成り立つ |
| 鎖の 4 行と主張 | `check_proof_lines.sage` | QQ と AA の 11 点の全ての組（121 組）で、準備・等号 3 行・不等号 1 行・主張を厳密に。等号が `a = b` のときだけであることも確かめる | **PASS** | 成り立つ |

## 計算の帰属と範囲

- **厳密**: QQ・AA の点と QQ 係数の多項式で計算した。浮動小数点は使わない。
- 範囲外: 不等号の行は選んだ点だけで確かめた。点での検算は証明ではなく、式変形の書き間違いの裏取りである。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh square_of_real_sum_is_at_most_twice_sum_of_squares
```

実行ログは `logs/` に保存する（2026-11-07）。
