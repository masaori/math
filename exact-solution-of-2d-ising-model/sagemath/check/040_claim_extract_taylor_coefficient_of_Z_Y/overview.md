# SageMath Check: 040_claim_extract_taylor_coefficient_of_Z_Y

## 対象

**対象ラベル**: `extract_taylor_coefficient_of_Z_Y` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/008_TV1_hatZ_hatY_part1.mjs`（ブロック `TV1_hatZ_hatY_005_claim_extract_taylor_coefficient`）
- 併せて検証:
  - `cosh_sinh_coefficient_conversion`（ブロック `TV1_hatZ_hatY_003_claim_cosh_sinh_coefficient_conversion`、生成子をスケールした n 重交換子）
  - `commutator_of_H_and_Z_Y`（ブロック `TV1_hatZ_hatY_001_claim_commutator`、土台となる 1 重交換子 (A)〜(D)）

### 何を確定させるための検証か

原文（`_old/typst/parts/008_.../004_claim_テイラー係数の抽出.typ`）の proof は、(h1.z) だけが
cosh/sinh まで到達しており、(h1.y) と (h2.z−) は偶奇分割の途中で終わっているうえ、cases 内の
項・係数が同じ原文の statement と食い違っていた（(h2.y) には proof が無かった）。

**statement と proof のどちらが誤りか**を数値的に確定させ、proof 側を直すためにこの検証を置く。
結論は「statement が正しく、proof の cases 表式が誤植」である（check_04 参照）。

## 検証の枠組み

`sagemath/_shared/spin_ops.sage` で `Mat(2,C)^{⊗M}` 上の演算子を**明示的な複素行列**として構成する。

| 記号 | 構成 |
|---|---|
| `Z_m` | `sigma_1^x ... sigma_{m-1}^x sigma_m^z` |
| `Y_m` | `sigma_1^x ... sigma_{m-1}^x sigma_m^y` |
| `H_1^{(±)}` | `Y_1 Z_2 + ... + Y_{M-1} Z_M ∓ Y_M Z_1` |
| `H_2` | `Z_1 Y_1 + ... + Z_M Y_M` |
| `hatZ_mu^{(±)}` | `∓ Z_1 e^{-iθ} + Σ_{j=2}^M Z_j e^{-ijθ}`（`θ = 2πμ/M`） |
| `hatY_mu` | `Σ_{j=1}^M Y_j e^{-ijθ}` |

すなわち、証明で用いている交換子の代数関係を仮定せず、**定義に戻って行列で直接計算**する。
パラメータは `M = 3, 4, 5`、`μ ∈ calM = {-M,…,-1,1,…,M}` の全域、`(K1,K2)` は
`spin_ops.sage` の `SPIN_TEST_PARAMS`（臨界点上・高温極限付近を含む 4 組）。
`K_2^* := -1/2 log(tanh K_2)`。

## チェック一覧

| # | ファイル | 検証内容 | ステータス | 結果 |
|---|---------|---------|-----------|------|
| 01 | check_01_single_commutators.sage | 1 重交換子 (A)〜(D)（帰納法の土台） | PASS | 最大残差 3.1e-15 (tol=1e-9) |
| 02 | check_02_scaled_nested_commutators.sage | 生成子スケール後の n 重交換子 4 式（n=0..8） | PASS | 最大残差 2.0e-10 (tol=1e-8) |
| 03 | check_03_taylor_sums.sage | テイラー係数の抽出 4 式（級数は 40 次で打ち切り） | PASS | 最大残差 4.6e-14 (tol=1e-8) |
| 04 | check_04_original_typo_refuted.sage | 原文 proof の cases（誤植）が成り立たないこと | PASS | 誤植版の**最小**残差 1.2〜2.8（全 mu で不一致）、修正版の最大残差 1.6e-15 |

## 検証した式

check_02（`cosh_sinh_coefficient_conversion` の 4 式、修正・追加後の形）:

```
(h1.z)  ad^n_{(i/2)K1 H1^{(±)}}(hatZ_mu^{(±)}) = { i K1^n e^{-iθ} hatY_mu      (n 奇数)
                                                 {   K1^n hatZ_mu^{(±)}       (n 偶数)
(h1.y)  ad^n_{(i/2)K1 H1^{(±)}}(hatY_mu)       = { -i K1^n e^{iθ} hatZ_mu^{(±)} (n 奇数)
                                                 {    K1^n hatY_mu             (n 偶数)
(h2.z-) ad^n_{i K2* H2}(hatZ_mu^{(-)})         = { -i (2K2*)^n hatY_mu         (n 奇数)
                                                 {    (2K2*)^n hatZ_mu^{(-)}   (n 偶数)
(h2.y)  ad^n_{i K2* H2}(hatY_mu)               = {  i (2K2*)^n hatZ_mu^{(-)}   (n 奇数)
                                                 {    (2K2*)^n hatY_mu         (n 偶数)
```

check_03（`extract_taylor_coefficient_of_Z_Y` の statement そのもの）:

```
(h1.z)  Σ_n (1/n!) ad^n(hatZ_mu^{(±)}) = cosh(K1) hatZ_mu^{(±)} + i e^{-iθ} sinh(K1) hatY_mu
(h1.y)  Σ_n (1/n!) ad^n(hatY_mu)       = -i e^{iθ} sinh(K1) hatZ_mu^{(±)} + cosh(K1) hatY_mu
(h2.z-) Σ_n (1/n!) ad^n(hatZ_mu^{(-)}) = cosh(2K2*) hatZ_mu^{(-)} - i sinh(2K2*) hatY_mu
(h2.y)  Σ_n (1/n!) ad^n(hatY_mu)       = i sinh(2K2*) hatZ_mu^{(-)} + cosh(2K2*) hatY_mu
```

check_04（原文 proof が書いていた cases。**成り立たない**ことを確認する）:

```
(h1.y)  奇数項: i K1^n e^{iθ} hatY_mu     偶数項: K1^n hatZ_mu^{(±)}
(h2.z-) 奇数項: i (K2*)^n hatY_mu         偶数項: i (K2*)^n hatZ_mu^{(-)}
```

## 備考

- 一致判定は行列差の 1-ノルム、tol は 1e-8。実測の最大残差は check_02 の 2.0e-10
  （`K2 = 0.1` すなわち `2K2* = 2.31` で `(2K2*)^8 ≈ 8.2e2` となり絶対値が大きくなるケース）で、
  それ以外はおおむね 1e-14 以下。相対的には機械精度である。
- 不一致の判定（check_04）は「残差が 1e-3 を**超える**こと」を PASS 条件にしている。
  check_04 は**全 mu についての最小**残差を見ており、実測で 1.16〜2.78。すなわち原文の cases は
  どの mu でも成り立たない。誤植版と修正版は演算子そのもの（hatZ と hatY）が入れ替わっているので、
  たまたま一致する mu は存在しない。
- (h1.z)/(h1.y) は `H_1^{(±)}` と `hatZ_mu^{(±)}` の符号を揃えた組（`sgn = +1` と `sgn = -1` の両方）で検証している。

## 実行方法

各ファイルを個別に実行:
```bash
sage sagemath/check/040_claim_extract_taylor_coefficient_of_Z_Y/check_01_single_commutators.sage
```

全ファイルを一括実行:
```bash
for f in sagemath/check/040_claim_extract_taylor_coefficient_of_Z_Y/check_*.sage; do sage "$f"; done
```

## 実行ログ

`run-log.txt` に実際の実行出力（全チェックの残差と PASS/FAIL）を保存してある。
