# SageMath Check: 055_claim_critical_point

## 対象

**対象ラベル**: `specific_heat_log_divergence` （structured-latex 側の安定識別子）

- ファイル: `structured-latex/content/020_critical_point.ts`（章 E: 臨界点と比熱の対数発散）
- 併せて検証:
  - `cosh_addition_and_half_angle`（加法定理・半角公式・`arcsinh`）
  - `def_kappa` / `def_critical_sinh_product_A` / `gamma_kappa_identity`（鍵の恒等式）
  - `critical_point_iff_kappa_zero`（臨界条件の同値。008 章 `critical_condition_c1_eq_s1_c2` とも突き合わせ）
  - `isotropic_A_equals_one` / `kappa_of_K_basic`（等方な場合の設定と定数）
  - `gamma_derivatives_in_kappa`（`κ` についての 1 階・2 階導関数）
  - `elementary_sine_bounds` / `closed_form_log_integral` / `sine_integral_two_sided`（初等評価）
  - `second_derivative_log_divergence`（`G''(κ)` の対数発散）
  - `remark_physical_specific_heat`（物理的な比熱 `C = k_B K² f''(K)` との対応）

### 何を確定させるための検証か

018 章で 2 次元 Ising 模型の厳密解（`onsager_exact_solution`）が閉じた。章 E はその**後続**で、
得られた自由エネルギー

```
f(K1,K2) = (1/2) log(2 sinh 2K2) + (1/(4π)) ∫_0^{2π} γ(θ) dθ
```

について、**臨界点 `sinh 2K1 sinh 2K2 = 1` で比熱が対数的に発散すること**を本文の定理として証明した。
この検証は、その証明の**各段の等式・不等式そのもの**をラベル単位で数値的に固定する
（結論だけの検証にしない）。

要点は 1 つの恒等式に集約される。`κ := 2K1 − 2K2*`、`A := sinh 2K1 sinh 2K2*` とおくと**厳密に**

```
cosh γ(θ) = γ_1(θ) = cosh κ + 2A sin²(θ/2)
sinh²(γ(θ)/2) = sinh²(κ/2) + A sin²(θ/2)
```

が成り立ち、臨界条件は `κ = 0` と同値である。さらに**等方な場合 `K1 = K2 = K` では `A = 1`**
（`K*` の定義 `sinh 2K sinh 2K* = 1` そのもの）なので、`γ` は `κ` 1 つを通じてのみ `K` に依存する。
`γ` を `κ` で 2 回微分すると `∫ dθ / √(sinh²(κ/2) + sin²(θ/2))` が現れ、これが `κ → 0` で
`log(1/|κ|)` のオーダーで発散する。これが対数発散の源である。

## 検証の枠組み

`_prelude.sage` に `κ`, `A`, `γ`, `G(κ) = (1/4π)∫γ`, `f(K)`, 有限 `M` 版の
`(1/M) log Λ^{(1/2)}_M` を置いた。

**精度について**: 他の check（`044`〜`053`）が使う `RDF`（倍精度）では、`f''` を数値微分で
求める段と `κ → 0` の極限で桁落ちして値が壊れる。そのため本 check だけは `mpmath`（`dps = 40`）で
計算する。なお `γ` を `arccosh` 経由で作ると `κ = 0` かつ `θ = 0` の近傍で
`arccosh` の導関数が発散するため有効桁が約半分（20 桁）落ちる。`arccosh` 経由の値と
`arcsinh` 表示を突き合わせる比較にはこの条件数に見合う許容 `TOL_ACOSH = 1e-18` を使う
（それ以外の恒等式は `TOL = 1e-25`）。

パラメータは次のとおり。

- 非等方を含む `(K1,K2)`: 臨界点上（等方 `K_c`、非等方 2 組）と臨界点から離れた 4 組
- 等方 `K`: `K_c = arcsinh(1)/2 = 0.4406867935…` の近傍を含む 7 点
- 臨界点への近づき方: `|K − K_c| = 1e-1, 5e-2, 2e-2, 1e-2, 1e-3, 1e-4, 1e-6, 1e-9`（両側）
  および比の収束は `1e-3 〜 1e-24`（両側）
