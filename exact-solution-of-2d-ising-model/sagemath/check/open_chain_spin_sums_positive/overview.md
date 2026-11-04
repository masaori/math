# SageMath Check: open_chain_spin_sums_positive

## 対象

**対象ラベル**: `open_chain_spin_sums_positive`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
- ブロック: `closing_005_claim_open_chain_spin_sums_positive`（K ∈ ℝ_{>0} で二つの開鎖のスピン和は正）
- 範囲: 準備の鎖（6 行）、二つの鎖（各 3 行）の全ての行と、主張。

## 組み方

共通の準備は `sagemath/_shared/open_chain_spin_sums.sage`。

- 2 行目（冪を有限積に開く）は `QQ[x, y]` で cosh・sinh を (x ± y)/2 に置いて厳密に、M_col = 2..8。
- 1 行目・2 行目の値と 3 行目の不等号は `RealBallField(200)` の球で、M_col = 2..7、K ∈ {1/3, 1, 5/2, 1/100, 6, 1/1000}。
  不等号は球の下端が 0 より大きいこと（球の `> 0` が真）で確かめる。左辺の和は 𝔐 を列挙して直接組む。
- 3 行目の根拠: cosh K > 0（cosh_sinh_basic_properties (1)）、sinh K > 0（同 (3)）、2cosh K > 0・2sinh K > 0、
  M_col − 1 個の因子の有限積が正（finite_product_of_positive_reals_is_positive）、2 倍が正、を一つずつ確かめる。

## 証明の行との対応

| 証明の行 | 確かめ方 |
|---|---|
| 準備の鎖 6 行（cosh K > 0・2cosh K > 0・sinh K > 0・2sinh K > 0・二つの有限積 > 0） | 球の下端 |
| 二つの鎖の 1 行目（open_chain_partition_sum・open_chain_endpoint_product_sum） | 球 |
| 二つの鎖の 2 行目（冪の定義） | 厳密（QQ[x,y]）と球 |
| 二つの鎖の 3 行目（> 0） | 球の下端 |
| 主張 | 球の下端 |

否定コントロール: K > 0 を外し K ∈ {−1/3, −2}、M_col ∈ {2, 4, 6}（M_col − 1 が奇数）とすると、端点因子のある和は負になる（6 件）。
端点因子の無い和は K < 0 でも正であることも確かめる。

浮動小数点（球）を使うのは exp の値を含む行だけである（ℝ への脱出）。検算は上の範囲に限る。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_chain.sage` | 二つの鎖の全ての行、根拠、主張、否定コントロール | 実行済み | PASS（524 件、否定コントロール 6 件） |

## 実行方法

```sh
bash sagemath/tools/run-all-checks.sh open_chain_spin_sums_positive
```
