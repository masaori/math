# SageMath Check: 047_claim_even_sector_T_action

## 対象

**対象ラベル**: `T_V_plus_check_Z_Y` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/014_even_sector_T_action.ts`
- 併せて検証:
  - `def_H1_plus` / `def_V1_plus_square_root` / `V1_plus_square_root_property` / `def_V_plus` /
    `V_plus_factors_invertible` / `def_T_V_plus` / `T_V_plus_is_conjugation`
    （偶セクターの生成子から `V^{(+)}` とその共役写像までの定義・性質）
  - `nesting_of_commutator_of_H_and_check_Z`（n 重交換子の閉じ方）
  - `cosh_sinh_coefficient_conversion_for_check`（生成子のスケール後の形）
  - `extract_taylor_coefficient_of_check_Z_Y`（テイラー係数の抽出）
  - `T_actions_on_check_Z_Y` / `calc_of_TxT_check_Z_Y`（`B_1(θ~), B_2` による右乗）
  - `factorization_of_A_theta_general`（`B_1(θ)B_2B_1(θ) = A(θ)`）

### 何を確定させるための検証か

章 C′（偶セクターの固有値）の C′-8〜C′-11 にあたる。013 章（`046_claim_even_sector_modes`）で
半整数運動量モード `checkZ, checkY` が `H_1^{(+)}, H_2` に対して 008 章の (A)〜(D) と
**同じ形**の交換関係を満たすことを確定させた。この検証は、そこから 008 章後半と同じ道筋で

```
(T_{(V^{(+)})}(checkZ_mu), T_{(V^{(+)})}(checkY_mu)) = (checkZ_mu, checkY_mu) A(θ~_mu)
A(θ~_mu) = B_1(θ~_mu) B_2 B_1(θ~_mu)
```

まで到達できることを、**本文の各段ごとに**数値で固定する。

とくに次を確定させる。

1. **n 重交換子が `checkZ, checkY` の中で閉じること**（008 章の (h1.z)(h1.y)(h2.z)(h2.y) と同じ形）。
   008 章では (h2.z) が `hatZ^{(-)}` 専用だったが、半整数運動量ではセクターの制限が付かない。
2. **`T_{(V_1^{(+)})^{1/2}}` と `T_{V_2}` が `(checkZ, checkY)` に右から `B_1(θ~_mu)`, `B_2` を掛けること**。
3. **`B_1(θ)B_2B_1(θ) = A(θ)` が `θ ∈ R` 一般で成り立つこと**（008 章の `factorization_of_A_theta` は
   `μ ∈ calM` で量化されているので、θ~ に適用するには一般形が要る）。
4. **合成として定義した `T_{(V^{(+)})}` が `V^{(+)}` による共役そのものに一致すること**。

## 検証の枠組み

`sagemath/_shared/spin_ops.sage` の演算子構成に、本ディレクトリの `_prelude.sage` で

```
θ~_mu = 2π(mu − 1/2)/M
checkZ_mu = Σ_{j=1}^{M} Z_j e^{−i j θ~_mu},   checkY_mu = Σ_{j=1}^{M} Y_j e^{−i j θ~_mu}
(V_1^{(+)})^{1/2} = exp((i/2) K_1 H_1^{(+)})
V_2               = (2 s_2)^{M/2} exp(i K_2^* H_2)     （前因子を明示的に付ける）
V^{(+)}           = (V_1^{(+)})^{1/2} V_2 (V_1^{(+)})^{1/2}
B_1(θ), B_2, A(θ)
```

を加えた。`T_g(X) = g X g^{-1}` は**行列指数関数を明示的に構成した直接計算**で評価しており、
交換子の級数展開（`exp_X_Y_exp_-X`）にも `extract_taylor_coefficient_of_check_Z_Y` にも
依存しない独立な経路になっている（check_03, check_04）。

パラメータは `M = 2, 3, 4, 5`、`μ = 1,…,M`（`def_half_integer_modes` (2) の添字周期性により
これで全域）、`(K1, K2)` は次の 5 組。

| K1 | K2 | 位置づけ |
|---|---|---|
| 0.4 | 0.8 | 一般の点 |
| 1.2 | 0.3 | 一般の点 |
| 0.4407 | 0.4407 | **臨界点上**（等方的、`sinh 2K1 · sinh 2K2 = 1`） |
| 0.44 | 0.45 | **臨界点近傍**（非等方的） |
| 0.05 | 0.1 | 高温極限付近 |

## チェック一覧

| # | ファイル | 検証内容 | ステータス | 結果 |
|---|---------|---------|-----------|------|
| 01 | check_01_nested_commutators.sage | n 重交換子 (h1.z)(h1.y)(h2.z)(h2.y)（`n = 0..8`）と、生成子を `(i/2)K1H1^{(+)}`, `iK2*H2` にスケールした形 | PASS | 最大残差 4.1e-12 (tol=1e-6) |
| 02 | check_02_taylor_sums.sage | テイラー係数の抽出（級数を 40 次で打ち切り）4 式 | PASS | 最大残差 2.9e-14 (tol=1e-8) |
| 03 | check_03_T_actions.sage | `T_{(V_1^{(+)})^{1/2}}`, `T_{V_2}` の 4 つの作用と、`B_1(θ~)`, `B_2` による右乗 | PASS | 最大残差 2.2e-11 (tol=1e-8) |
| 04 | check_04_T_V_plus_and_factorization.sage | `B_1(θ)B_2B_1(θ) = A(θ)`（θ を 60 点走査）／合成 = 共役／`(T(cZ),T(cY)) = (cZ,cY)A(θ~)`／`γ_2(θ~) ≠ 0` | PASS | 分解 1.1e-14、作用 8.4e-11 (tol=1e-8) |

## 検証した式（ラベル単位）

check_01（`nesting_of_commutator_of_H_and_check_Z` / `cosh_sinh_coefficient_conversion_for_check`）:

```
[K1 H1^{(+)},...,checkZ]_n = (-1)^{(n-1)/2}(2K1)^n e^{-iθ~} checkY  (n 奇) / (-1)^{n/2}(2K1)^n checkZ  (n 偶)
[K1 H1^{(+)},...,checkY]_n = (-1)^{(n+1)/2}(2K1)^n e^{ iθ~} checkZ  (n 奇) / (-1)^{n/2}(2K1)^n checkY  (n 偶)
[K2* H2,...,checkZ]_n      = (-1)^{(n+1)/2}(2K2*)^n checkY          (n 奇) / (-1)^{n/2}(2K2*)^n checkZ (n 偶)
[K2* H2,...,checkY]_n      = (-1)^{(n-1)/2}(2K2*)^n checkZ          (n 奇) / (-1)^{n/2}(2K2*)^n checkY (n 偶)
スケール版: (i/2)K1H1^{(+)} → i K1^n e^{-iθ~} checkY / K1^n checkZ  など 4 式
```

check_02（`extract_taylor_coefficient_of_check_Z_Y`）:

```
Σ_n (1/n!) [(i/2)K1H1^{(+)},...,checkZ]_n = cosh(K1) checkZ + i e^{-iθ~} sinh(K1) checkY
Σ_n (1/n!) [(i/2)K1H1^{(+)},...,checkY]_n = -i e^{iθ~} sinh(K1) checkZ + cosh(K1) checkY
Σ_n (1/n!) [i K2*H2,...,checkZ]_n         = cosh(2K2*) checkZ - i sinh(2K2*) checkY
Σ_n (1/n!) [i K2*H2,...,checkY]_n         = i sinh(2K2*) checkZ + cosh(2K2*) checkY
```

check_03（`T_actions_on_check_Z_Y` / `calc_of_TxT_check_Z_Y`）:

```
T_{(V1^{(+)})^{1/2}}(checkZ) = cosh(K1) checkZ + i e^{-iθ~} sinh(K1) checkY
T_{(V1^{(+)})^{1/2}}(checkY) = -i e^{iθ~} sinh(K1) checkZ + cosh(K1) checkY
T_{V2}(checkZ)               = cosh(2K2*) checkZ - i sinh(2K2*) checkY
T_{V2}(checkY)               = i sinh(2K2*) checkZ + cosh(2K2*) checkY
(T(checkZ), T(checkY)) = (checkZ, checkY) B_1(θ~_mu)   （V_1 分）
(T(checkZ), T(checkY)) = (checkZ, checkY) B_2          （V_2 分）
```

check_04（`factorization_of_A_theta_general` / `def_T_V_plus` / `T_V_plus_is_conjugation` / `T_V_plus_check_Z_Y`）:

```
(1) B_1(θ) B_2 B_1(θ) = A(θ)                        （θ = 2πk/60, k = 0..59）
(2) T_{(V1)^{1/2}} ∘ T_{V2} ∘ T_{(V1)^{1/2}} = T_{V^{(+)}}（合成 = 積による共役）
(3) (T_{(V^{(+)})}(checkZ), T_{(V^{(+)})}(checkY)) = (checkZ, checkY) A(θ~_mu)
(4) 参考: |γ_2(θ~_mu)| > 0（全 μ で。最小値は 0.56）
```

## 備考

- **`V_2` の前因子 `(2 s_2)^{M/2}` を明示的に付けた形で評価している。** 共役でこれが相殺することも
  同時に確認しており、本文の「スカラーは共役で打ち消し合う」という段が数値でも裏付けられている。
- check_01 の tol だけ 1e-6 にしてある。`n = 8` まで取ると `(2K1)^8`, `(2K2*)^8` が大きくなり
  （`K1 = 1.2` では `(2.4)^8 ≈ 1.1e3`、`K2 = 0.1` では `(2K2*)^8 ≈ 1.3e7`）絶対残差が
  相対精度に比例して増えるため。実測の最大残差は 4.1e-12 で、tol より 6 桁小さい。
- (4) の `γ_2(θ~_mu) ≠ 0` は本章の主張には使っていない。章 C′ の次の段（`A(θ~)` の対角化）で
  008 章・009 章にあった臨界点の例外処理（`μ = M` の除外）が偶セクターでは不要になることを
  示唆する事実として記録してある。臨界点上（`K1 = K2 = 0.4407`）でも `|γ_2| ≥ 0.65` である。
- `M = 2` を含めているのは `def_half_integer_modes` が `M ∈ Z_{≥2}` で述べられているため。
  `M = 2` では `μ = 1, 2` の 2 つで `θ~ = π/2, 3π/2`。

## 実行方法

```bash
for f in sagemath/check/047_claim_even_sector_T_action/check_*.sage; do sage "$f"; done
```

## 実行ログ

`run-log.txt` に実際の実行出力（全チェックの残差と PASS/FAIL）を保存してある。
