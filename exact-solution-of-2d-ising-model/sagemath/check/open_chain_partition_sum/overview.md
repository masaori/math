# SageMath Check: open_chain_partition_sum

## 対象

**対象ラベル**: `open_chain_partition_sum`

- ファイル: `structured-latex/content/eigenvalue_problem_eigenvector_of_max_eigenvalue.ts`
- ブロック: `closing_005_claim_open_chain_partition_sum`（Σ_{s∈𝔐} exp(KE(s)) = 2(2cosh K)^{M_col−1}、K ∈ ℝ）
- 範囲: Step 1（全単射 Φ と復元、ς と成分ごとの写像の全単射）、Step 2 の準備の鎖（3 行）、主張の鎖（10 行）の全ての行と主張。

## 組み方

共通の準備は `sagemath/_shared/open_chain_spin_sums.sage`。

- 組合せの層: exp(K)・exp(−K) を、関係を持たない `QQ[x, y]` の不定元 x・y に置き（exp(Kτ) は τ = 1 で x、τ = −1 で y）、
  主張の鎖の付け替え・積の展開・二元集合の和・cosh の定義・冪の行を多項式の等式として厳密に確かめる。M_col = 2..8 の全ての配置。
- 実数の層: exp の値は ℝ への脱出なので `RealBallField(200)` の球で持ち、準備の鎖と主張の鎖の全ての行を、
  M_col = 2..7、K ∈ {1/3, 1, 5/2, −7/4, 0, 1/100, 6, −2/9} で確かめる。等号は球が交わること、半径が値の 1e-40 倍未満であること。
- 付け替えた後の和（2 行目）は、Φ を通さず {−1,1} × {−1,1}^{M_col−1} を直に列挙して組む（1 行目は 𝔐 を列挙して組む）。
- ς で付け替えた和（3 行目）は {0,1}^{M_col−1} の上の和を def_sum_over_binary_words_of_real_numbers の帰納法の順序（`binword_sum`）で組む。
- 組合せの層では exp(Kς(e))・exp(K·1)・exp(K·(−1)) がどれも x か y になるので、「ς の値」「a·1 = a」「a(−1) = −a」の三行は実数の層だけで隣の行と別に組んで確かめる。
- 有限積は def_finite_product_of_real_numbers の左からの畳み込み、冪の行の右辺は Sage の `^`（別の経路）。
- 主張は右辺を Sage の `cosh`（def_cosh_sinh とは別の経路）でも確かめる。

## 証明の行との対応

| 証明の行 | 確かめ方 |
|---|---|
| Step 1: Φ は全単射（単射・全射・復元が左右の逆）、両側は 2^{M_col} 個、s(m+1) = s(m)τ ⟺ τ = s(m)s(m+1) | 厳密（ZZ）。M_col = 2..8 の全ての元 |
| Step 1: ς(1) = 1・ς(0) = −1、逆写像 τ ↦ (τ+1)/2、成分ごとの写像 {0,1}^{M_col−1} → {−1,1}^{M_col−1} が全単射 | 厳密。M_col = 2..8 |
| 準備 1 行目（def_open_chain_spin_energy と t_m(s)） | 整数の等式 E(s) = Σ t_m(s) を厳密に、行の両辺を球で |
| 準備 2 行目（ℝ の分配則） | 球 |
| 準備 3 行目（real_exp_of_finite_sum） | 球 |
| 主張の鎖 1 行目（準備の等式を各項へ） | 球（左辺が exp の値なので組合せの層には載らない） |
| 主張の鎖 2 行目（Φ による和の付け替え） | 厳密と球 |
| 主張の鎖 3 行目（ς による内側の和の付け替え） | 厳密と球 |
| 主張の鎖 4 行目（expansion_of_finite_product_of_two_term_sums_of_real_numbers） | 厳密と球 |
| 主張の鎖 5 行目（ς(1) = 1、ς(0) = −1） | 球 |
| 主張の鎖 6 行目（a·1 = a） | 球 |
| 主張の鎖 7 行目（a(−1) = −a） | 球 |
| 主張の鎖 8 行目（u に依らない c の二元集合上の和 c + c = 2c） | 厳密と球 |
| 主張の鎖 9 行目（def_cosh_sinh） | 厳密と球 |
| 主張の鎖 10 行目（冪の定義） | 厳密と球 |
| 主張 | 球。右辺は Sage の cosh |

否定コントロール（種類ごとに外れる件数を確かめる）: 準備 3 行目を「exp の和」に壊すと M_col = 3..7 の全ての配置と K で外れる（1984 件）、主張の冪を M_col にすると外れる（7 件）、cosh を sinh にすると外れる（厳密 7 件、球 42 件）。

浮動小数点（球）を使うのは exp の値を含む行だけである（ℝ への脱出）。証明は M_col ∈ ℤ_{≥2}・K ∈ ℝ の全てについてのものだが、検算は上の範囲に限る。

## 結果

| ファイル | 検査内容 | ステータス | 結果 |
|---|---|---|---|
| `check_chain.sage` | Step 1、準備と主張の鎖の全ての行、主張、否定コントロール | 実行済み | PASS（8709 件、否定コントロール 2040 件） |

## 実行方法

```sh
bash sagemath/tools/run-all-checks.sh open_chain_partition_sum
```
