# SageMath Check: finite_sum_with_single_nonzero_term

## 対象

**対象ラベル**: `finite_sum_with_single_nonzero_term` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_finite_sum_with_single_nonzero_term`（一つの項のほかが 0 の有限和はその項に等しい）
- 範囲: 主張と、帰納法の三つの鎖（`m = 1`、`n = m+1`、`n ≤ m`）

## 証明の行との対応

| 証明の行 | ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|---|
| 三つの鎖の各行 | `check_induction_lines.sage` | 第 `n` 項を `QQ` 上の不定元 `z` に、他の項を 0 に置く。有限和は `def_finite_sum_of_complex_numbers` の帰納法どおり左から足す経路と Sage の `sum` で作る。`n ≤ m` では帰納法の仮定も確かめる。対照として、0 でない項が二つあれば成り立たないこと | **PASS** | `m = 1,…,10` のすべての `n`（55 通り） |

## 計算の帰属と範囲

不定元の多項式の等号は厳密に決まり、任意の複素数を代入しても保たれる。浮動小数点はない。一般の `m` は人手証明の帰納法が担う。

## 実行方法

```bash
bash sagemath/tools/run-all-checks.sh finite_sum_with_single_nonzero_term
```
