# SageMath Check: finite_product_of_real_numbers_splits_off_first_factor

## 対象

**対象ラベル**: `finite_product_of_real_numbers_splits_off_first_factor`

- ファイル: `structured-latex/content/000_calculation_formulae_20_29.ts`
- ブロック: `calculation_formulae_claim_finite_product_of_real_numbers_splits_off_first_factor`（m ∈ ℤ_{≥1}、r_1, …, r_{m+1} ∈ ℝ について Π_{j=1}^{m+1} r_j = r_1(Π_{j=1}^{m} r_{j+1})。有限積は `def_finite_product_of_real_numbers`）
- 範囲: 証明の m = 1 の 3 行と、帰納法の段の 4 行の全て。

## 証明の行との対応

| 証明の行 | 検算 | 確かめ方 |
|---|---|---|
| m = 1 の 3 行（`def_finite_product_of_real_numbers` の帰納の式（m → 1）、同じ定義の Π_{j=1}^{1} r_j := r_1、同じ式（r_j → r_{j+1}）を右辺から左辺へ） | `check_induction_chains.sage` | 厳密 |
| 帰納法の段の 4 行（定義の帰納の式（m → m+1）、帰納法の仮定、ℝ の乗法の結合則（`set_and_algebra_notation`）、定義の帰納の式（r_j → r_{j+1}）を右辺から左辺へ） | `check_induction_chains.sage` | 厳密。帰納法の仮定が前の段の鎖の結論（最初の木と最後の木）であることを木で確かめる |

確かめ方は二つ。鎖は m = 1 の 3 行と帰納法の段 k = 1..7 の 4 行ずつで、各段を一度だけ確かめる。浮動小数点は使わない。

- 行ごとの根拠: 各行を、積を評価しない二分木で書く。定義の行は、比べる 2 行の木を読み、片方の木（または部分木）を定義の式で一段ほどくと
  もう片方と木が文字どおり一致すること（ほかの部分木は不変）を確かめる。帰納法の仮定の行は部分木を仮定の等式の右辺に差し替えると一致すること（仮定は前の段の鎖の結論であることも木で確かめる）、
  結合則の行は根で `(xy)t → x(yt)` を一回だけ書き換えると一致することを確かめる。
- 値: 木を QQ 上の非可換な自由代数（`FreeAlgebra`。結合則だけを持つ）で評価し、全ての行の値が等しいことを確かめる。
  可換則の成り立たない環で等号が立つので、証明が可換則を使わないことが分かる。

否定コントロール: 先頭の因子を右へ出した (Π_{j=1}^{m} r_{j+1}) r_1（可換則を使う誤り）と、添字をずらし忘れた r_1(Π_{j=1}^{m} r_j) は左辺と外れる（m = 1..8 の主張それぞれに 2 件。2 件は m = 1 でも別の値になる）。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_induction_chains.sage` | m = 1 と帰納法の段（k = 1..7）の全ての行 | 実行済み | PASS（31 行、否定コントロール 16 件（m = 1..8 の主張それぞれに 2 件）） |

## 実行方法

```sh
bash sagemath/tools/run-all-checks.sh finite_product_of_real_numbers_splits_off_first_factor
```