- 有限 `M`: `M = 2, 3, 4, 5`（＋ 8, 16, 64, 256, 1024 で収束を見る）

## チェック一覧

| # | ファイル | 検証内容 | ステータス | 結果 |
|---|---------|---------|-----------|------|
| 01 | check_01_gamma_kappa_identity.sage | 鍵の恒等式（加法定理の段 → `γ_1` → `cosh γ` → 半角 → `arcsinh` 表示 → `κ` の偶関数性）、`cosh_addition_and_half_angle` (2)(4)(5) | PASS | （run-log.txt 参照） |
| 02 | check_02_critical_equivalence.sage | `s1s2=1 ⟺ K1=K2* ⟺ κ=0 ⟺ c1=s1c2`、等方で `A=1`、`κ'`/`κ''` の式、`|K−K_c|≤1/10` の定数 10 件 | PASS | （run-log.txt 参照） |
| 03 | check_03_elementary_bounds.sage | `elementary_sine_bounds`（`c_0`）、`closed_form_log_integral` (1)(2)(3)、`sine_integral_two_sided` の両側評価、`γ` の導関数の式と `\|∂_κγ\|≤1` | PASS | （run-log.txt 参照） |
| 04 | check_04_G_second_derivative.sage | 本文 Step 1（(R5) の交換・`\|G'\|≤1/2`）／Step 2,3（折り返しと `J,T` 分解）／Step 4,5,6 の各定数／Step 7 の `6/5`、偶関数性、発散 | PASS | （run-log.txt 参照） |
| 05 | check_05_specific_heat.sage | `f''` の分解式、主定理の `45` / `49`、比 `f''/log(1/\|K−K_c\|) → 8/π`、有限 `M` からの収束、`C = k_B K² f''` | PASS | （run-log.txt 参照） |

## 実測値（本文の定数はいずれも最適化していない）

| 本文の定数 | 主張 | 実測の最大値 |
|---|---|---|
| `second_derivative_log_divergence` の `6/5` | `\|G'' − (1/2π)log(1/\|κ\|)\| ≤ 6/5` | 0.1292（`κ = 0.5`） |
| `specific_heat_log_divergence` の `45` | `\|f'' − (8/π)log(1/\|κ\|)\| ≤ 45` | 1.600 |
| 同上の `49` | `\|f'' − (8/π)log(1/\|K−K_c\|)\| ≤ 49` | 4.294 |
| Step 4 の `\|R\| ≤ 2.514` | — | 0.3281 |
| Step 5 の `T ≤ 3.614` | — | 1.1525 |
| Step 6 の `≤ 2.201` | — | 2.1492 |

Step 6 の実測 2.1492 は本文の限界 2.201 に最も近い。**この段は当初 2.130 と見積もっていたが、
`cosh κ − 1 = 2 sinh²(κ/2)` を `2 sinh²(κ/4)` と誤って評価していた。本 check が `κ = 0.5` で
これを検出したので本文を修正した。**

## 備考

- **`κ → 0` の比の収束は遅い**（`|比 − 8/π| ≤ 49/log(1/|K−K_c|)` の速さしか出ない）。
  `|K−K_c| = 1e-24` でも比は 2.480 で `8/π = 2.5465` に届かない。これは対数発散の性質であって
  誤りではないので、check 05 では「理論限界内にあること」と「単調に近づくこと」で判定する。
- **`|K−K_c|` は `1e-24` までしか下げていない。** `dps = 40` では `K_c ± 1e-48` が `K_c` と
  区別できず値が壊れるためで、これは精度の制約であって主張の制約ではない（黙って切り捨てず明示する）。
- **有限 `M` からの収束は単調ではない**（`M = 8` より `M = 16` の方が誤差が大きい）。
  半整数運動量の標本点の並びによる振動で、`M = 64, 256, 1024` では単調に減り
  `M = 1024` で `4.4e-34` まで落ちる。
- `remark_physical_specific_heat` の `C = k_B K² f''(K)` は、`k_B = 𝒥 = 1` とおいて
  `C := dU/dT` を数値微分で作り、`k_B K² f''` と一致することで確認した（残差 4.6e-41）。
