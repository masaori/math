# MEMORY — exact-solution-of-2d-ising-model

## 完了（2026-07-26）: 人手証明に残っていた未完（TODO）を全件解消 — **総括**

本セッションのゴールは「`structured-latex/content/*.mjs` に残る未完を、証明完成か、
埋められない根拠の一次情報による特定か、のどちらかに到達させる」ことだった。到達した。
以下は個別セッションの記録（このすぐ下から並ぶ各節）の索引であり、**残っている未完はこの節に全部書いてある**。

### 数え方の注意（重要）

「TODO 8 件」という数字は `verify-no-lost-proofs.mjs` の出力であり、これは
**proof が `todo()` だけのブロック**を数えている。実際には `statement` 側の `todo()` や、
証明の途中まで書いて末尾が `todo()` のブロックもあり、**`todo()` ノードを含むブロックは全部で 16 件**だった。
本セッションはこの 16 件すべてを対象にした。

### 結果

- `todo()` を含むブロック: **16 件 → 1 件**。
- `verify-no-lost-proofs.mjs` の「proof が todo のみ」: **8 件 → 0 件**。
- 併せて、`todo()` を使わない形で残っていた未完 4 箇所（「証明略」「（暫定）一旦受け入れる」
  「未証明につき使用禁止」）も解消した。**本文に未証明の主張を根拠として使っている箇所は無い**
  （grep で確認済み）。
- 検証3種すべて通過: `validate-content`（161 ブロック・132 ラベル・557 参照すべて解決）/
  `verify-no-lost-proofs`（0 件）/ `verify-check-linkage`（7 件）。

### 唯一残した未完とその根拠

`exp_conjugation_proof_002_theorem_Ad_exp_lie`（**一般の Lie 群上の** $\mathrm{Ad}(\exp X)=\exp(\mathrm{ad}X)$）。
理由は「難しいから」ではなく、**主張の記号が意味をもつ土台がリポジトリに存在しないから**である
（多様体・Lie 群・Lie 環・$\mathrm{Lie}(G)$ を定義したブロックが 1 件も無いことを grep で確認）。
**本論はこの一般版に依存しない**。必要なのは行列環上の $e^XYe^{-X}=e^{\mathrm{ad}_X}(Y)$ だけで、
そちらは `matrix_exp_conjugation` として完全に証明済みであり、以降の参照もすべてそこへ張り替えた。
詳細は末尾の「未完 TODO の根拠（005 …）」節を見よ。

### 本セッションで発見・訂正した原文の誤り（すべて数学的に実質的なもの）

1. **分配関数の $J$ と $J'$ が転送行列側と入れ替わっていた**（001）。$M\neq N$ のとき
   $\mathrm{tr}((V_1V_2)^M)$ は $Z(J,J')$ ではなく $Z(J',J)$ に一致してしまう。$V_1,V_2$ の定義側を訂正。
2. **周期境界条件が未記載で、分配関数と転送行列の定義式そのものが意味を持っていなかった**（001）。
   $s(M+1,j):=s(1,j)$、$s(i,N+1):=s(i,1)$、$\mu(N+1):=\mu(1)$ を明記。
3. **$V_1$ の定義の虚数単位が余分だった**（004）。原文どおりだと $V_1=\exp(-K_1(Y_1Z_2+\cdots))$ となり
   原文自身の主張と矛盾する。$\sqrt{-1}$ は Jordan–Wigner 置換 $\sigma^z_m\sigma^z_{m+1}=\sqrt{-1}\,Y_mZ_{m+1}$ から生じる。
4. **$\mathrm{End}(\mathcal{F})\cong\mathrm{Mat}(2,\mathbb{C})^{\otimes M}$ が「線型同型を一つ取る」だけで、
   積を保つ保証が無かった**（004）。これでは $\exp$ を移せず証明が成立しない。正準な単位的 $\mathbb{C}$-代数同型として構成し直した。
5. **$\gamma_1$ の偏角の場合分けの第 2 の場合（$\arg=\pi$）は空**（008後半）。
   $c_1>s_1>0$, $c_2^{*}>s_2^{*}>0$ より $c_1c_2^{*}/(s_1s_2^{*})>1\ge\cos\theta_\mu$ で、常に $\gamma_1>0$。
6. **「$\sin\theta_\mu=0 \iff \mu=\pm M$」は単独では偽**（008後半）。$M$ が偶数なら $\mu=\pm M/2$ も満たす。
   これが排除されるのはもう一方の条件が $c_2s_1=-c_1<0$ を要求して正値性と矛盾するためで、
   **連立して初めて** $\mu=\pm M$ に絞られる。
7. **$\arg^{[0,2\pi)}(\gamma_2(\theta_\mu)/\gamma_2(-\theta_\mu))$ は原文がプレースホルダー `???` のままだった**（008後半）。
   $\gamma_2(-\theta)= -\overline{\gamma_2(\theta)}$ から確定式へ置換した。
8. **原文がテンソル因子の位置に全体の単位元を書いていた**（006）。2×2 の $I_{\mathrm{Mat}(2,\mathbb{C})}$ に修正。

### 検証されたこと（誤りではなかったもの）

- $B_1(\theta_\mu)B_2B_1(\theta_\mu)=A(\theta_\mu)$（008前半）は **statement のとおり正しい**。
  4 成分すべてを手計算で確認し、$(1,2)$/$(2,1)$ 成分に現れる $c_2^{*}$ が $\gamma_2$ の $c_2$ と一致するのは
  双対関係 $c_2^{*}=s_2^{*}c_2$ による（独立ブロック `duality_c2_star_eq_s2_star_c2` として切り出した）。
  呼び出し元でも $K_1,K_2,\theta$ の 4 組で数値独立確認済み（誤差 $10^{-15}$ 以下）。
- $\gamma_1$ の偏角の境界 $\gamma_1=0$ を $\arg=0$ 側に含める原文の扱いは**正しい**。
  このリポジトリの $\arg^{[0,2\pi)}$ は全域関数で $\arg^{[0,2\pi)}(0_{\mathbb{C}})=0$ だから。

### 次にやるとよいこと

- 一般 Lie 群版を本当に証明したいなら、多様体・Lie 群・Lie 環・指数写像の定義ブロックを整備するところから。
  ただし**本論には不要**なので、優先度は低い。
- クリフォード群まわりで、`T_g` の定義域をクリフォード群へ狭める案は採れないことが
  `V2_not_in_clifford_group` で確定した（$V_2\sigma_1^zV_2^{-1}$ が Pauli 基底で 2 成分をもつ）。
  代わりに単射性は `injectivity_of_T_up_to_scalar` で直接証明済み。

## 完了（2026-07-26）: 転送行列 V1/V2 の定義と共役作用 T_g / T_V を Lean で形式化

新規ファイル 2 つ（`lake build` 成功、`scripts/check-no-sorry.sh` exit 0）。

- `lean/Ising2D/Part004/Definition010_H1H2V1V2.lean`
  - `H1 η`（`Y_m Z_{m+1}` の和、最終項の符号を `η : ℂ` で持つ）と `H2`。
    site 添字の巡回は `Fin M` の加法（`NeZero M` を要求する）を避け、
    自前の `nextSite m = ⟨(m+1) % M, _⟩` で表す（`M` に追加仮定を置かないため）
  - `V1`, `V1half`, `V2`（`(2s_2)^{M/2}` は `Real.rpow`）と、その可逆性
    （`V1Units` / `V1halfUnits` / `V2Units`。`V_2` のスカラー因子が 0 でないために `s_2 > 0` が要る）
- `lean/Ising2D/Part008/Definition016_TV.lean`
  - `TConj g`（原文 `def_T_g`）を **ℂ-代数自己同型**として構成（既存の
    `Ising2D.Conjugation.*` を再利用し、`commutes'` だけ足した）
  - `TV g1 g2`（原文 `def_T_V`）と `TV_eq_TConj : T_{(V)} = T_{g_1 g_2 g_1}`、
    ℂ-線型性・乗法性・単位性
  - 行ベクトル記法 `(T z, T y) = (z, y) B` の述語 `ActsBy` と合成則 `ActsBy.comp`、
    および**固有ベクトル移送の一般補題 `ActsBy.eigen`**（後段で ψ が V の固有ベクトルで
    あることを導く鍵）
  - 行列等式 `B_1(θ) B_2 B_1(θ) = A(θ)` を証明（`B1_mul_B2_mul_B1_eq_Amat`）
  - 原文 `T_V_hatZ_hatY` は、`B_1`, `B_2` の作用（`parts 008` の 001〜005 のテイラー係数
    抽出に依存し未形式化）を**明示的な仮定 `hT1`, `hT2`** として持つ定理
    `TV_hatZ_hatY_of_action` の形で述べた。仮定から先は完全に証明済み

### 形式化で見つかった原文の問題（原文は書き換えていない）

1. **`V_2` の 2 つの表式の一致が未説明。**
   `transfer_matrix_001_definition_symbols` は `V_2 = (2 sinh 2K_2)^{M/2} exp(K_2^*(σ^x_1+⋯+σ^x_M))`、
   `transfer_matrix_011_definition_H1_H2` は `V_2 = (2s_2)^{M/2} exp(√-1 K_2^* H_2)` と書くが、
   一致には `√-1 Z_m Y_m = σ^x_m`（`Z_m Y_m = -√-1 σ^x_m` から従う）が要る。原文は「よって、」
   とだけ書いて根拠を示していない。Lean では `I_smul_H2_eq_sum_sigmaX` として補って証明した。
2. **`A(θ)` に `c_2` が現れるのに、その出所（双対関係）が明示されていない。**
   `def_A_theta` の非対角成分は `s_2^*(c_1 cos θ ∓ i sin θ - s_1 c_2)` だが、
   `B_1(θ) B_2 B_1(θ)` を計算して同じ位置に出るのは `c_2^*` である。両者が一致するには
   `c_2^* = s_2^* c_2`（`sinh 2K_2 · sinh 2K_2^* = 1` から従う）が必要。原文は
   `def_A_theta` でも `T_V_hatZ_hatY` の証明でもこの等式に触れていない。
   Lean では `B1_mul_B2_mul_B1_eq_Amat` の仮定 `hdual : s_2^* c_2 = c_2^*` として明示した。
3. **`(V_1^{(±)})^{1/2}` の意味が未定義。** 原文は `exp(X)^{1/2}` を無断で `exp(X/2)` と
   読み替えているが、一般に行列の平方根は一意でない。Lean では `V1half := exp(X/2)` を定義とし、
   `V1half_sq : V1half^2 = V1` を証明して「平方根であること」を確認した。
## 完了（2026-07-26）: `A(θ)` の対角化（γ_1, γ_2, 固有値・固有ベクトル、P D P⁻¹）を形式化

追加ファイル: `lean/Ising2D/Part008/Definition019_ThetaGamma.lean`, `lean/Ising2D/Part008/Claim027_EigenATheta.lean`。
対応する原本ブロックは `structured-latex/content/008_TV1_hatZ_hatY_part1.mjs` の
`TV1_hatZ_hatY_017/019/020` と `..._part2.mjs` の `TV1_hatZ_hatY_022/023/027/028/035`。

### 方針（要点だけ）

- 複素平方根の分枝を持ち込まず、`t^2 = γ_2(θ)γ_2(-θ)`（あるいは `s^2 = -γ_2(θ)γ_2(-θ)`）を
  **満たす複素数を仮定として受け取る**形にした。分枝の選択は「`t` と `-t` のどちらか」だけに
  縮約され、結論（`P` の 2 列と `D` の 2 成分が同時に入れ替わるだけ）が分枝によらないことが見える。
- モデル定数 `c_1, s_1, c_2, c_2^*, s_2^*` は 5 個の実数（`IsingConst`）として扱い、
  `cosh^2 - sinh^2 = 1` や双対関係は**使う定理ごとに仮定として明示**した。
  どの結論がどの関係に依存するかが形式化の側で可視化される。

### 形式化で見つかった原文の問題

1. **`gamma_2_theta_is_0`（`TV1_hatZ_hatY_022`）は `s_2^* ≠ 0` を暗黙に仮定していた**（`γ_2` は
   `s_2^*` を因子に持つ）。また **「`sin θ_μ = 0 ⟺ μ = ±M`」は単独では偽**で、正しくは `M ∣ 2μ`
   （`M` が偶数なら `μ = ±M/2` も該当）。
   → **本セッションと並行して、原文側で両方とも修正済み**（現在の当該ブロックは `K_1, K_2 ∈ ℝ_{>0}`
   を前提に置き、`μ = ±M/2` が `c_2s_1 = -c_1 < 0` の矛盾で排除されることも明記されている）。
   Lean 側は `gamma2_eq_zero_iff` と `sin_thetaMu_eq_zero_iff` を機械的な裏づけとして残した。
2. **`det_A_theta`（`TV1_hatZ_hatY_035`）の `det A(θ_μ) = 1` は `A(θ)` の定義からは出ない。**
   定義だけから無条件に言えるのは `det A(θ) = γ_1(θ)^2 + γ_2(θ)γ_2(-θ)` まで。`1` になるのは
   (i) `c_1^2 - s_1^2 = 1`、(ii) `(c_2^*)^2 - (s_2^*)^2 = 1`、(iii) `c_2 s_2^* = c_2^*` が揃うとき。
   原文は `A = B_1B_2B_1` から `det A = (det B_1)^2 det B_2 = 1` を出しており (i)(ii) はそこで使うが、
   **(iii) が明示されていない**。`B_1, B_2` には `c_2^*, s_2^*` しか現れず、`def_A_theta` の (1,2) 成分の
   `c_2` は `B_1B_2B_1` を展開すると `c_2^*/s_2^*` として出てくる。つまり (iii) は
   `factorization_of_A_theta`（その proof は原文では TODO＝Mathematica による数値確認のみ）に
   埋め込まれた前提である。(iii) を `c_2 = c_2^*` に置き換えると `det A` は `θ` 依存になり `1` にならない
   （数値例で確認済み）。
3. **`diagonalization_P_D`（`TV1_hatZ_hatY_028`）は `P_μ` の可逆性を確認していない。**
   `A = P D P^{-1}` と書くのに `det P_μ ≠ 0` の確認が無い。Lean 側で
   `det P_μ = i t/(2(√M)^2 γ_2(-θ_μ))` を計算し、`γ_2(θ_μ) ≠ 0`, `M ≠ 0` の下で非零を示した。
4. 固有値・固有ベクトルの符号対応（`λ_± = γ_1 ± √(-γ_2γ_2)` ↔ `v_± = c(±i√(γ_2γ_2), γ_2(-θ))`）は
   **検算の結果、原文が正しい**。ただし整合するのは `arg^{[0,2π)}` 分枝での
   `√(-1·z) = -√(-1)√z`（`z = γ_2(θ)γ_2(-θ)` は負の実数）を使うときに限る。
   原文は proof 中でこの分枝規約を導いているが、statement 側には分枝の指定が無い。
   Lean 側では `t := √(γ_2γ_2)` の言葉で「`i t` 側の固有値は `γ_1 - i t`」と明示した。
5. `eigenvector_of_A_theta` の「`γ_2 = 0` のとき `A(θ_μ) = I`」は、原文が
   `A_theta_is_identity_when_gamma2_zero`（`045`）を参照しており、そこで `det A = 1` と `γ_1 ≥ 1` から
   `γ_1 = 1` を出している。**原文の穴ではない**（当初は穴と判断したが、参照先を確認して撤回した）。
   Lean 側では依存関係が見えるよう `AMat_of_gamma2_eq_zero`（`A = γ_1 I` まで）と
   `gamma1_sq_eq_one_of_gamma2_eq_zero`（3 関係から `γ_1^2 = 1`）に分離してある。

## 完了（2026-07-26）: `todo()` 以外の形で残っていた未完 4 箇所

`todo()` を使わない形（「未証明につき使用禁止」注記・「暫定」proof・「証明略」）で残っていた
4 箇所をすべて人手証明で閉じた。**未証明のまま残した差分は無い**（＝ MEMORY への「根拠つき記録」に
回した項目は 0 件）。

- **`brianhall_exc14` / `brianhall_3.35`（`005_exp_conjugation_proof.mjs`）**:
  「Brian Hall Prop 3.35 の参考記述であり未証明・使用禁止」注記を撤回し、
  `matrix_exp_conjugation`（行列版 $e^XYe^{-X}=e^{\mathrm{ad}_X}(Y)$、同ファイルで完全証明済み）と
  `ad_binomial` から証明を書いた。**一般 Lie 群でしか意味をもたない差分はこの 2 ブロックには無い**：
  `brianhall_exc14` は $\mathrm{M}(n,\mathbb{C})$ 上の主張そのもの、
  `brianhall_3.35` の Matrix Lie群 $G$ に関する仮定
  （$\forall t\in\mathbb{R},\ \exp(tX)\in G$ と $Y\in G$）は
  $\mathrm{Ad}_{\exp X}$ を $G\to G$ の写像として読むためにのみ使われ、等式自体は任意の
  $X,Y\in\mathrm{M}(n,\mathbb{C})$ で成り立つ。Matrix Lie群の定義の第2条件（極限に関する閉性）は不要。
  一般 Lie 群版が未証明なのは `exp_conjugation_proof_002` のみで、これは従来どおり `todo()` のまま
  （根拠は後述の「未完 TODO の根拠（005 …）」節）。
  併せて **`matrix_exp_conjugation` のブロックを `brianhall_exc14` より前へ移動**し、
  証明が後方のブロックを参照する依存の逆転を解消した。
  Matrix Lie群の定義ブロックに `def_matrix_lie_group` ラベルを新設。
- **`exp_X_Y_exp_-X`（`008_TV1_hatZ_hatY_part1.mjs`）**:
  「（暫定）リー群・リー環の掘り下げを避けて一旦受け入れる」を撤回し、`matrix_exp_conjugation` を
  根拠に完全な証明へ書き換えた。statement 側に $X,Y\in\mathrm{Mat}(d,\mathbb{C})$ と記号の定義元を明示。
  これで **`brianhall_3.35` を根拠に使っている証明は本文に 1 件も無い**（grep 済み）。
- **`sqrt_nonnegative_existence_uniqueness`（新設・`000_calculation_formulae_00_09.mjs`）**:
  `definition_of_sqrt_r_positive` が「証明略」としていた
  「$x\ge0$ に対し $y\ge0\land y^2=x$ なる $y$ がただ一つ存在」を独立 claim として切り出し証明した。
  存在は $S=\{s\ge0\mid s^2\le x\}$ の上限をとる（**ここで非可算集合 $\mathbb{R}$ の完備性＝上限性質へ
  移行することを proof 冒頭で明示**。$\mathbb{Q}$ では成り立たないことも記載）。
  一意性は $x=0$ を場合分けしたうえで既存の `cosh_sinh_basic_properties` (4)
  （正実数について $a^2=b^2\iff a=b$）を参照し、重複証明を避けた。
- **`angle_section_existence_uniqueness`（新設・`000_calculation_formulae_10_19.mjs`）**:
  `section_of_angle_representation`（角度表現の切断）が「証明略」としていた
  「$0\le\theta-2n\pi<2\pi$ なる $n\in\mathbb{Z}$ の一意存在」を独立 claim として切り出した。
  従来はこの証明が `sqrt_expansion_via_polar` の proof Step 1 に書かれており、
  **定義が依存する事実を、その定義を使う側の主張の中で証明する依存の逆転**が起きていた。
  切り出したブロックは文書順で `section_of_angle_representation` より前に配置し、
  定義側と `sqrt_expansion_via_polar` の Step 1 の両方から参照する形にした（証明内容は元の Step 1 と同一。
  $\mathbb{R}$ のアルキメデス性を使う）。

## 完了（2026-07-26）: γ_1, γ_2 の偏角・零点・臨界条件（008 後半の 4 ブロック）

`008_TV1_hatZ_hatY_part2.mjs` の TODO 4 件をすべて人手証明で埋め、`todo()` を除去した。

- **`cosh_sinh_basic_properties`（新設・`000_calculation_formulae_00_09.mjs`）**:
  cosh/sinh の基本性質がどのブロックにも主張として無かったため新設した。
  (1) cosh x − sinh x = e^{−x} > 0、(2) cosh²−sinh² = 1、(3) x>0 で cosh x > sinh x > 0、
  (4) 正の実数について a² = b² ⟺ a = b。exp については乗法性・exp(0)=1・正値性・狭義単調増加だけを使う。
- **`TV1_hatZ_hatY_021`（γ_1 の偏角）**: γ_1(θ_μ) は実数で、符号は cos θ_μ と c_1c_2*/(s_1s_2*) の
  大小で決まる。境界 γ_1 = 0 の扱いは正しい。本リポジトリの arg は pr_2 が r=0 のとき [0] を返す定義
  （`first_and_second_projections`）なので **arg^[0,2π)(0_C) = 0** であり、境界を arg=0 側へ含める原文の
  場合分けは正しい。さらに c_1 > s_1 > 0、c_2* > s_2* > 0 より c_1c_2*/(s_1s_2*) > 1 ≥ cos θ_μ なので、
  **第2の場合（arg = π）は空**である（この事実を statement に追記した）。原文の `arg` は
  `arg^[0,2π)` に統一し、前提 K_1,K_2 ∈ R_{>0} と θ_μ の定義を補った。
- **`gamma_2_theta_is_0`**: i e^{iθ}s_2* ∈ C^× と C の整域性から γ_2 = 0 ⟺ w_μ = 0 に帰着し、
  実部・虚部で連立へ。**「sin θ_μ = 0 ⟺ μ = ±M」は単独では偽**（M が偶数なら μ = ±M/2 でも sin θ_μ = 0）。
  μ = ±M/2 は θ_μ = ±π ゆえ第2式が c_2s_1 = −c_1 < 0 を要求して正値性と矛盾するため排除される、という
  連立での論法を Step 4 に明示し、statement にも注意書きを入れた。最終形
  「μ = ±M かつ c_1 = s_1c_2」を第4の同値として追加した。
- **`arg_of_gamma2_quotient`（原文はプレースホルダー ??? で未完成）**: 値を確定させた。
  `relation_of_gamma_2` の γ_2(θ_μ)γ_2(−θ_μ) = −|γ_2(θ_μ)|² を使うと商は z²·(−1/r²) に等しく、
  極座標表現で **[(1, 2φ_μ + π)]**（φ_μ := arg^[0,2π)(γ_2(θ_μ))）。よって絶対値は 1、偏角は
  2φ_μ + π を mod 2π で [0,2π) へ還元した 3 場合の式。前提 γ_2(θ_μ) ≠ 0 を statement に明示した。
  φ_polar = φ_cartesian^{-1}（`isomorphism_of_phi_cartesian` の全単射性 + φ_cartesian∘φ_polar = id）を
  使うと、i / e^{iθ} / 正実数 / 負実数の極座標表現が「φ_cartesian で戻して確かめる」だけで出る。
  この主張は本文の後続からは参照されていない（grep 済み。参照は notes 1 件のみ）ので整合性の問題は無い。
- **`critical_condition_c1_eq_s1_c2`**: c_1 = s_1c_2 ⟺ s_1s_2 = 1 を、平方根を経由せず
  「正の実数について a² = b² ⟺ a = b」で両向き証明した。γ_2 の零点と Ising 臨界点の対応（statement 後半）の
  導出も Step 3 に書いた（`gamma_2_theta_is_0` の最終形を使う）。
- 数値検証: K_1,K_2,M の 4 組で γ_1 > 0、|γ_2(θ_μ)/γ_2(−θ_μ)| = 1、偏角 = 2φ_μ+π (mod 2π)、
  および c_1 = s_1c_2 ⟺ s_1s_2 = 1 を確認済み（誤差 1e-15 以下）。

## 完了（2026-07-26）: $V_1, V_2$ の $Z,Y,\varepsilon$ 表示と $V_1$ の固有空間への制限（004）

`004_transfer_matrix.mjs` の 2 つの TODO を解消した。

- `<V1_V2_in_Z_Y_epsilon>`（$V_1,V_2$ を $Z,Y,\varepsilon$ で表す）: Jordan--Wigner 置換
  $\sigma^z_m\sigma^z_{m+1} = i\,Y_mZ_{m+1}$（$1\le m\le M-1$）、$\sigma^z_M\sigma^z_1 = -i\,\varepsilon Y_MZ_1$、
  $\sigma^x_m = i\,Z_mY_m$ をテンソル因子ごとの計算で全部書き下した。**exp の分解（可換性）は不要**で、
  指数の中身が $\mathrm{Mat}(2,\mathbb{C})^{\otimes M}$ の元として等しいことを示せば済む。
  境界項に $\varepsilon$ が付くのは、$Y_M$ の Jordan--Wigner 文字列が一周しても $Z_1=\sigma^z_1$ 側に
  文字列が無く、第 1 因子の $\sigma^x$ が相殺せず残るため（それを打ち消すのが $\varepsilon$）。
- `<V1_restriction_to_eigenspaces>`（$V_1$ の $\mathcal{F}^{(\pm)}$ への制限）: $\varepsilon$ が各 $Z_m,Y_m$ と
  **反交換**すること（`<tensor_anticommutation_from_single_site>` を適用）→ 2 次式 $Y_aZ_b$ とは可換 →
  $\mathcal{F}^{(\pm)}$ が $\hat{G}$ 不変 → 部分和が $n$ の帰納法で一致 → 各点収束（`<exp_converges>`）と
  極限の一意性、という順で証明した。解析へ移行するのは最後の級数の極限だけであることを明記した。

### 原本の誤りを 2 点訂正した（要レビュー）

1. **`<def_transfer_matrix_symbols>` の $V_1$ の定義に虚数単位が余分だった。** 原文は
   $V_1 := \exp(\sqrt{-1}K_1(\sigma^z_1\sigma^z_2+\cdots+\sigma^z_M\sigma^z_1))$ だが、これでは
   $V_1 = \exp(-K_1(Y_1Z_2+\cdots))$ となり原文自身の主張 `<V1_V2_in_Z_Y_epsilon>` と矛盾する。
   $\sqrt{-1}$ は Jordan--Wigner 置換から生じるものなので、定義側を $K_1$ に訂正した
   （$V_2$ の定義には $\sqrt{-1}$ が無く、主張側には付く。同じ構造で整合する）。
   004 章以降（$H_1^{(\pm)}$、$V_1^{(\pm)}$、008 章）はすべて訂正後と整合している。
   NumPy で $M=2,3,4,5$ について両辺の一致を数値確認済み。
2. **`<def_end_iso>`（旧「$\mathrm{End}(\mathcal{F})$ と $\mathrm{Mat}(2,\mathbb{C})^{\otimes M}$ の同型」）が弱すぎ、向きも逆だった。**
   原文は「線型同型を一つ取る」だけだが、任意の線型同型では積が保たれず
   `<V1_restriction_to_eigenspaces>` の証明が成立しない。行列単位 $E_{I,J} \mapsto \Theta_{I,J}$ で
   **正準な単位的 $\mathbb{C}$-代数同型** $\mathbf{end}: \mathrm{Mat}(2,\mathbb{C})^{\otimes M} \to \mathrm{End}(\mathcal{F})$
   を具体的に構成し、その性質を新ブロック `<end_is_algebra_isomorphism>` で証明した。
   また $\mathrm{Mat}(2,\mathbb{C})^{\otimes M}$ 上の $\exp$ の意味（どの位相の級数か）が未定義だったので、
   $\mathbf{end}$ による移送として定義した（$\mathbf{end}(\exp A) = \exp(\mathbf{end}A)$）。

### 付随して直した点

- $\varepsilon$ の固有空間の定義（`<def_eigenspaces_of_epsilon>`）: $\varepsilon f$ の意味が
  $\mathbf{end}(\varepsilon)$ による作用であることを明示し、$\varepsilon^2 = I$ と固有値が $\pm1$ に限る理由を補った。
  $\mathbf{end}$ を要するため、ブロックの位置を `<def_end_iso>` の後ろへ移した。
- 新ラベル: `V1_V2_in_Z_Y_epsilon`, `V1_restriction_to_eigenspaces`, `def_end_iso`,
  `end_is_algebra_isomorphism`, `def_eigenspaces_of_epsilon`, `def_V1_pm`。
- $V_1$ の巡回和は $M\ge 2$ でなければ意味を持たないので、該当ブロックに $M\ge 2$ を明示した。

## 完了（2026-07-26）: 008 part1 の残り 4 ブロック（交換子のネスト・自己同型群の完全列・クリフォード群・T_(V) の作用）

`structured-latex/content/008_TV1_hatZ_hatY_part1.mjs` に残っていた 4 件の TODO をすべて埋め、`todo()` を除去した。

### 交換子のネスト（`<nesting_of_commutator_of_H_and_Z>`）

原文の proof は「TODO : note 参考にして、帰納法で行ける」だけだった。(h1.z)/(h1.y)/(h2.z−)/(h2.y) の
4 式それぞれについて `n` に関する帰納法を書き下した。右辺が `n` の偶奇で場合分けされているので、
帰納段階は「偶数 n → 奇数 n+1」「奇数 n → 偶数 n+1」の 2 通りを別々に書き、符号 `(-1)^{(n±1)/2}`・
係数 `(2K_1)^n`（`(2K_2^*)^n`）・位相因子 `e^{∓i2πμ/M}` の再生を毎回明示した。
`n=0` の規約（0 重交換子＝作用素そのもの）は statement 側に `ad_X` の合成として定義を書いた。
使うのは 1 重の交換子公式（`<commutator_of_H_and_Z_Y>`）と交換子の双線型性だけで、note の具体例には依存しない。

### 自己同型群の完全列（`<exact_sequence_of_aut>`）

原文は statement に「TODO: Ker, Im の定義、Z(G) の定義、完全列の定義」、proof に「TODO:」とあるだけだった。
不足していた定義を独立ブロックとして新設し、4 箇所すべての完全性を証明した。

- 新設: `<def_group_hom_ker_im>`（群準同型・核・像。Ker が正規部分群、Im が部分群、単射 ⟺ Ker が自明）、
  `<def_center_of_group>`（中心 `Z(G)`）、`<def_exact_sequence>`（完全列。両端の `1` を単射性・全射性へ読み替える所まで）、
  `<inn_is_normal_in_aut>`（φ_g ∈ Aut(G)、φ が群準同型、`ψφ_gψ^{-1} = φ_{ψ(g)}` から `Inn(G) ⊴ Aut(G)`）。
- 既存の自己同型群の定義ブロックにラベル `<def_aut_inn_out>` を付け、Aut(G) が合成について群をなすことと
  `Out(G)` が商群として定義できる根拠を statement へ書き足した。
- **この完全列は本文の他所からは参照されていない**（grep 済み。`Aut` の語は 005 の `Ad : G → Aut(G)` にしか出ない）。
  ただし後述の `T` の単射性の証明で `Ker(φ) = Z(G)` を使うため、削除せず本文に残した（conversion.notes にも記録済み）。

### クリフォード群（`<def_pauli_group>` / `<def_clifford_group>`）と `T` の単射性

原文（`parts/008/009`）は definition の体裁だが中身は著者の検討メモで、「3 つのアプローチ」として
**試す1**「V を具体的な行列として書くのがゴールなので `T_((V))` からその表式を見つけられないか」／
**試す2**「`T` の（定数倍を除いた）単射性を Cl に触れずに示す」／
**だめだったら3**「Cl と行列環の同型を認め、`T` の単射性も認めて先に進む」が挙げられていた。
**この検討は決着したので、設計判断待ちとしては残していない。**

- 採用は **試す2**。`<injectivity_of_T_up_to_scalar>` を新設し、`T_g = T_{g'} ⟺ ∃c≠0, g' = cg` を
  Clifford 代数と行列環の同型を経由せずに証明した。使うのは `<centralizer_is_scalar>` と
  上記の完全列の `Ker(φ) = Z(G)` だけ。併せて `Z(R^×)` が全体の中心（スカラー）と一致することを、
  「`x + tI` が可逆になる `t` は有限個を除いて存在する」という議論で明示的に示した（`R^×` の中心と
  `R` の中心の一致は自明ではないので）。
- **「`T_g` の定義域をクリフォード群へ狭める」は採れない。** `<V2_not_in_clifford_group>` を新設し、
  `V_2 σ_1^z V_2^{-1} = c_2^* σ^z ⊗ I⊗… − i s_2^* σ^y ⊗ I⊗…` が Pauli 基底で 2 成分をもつため
  Pauli 群に入らないことを示した。よって `def_T_g` の定義域は `R^×` のままとする。
- クリフォード群の定義は上記 `V_2 ∉ C_M` を述べるために本文に残した。標準的な定義がユニタリ群上で
  与えられるのに対しここでは `R^×` 内の正規化群としたのは、`K_2^* ∈ R` で `V_2` がユニタリでないため。

### `T_(V)` の作用（`<T_V_hatZ_hatY>`）

原文が「mathematica に計算させたら正しいことはわかったので、一旦具体の計算は飛ばす (0426)」として
未計算だった `B_1(θ_μ) B_2 B_1(θ_μ) = A(θ_μ)` を、4 成分すべて途中式込みで人手計算した。
**statement は修正不要**（計算結果と完全に一致）。ただし注意点が 1 つある。

- 素の行列積では (1,2)/(2,1) 成分に `c_2^*` が現れるのに対し、`A(θ)` の `γ_2` には `c_2`（星なし）が現れる。
  両者は双対関係 `c_2^* = s_2^* c_2` で一致する。この関係を `<duality_c2_star_eq_s2_star_c2>` として
  独立ブロックに切り出した（同じ計算が part2 の `equation_of_a_theta_mu` の Step 16 に埋め込まれていた）。
- 数値検証を `sagemath/check/017_claim_T_V_hatZ_hatY/` に追加（4 成分 + 双対関係、全 PASS）。
  `K1=10.4` で成分が ~1e9 になるため check_01〜04 は tol=1e-5（相対誤差は全パラメータで ≤2e-12）。

## 完了（2026-07-26）: `Z` と `Y` の反交換関係 3 式を人手証明で完成（`006/000`）

`006_Z_Y_anticommutation.mjs` の `<anticommutator_of_Z_and_Y>` は、原文以来
`[Z_μ,Y_ν]₊ = 0` と `[Y_μ,Y_ν]₊ = 2Iδ^M` が TODO のままだった。これを埋め、`todo()` を除去した。

- 参照先を作るため、同ファイルに本文ブロックを 2 つ新設した（どちらも原文に対応ブロック無し）。
  - `<pauli_matrix_products>`: Pauli 行列の積（`σ^aσ^a = I` の 3 式と、
    `σ^zσ^x = -σ^xσ^z`, `σ^yσ^x = -σ^xσ^y`, `σ^yσ^z = -σ^zσ^y`）。2×2 の成分計算で証明。
  - `<tensor_anticommutation_from_single_site>`: **1 サイトだけ反可換なら
    テンソル積全体が反交換**。テンソル積代数の積が因子ごとの積であることと、
    第 j 因子についての C-線型性でスカラー `-1` を外へ出すことだけで証明する。
    （Lean の `siteProd_anticomm_of_single_site` に対応する構成。）
- `<anticommutator_of_Z_and_Y>` の証明は、原文と同じ「テンソル因子を並べて書く」書式のまま、
  `[Z_μ,Z_ν]₊`（μ=ν / μ<ν / μ>ν）、`[Z_μ,Y_ν]₊`（μ=ν / μ<ν / μ>ν）、
  `[Y_μ,Y_ν]₊`（μ=ν / μ<ν / μ>ν）を各サイトの因子まで書き下した。符号を生むサイトは
  `[Z,Y]` では μ=ν で μ（`σ^yσ^z`）、μ<ν で μ（`σ^xσ^z`）、μ>ν で ν（`σ^yσ^x`）。
- 併せて直した点: 原文はテンソル**因子**の位置に全体の単位元 `I_{(C^2)^{⊗M}}` を書いていたので
  2×2 の `I_{Mat(2,C)}` に修正。μ>ν を「左右対称に同様」で済ませていた箇所も書き下した。
- 添字は `Z_{M+1}:=Z_1`, `Y_{M+1}:=Y_1` の M 周期性から代表元 `μ,ν ∈ {1,…,M}` に取り、
  その範囲で `δ^M_{(μ,ν)} = [μ=ν]` になることを明示した。
  参照のため `004` の `δ^M` 定義ブロックへラベル `<def_delta_M>` を付けた。

## 完了（2026-07-26）: 複素数の平方根の極座標表示（計算公式 039）の証明を追加

`structured-latex/content/000_calculation_formulae_30_44.mjs` の
`calculation_formulae_039_claim_sqrt_expansion_via_polar`（原文も TODO のままだったもの）に証明を付けた。

- 複素数の平方根はリポジトリ内で **主値等の分枝選択ではなく明示式で定義**されている
  （`calculation_formulae_038_definition_sqrt_of_complex_number`、新ラベル `def_sqrt_cc`）。
  すなわち偏角の切断 $s_{[0,2\pi)}$ を半分にしたもの。したがって本主張は「2乗して戻る根の選択」ではなく、
  **定義式の $\mathrm{pr}_1,\mathrm{pr}_2,s_{[0,2\pi)}$ を代表元で書き下しただけ**の等式である。
- 証明の構成: (1) $0\le\theta-2n\pi<2\pi$ なる $n\in\mathbb{Z}$ の存在と一意性
  （$\mathbb{R}$ のアルキメデス性から。角度表現の切断の定義が「証明略」としていた事実をここで証明した）、
  (2) 右辺の代表元非依存性、(3) $r\ne0$ の場合、(4) $r=0$ の場合（$\mathrm{pr}_2$ が $[0]$ を返す規約が効く）。
- 参照のために新ラベルを 3 件追加: `def_sqrt_cc`、`def_phi_cartesian`、`section_of_angle_representation`。
  本主張自体にも `sqrt_expansion_via_polar` を付け、`041_claim_sqrt_squared_is_original` の証明から参照させた。

## 完了（2026-07-26）: 転送行列による分配関数の表式の証明を完成（001）

`structured-latex/content/001_partition_function_2d_ising.mjs` の
`partition_function_2d_ising_004_claim_partition_function_via_transfer_matrix`
（$Z(J,J') = \mathrm{tr}((V_1V_2)^M)$）の TODO を解消した。

- トレース展開を全ステップ記述: $A^m$ の成分公式を $m$ の帰納法で証明 → トレースの定義適用と
  $\mu^{(M+1)}=\mu^{(1)}$（行方向の周期境界条件）の明示 → 指数の積を指数の和へ（`theorem_exp_product`
  を $n=1, K=\mathbb{R}$ で適用、こちらも帰納法）→ 全単射 $\Phi:\mathfrak{M}^M\to\mathfrak{S}$,
  $\Phi(\mu^{(1)},\dots,\mu^{(M)})(i,j) := \mu^{(i)}(j)$ の well-defined/単射/全射を個別に証明 →
  有限和の添え字付け替えで $Z(J,J')$ の定義式と項ごとに一致。総和はすべて有限和なので、
  順序交換・結合・分配に収束の議論は不要（$\mathbb{R}$/$\mathbb{C}$ の解析的道具へは移行していない）。

### 原本の誤りを2点訂正した（要レビュー）

1. **$J$ と $J'$ の入れ替え。** 原本の $V_1$ は行内相互作用に $J$、$V_2$ は行間相互作用に $J'$ を
   割り当てていたが、$Z(J,J')$ の定義では $J$ が第1引数方向（周期 $M$）、$J'$ が第2引数方向（周期 $N$）の
   結合定数である。$\mathrm{tr}((V_1V_2)^M)$ では転送回数 $M$ が第1引数方向、各 $\mu$ の成分数 $N$ が
   第2引数方向に対応するため、原本のままでは $M \neq N$ で $Z(J,J')$ と一致しない（一致するのは $Z(J',J)$）。
   主張の側ではなく**補助的な定義 `def_transfer_matrix` の側**で $J \leftrightarrow J'$ を入れ替えて訂正した。
   この2定義は他章から参照されておらず（004 章の $V_1,V_2$ は $\mathrm{Mat}(2,\mathbb{C})^{\otimes M}$ 上の
   別物）、影響は 001 章内に閉じている。
2. **周期境界条件が未記載だった。** $s(M+1,j)$, $s(i,N+1)$, $\mu(N+1)$ は定義域外で、規約なしでは
   定義式自体が意味を持たない。「正しさに必要ならそれは注記ではない」に従い、両定義の `statement` に
   $s(M+1,j):=s(1,j)$, $s(i,N+1):=s(i,1)$, $\mu(N+1):=\mu(1)$ を明記した。
   併せて $\mathrm{Mat}(2^N,\mathbb{C})$ の添え字集合 $\mathfrak{M}=\mathrm{Map}(\{1,\dots,N\},\{-1,1\})$
   との同一視も明示した。

検証はすべて通過（validate-content / verify-no-lost-proofs / verify-check-linkage、KaTeX パースも 146 式すべて成功）。

## 完了（2026-07-25）: データモデルの穴を塞いだ（本文ブロックは注記欄を持てない）

ノート分離の狙いは「最終成果物は content のみから生成するので、ノートは構造上混入しない」こと。
ところが**本文ブロック側に注記欄（`notes`）が残っており、ビューアも描画していた**（使用は0件だが、
書けば出版物へ漏れる経路）。これを塞いだ。

- `structured-latex/schema.mjs`: 本文ブロックの `notes` を**明示的に拒否**（エラーメッセージで
  「参照用は notes/ へ、出版本文で述べる必要があるものは statement/proof へ」と誘導）。負テスト済み。
- `schema.d.ts` と ビューアの契約（`realtime-web-preview/domain-model/src/block.ts`）からも型を削除。
- ビューアの本文カードから注記欄の描画を削除（参照用ノートの表示は別経路で維持）。

### データモデル（確定形）

- **文書本体** `content/*.mjs`: ブロックの配列。**並びが文書順の正準表現**。
  共通フィールドは id / kind / sourcePath / sourceOrdinal / title / **labels** / conversion。
  定理型は + statement, proof。見出しは + level（本文を持てない）。**注記欄は持てない。**
- **参照用ノート** `notes/*.mjs`: id / **targets（紐づけ先ラベル、1件以上必須）** / title / sourcePath / body。
- ノード（本文の中身、両者共通）: text / math / displayMath / paragraph / list / **ref** / todo。
- 紐づけは**ノート → 本文の一方向**で、**ラベル**で指す（パス非依存）。数値検証との対応も同じくラベル基準。

### 残っている検討事項

`kind` に `note` / `remark` が残っているが content では**使用0件**（heading 10 / theorem 14 /
definition 50 / claim 72）。出版物の Remark 環境として将来使う余地はあるが、
「不要な構造を持ち込まない」方針からは削除候補。判断待ち。


## 完了（2026-07-25）: Phase 3 継続 — 線型独立性・離散フーリエ変換（hatZ/hatY）・その反交換関係を形式化

`lake build` 成功・`lean/scripts/check-no-sorry.sh` exit 0（`sorry` 0、主要定理 **84 件**が `sorryAx` 非依存）。
**このセッションでも commit / push はしていない。**

### 追加したファイル（人手証明の正本は `structured-latex/content/004_transfer_matrix.mjs` ほか）

| Lean | 人手証明（ラベル） |
| --- | --- |
| `lean/Ising2D/Part004/Claim001_ZYLinearlyIndependent.lean` | `004/001`（`<Z_Y_linearly_independent>`。**形式化時点では原文が TODO**） |
| `lean/Ising2D/Part004/Claim008_ExpSum.lean` | `004/008`（`<exp_sum>`）＋ `004/007` の `δ^M` |
| `lean/Ising2D/Part004/Definition009_HatZHatY.lean` | `004/009`（`<def_hatZ_hatY>`） |
| `lean/Ising2D/Part004/Claim012_HatPeriodicity.lean` | `004/012`（`<hatZ_hatY_M_periodicity>`） |
| `lean/Ising2D/Part004/Claim013_RecoverZY.lean` | `004/013`（`<recover_Z_Y_from_hatZ_hatY>`） |
| `lean/Ising2D/Part007/Claim000_AnticommutatorHatZHatY.lean` | `007/000`（`<anticommutator_of_hat_Z_and_hat_Y>`） |

既存の `Part000/Claim046_...` へ、反交換子の双線型性（有限線型結合の展開）を補助補題として追加した。

### 形式化した命題（主なもの）

- **線型独立性**（形式化時点で原文は「TODO: 証明略」。その後、別セッションが
  `{I,σ^x,σ^y,σ^z}^{⊗M}` 基底を使う人手証明を追記している）: Lean 側は
  `{Z_μ, Y_ν}` が Clifford 関係 `[e_a, e_b]₊ = 2 δ_{ab} I` を満たすことから、
  `∑ g_a e_a = 0` と `e_b` の反交換子をとって `2 g_b I = 0` を出す、という 3 行の議論で済んだ。
  既存の `Z_Y_generate_algebra` も `matrixUnitBasis` も不要だった。
- **離散フーリエ変換**: 位相因子 `expPhase M k = exp(-√-1·2πk/M)`（`k : ℤ`）を定義し、
  `expPhase M k = 1 ⟺ M ∣ k` を mathlib の `Complex.isPrimitiveRoot_exp` +
  `IsPrimitiveRoot.zpow_eq_one_iff_dvd` に帰着。`<exp_sum>` は原文どおり (a) 全項 1、
  (b) 等比和 `geom_sum_eq` の 2 ケースで証明。
- `hat(Z)_μ^{(±)}`, `hat(Y)_μ` の定義。`(±)` の符号は `j = 1` の項の係数 `η : ℂ` として持たせ、
  以降で効くのは `η² = 1` だけであることを明示した（`hatZPlus = hatZ (-1)`, `hatZMinus = hatZ 1`）。
  `M` 周期性は原文の特殊値 `μ = ±M` ではなく一般の `μ ∈ ℤ` で証明し、原文の主張を系として得た。
- **逆変換（復元）**: `Z` と `Y` で証明が同一なので、任意の族に対する `inverse_dft` を先に証明して
  両者を特殊化した。これにより「原文が `hat(Z)^{(-)}`（一様和）でしか復元を述べない理由」も明確になる
  （`hat(Z)^{(+)}` は `j = 1` の重みが `-1` なのでこの形の逆変換は成り立たない）。
- **`hat(Z), hat(Y)` の反交換関係 4 式すべて**（原文は後ろ 2 つを「同様」として省略）。
  原文の二重和展開を、(1) 反交換子の双線型性 → (2) `[Z_j,Z_k]₊ = 2Iδ_{jk}` で対角項だけ残す →
  (3) `<exp_sum>` を適用、の 3 段に整理した。

### 添字づけの規約（重要・以降も踏襲する）

原文のサイト添字は `1, …, M`、Lean は `Fin M`（`0, …, M-1`）。**原文の `j` は Lean の `(j : ℕ) + 1`。**
したがって位相因子は `expPhase M (((j : ℕ) + 1) * μ)` と書き、原文の「`j = 1` の項」は
Lean の `(j : ℕ) = 0` の項である。`hat` の添字 `μ` は `ℤ` のまま扱う（原文の `ℳ = {-M,…,-1,1,…,M}` は
定義式の意味には不要で、`M` 周期性も `μ ∈ ℤ` で成り立つ）。

## 完了（2026-07-25）: 出版を見据えたノートの分離（本文＝出版対象、ノート＝参照用）

構造化テキスト化の狙いは最終的に**論文・書籍**にすること。そこで
**「文書本体には出版に載るものだけを置き、ノートは別置きにしてラベルで紐づける」**構成にした。
最終成果物の生成は `content/` だけを読むので、**ノートは構造上いっさい混入しない**
（フラグの付け忘れで漏れる事故が起きない設計）。

- **原則: 「正しさに必要ならそれは注記ではない」。** 定義が意味をもつ条件・well-defined 性・
  主張から従う数学的帰結は `statement`（証明中の事柄なら `proof`）へ。補足計算・具体例・参考公式・
  原文由来のメモ・物理的解釈・先行研究との比較は `notes/` へ。
- **格上げ 5 件**（注記 → 本文）: 直交座標写像の well-defined 性 / フェルミオンは γ₂≠0 のときのみ定義
  （臨界点では ψ_M が存在しない）/ V' の和の限定で一般性を失わないこと / X の各項の well-defined 性
  （proof 冒頭へ）/ γ₂(θ_M)=0 ⟺ Ising 臨界点。
- **移設 16 件**（→ `structured-latex/notes/`、4ファイル）。本文が移設前とノード列レベルで完全一致することを
  機械確認済み（要約・圧縮なし）。独立していた注記ブロック2件も移設し、本文は 142→140 ブロックに。
- 事前判定から変えたもの: テンソル基底定理と平方根の3件は「statement で正しさが完結しており、注記は
  読み方・特殊化にすぎない」ため格上げせず移設。逆に直交座標写像の well-defined 性は格上げに追加。
- **検証**: `validate-content` が notes も検査し、**targets（紐づけ先ラベル）の未解決はエラーで落とす**。
  現在 140ブロック・ラベル78・参照143 全解決 / ノート16件・targets 16 全解決。
- ビューアはノートを紐づけ先ブロック内に折りたたみ（琥珀色の破線）で表示し
  「参照用ノート・最終成果物には載りません」と明示。ノートが無くても動作する（ドメイン非依存を維持）。
- 描画確認: 数式1655件エラー0・リンク切れ0・注記の非掲載明示が33箇所。

**非移行のまま**: 旧 main.typ 末尾の作業ログ134行（日付つき作業記録・デバッグ試行・数値スニペット）は
引き継ぎメモとタスク管理に置き換わっているため `_old/typst/` に残置。

## 完了（2026-07-25）: Typst を廃止し `_old/typst/` へ温存退避（証明の正本が構造化TeXへ）

**証明の正本は `structured-latex/content/`（142ブロック）になった。** Typst 一式
（`main.typ` / `theorem.typ` / `parts/` 130ファイル）は削除せず `_old/typst/` へ退避し、
参照用に**温存**する（削除候補ではない。破棄は改めて判断する）。

- 退避先 `_old/typst/README.md` に、温存の趣旨・現在の正本の所在・「ここを直しても正本には
  反映されない」旨を明記。**退避先で `typst compile main.typ` が成功することを確認済み**
  （作業ディレクトリをそこにすれば `parts` への相対パスがそのまま効く）。
- 出自パスを新所在へ一括更新（構造化TeX の `sourcePath` 131件 + 見出し10件、数値検証の
  overview 6件）。**全130種の出自パスが実在することを機械確認**。
- リポジトリ直下 `CLAUDE.md` のプロジェクト構成を更新（Typst 前提 → 構造化TeX 前提。
  「相互参照・数値検証の対応はラベルで張る」「変更したら通す検証コマンド3種」を明記）。
- 移行の健全性: `validate-content` 142ブロック・ラベル72・参照144全解決 /
  `verify-check-linkage` 6件 / ビューア描画 数式1659件エラー0・リンク切れ0。

### 今後の作業場所（重要）

証明の修正は**必ず `structured-latex/content/` 側**に入れる。`_old/typst/` は更新しない。

## 完了（2026-07-25）: Phase 3 継続 — 転送行列の記号定義・Z/Y の反交換関係・生成定理を形式化

`lake build` 成功・`lean/scripts/check-no-sorry.sh` exit 0（`sorry` 0、主要定理 43 件が `sorryAx` 非依存）。
**このセッションでも commit / push はしていない。**

### 追加したファイル

| Lean | 人手証明 |
| --- | --- |
| `lean/Ising2D/Part000/Claim046_CommutatorViaAnticommutators.lean` | `000/046`（`<commutator_via_anticommutators>`） |
| `lean/Ising2D/Part004/Definition000_TransferMatrixSymbols.lean` | `004/000`（`<def_transfer_matrix_symbols>`） |
| `lean/Ising2D/Part004/Claim014_ZYGenerateAlgebra.lean` | `004/014`（`<Z_Y_generate_algebra>`） |
| `lean/Ising2D/Part006/Claim000_AnticommutatorZY.lean` | `006/000`（`<anticommutator_of_Z_and_Y>`） |

### 形式化した命題（主なもの）

- `[a b, c] = a [b,c]₊ - [a,c]₊ b` を**任意の環**で（`Ising2D.commutator_via_anticommutators`）。
  反交換子 `Ising2D.acomm` は mathlib に無いので自前定義。交換子は mathlib の Lie 括弧と一致することも示した。
- Pauli 行列 `pauliX/Y/Z` と積公式（mathlib に Pauli 行列は**無い**ので自前）。
- サイト局所作用素 `siteOp k : Mat(2,ℂ) →ₗ[ℂ] TensorPow M`。
  `siteProd`（既存）の多重線型性から `MultilinearMap.toLinearMap` で作ったので、線型性はタダで付く。
  `sigmaX/sigmaY/sigmaZ`、同サイトの積 `siteOp_mul_same`、異サイトの可換性 `siteOp_mul_comm`。
- Jordan–Wigner 文字列 `Z m`, `Y m`（`m : Fin M`、0 始まり）、`xString`（`P_m = σ^x_1⋯σ^x_m`）、`epsilon`。
  原文が場合分けで書く `Z_1 := σ^z_1` は、空文字列 `xString M 0 = 1` から自動で従う（特別扱い不要）。
- **反交換関係 3 式すべて**: `anticomm_Z_Z`, `anticomm_Z_Y`, `anticomm_Y_Y`（原文は後ろ 2 つが TODO）。
  核は `siteProd_anticomm_of_single_site`（1 サイトだけ反可換ならテンソル積は反交換）。
  原文の「サイト μ の因子だけ符号が違う」という計算を、`MultilinearMap.map_smul_univ`
  （各サイトのスカラーがテンソル積の外へ ∏ で出る）で一般化した。
- **`Z_Y_generate_algebra`**: `Algebra.adjoin ℂ ({Z_m} ∪ {Y_m}) = ⊤`。
  原文 Step 2（帰納法）はそのまま写した。Step 3 だけ経路が違い、原文の `{I,σ^x,σ^y,σ^z}^{⊗M}` 基底ではなく
  既存の**行列単位基底** `matrixUnitBasis` を使った（どちらも `<tensor_basis>` の帰結で論法は同じ）。

### 形式化で表面化した原文の要修正点（新規）

- **`004/000` の `ε` の定義式が誤り**。`ε := σ^x_1 ⋯ σ^x_M = (√-1)^M Z_1 Y_1 + ⋯ + Z_M Y_M` の
  右辺は**和ではなく積** `(√-1)^M Z_1 Y_1 ⋯ Z_M Y_M`。
  根拠: `Z_m Y_m = σ^z_m σ^y_m = -√-1 σ^x_m`（Lean: `Ising2D.Z_mul_Y_same`）なので積なら一致するが、
  和だと `M = 2` で `(√-1)^2 (Z_1Y_1 + Z_2Y_2) = √-1 (σ^x_1 + σ^x_2) ≠ σ^x_1 σ^x_2` となり反例になる。
  Lean 側は `ε := σ^x_1⋯σ^x_M`（左辺）を定義とし、積表示の再帰形 `xString_succ_eq` まで証明済み。
- ~~**`006/000` の証明が未完（TODO 2 箇所）**~~ → **解消済み（下記「完了（2026-07-26）」参照）**。
  `[Z_μ,Y_ν]₊ = 0` は `μ = ν` でも成立する（`σ^y σ^z = -σ^z σ^y` で対角も消える）。

### 次にやること（Lean 側）

1. `004/001`（`Z_m, Y_m` は線型独立）— `Z_Y_generate_algebra` と `matrixUnitBasis` が使える。
2. `004/009` の `hat Z, hat Y` と `007`（その反交換関係）— `siteProd_anticomm_of_single_site` がそのまま効く。
3. `004/002`（`V_1 V_2` を `Z, Y, ε` で表す）— `V_1, V_2` の定義自体がまだ未形式化。
   `matExp` と `sigmaZ`/`sigmaX` で定義するところから。
4. `ε = (√-1)^M Z_1 Y_1 ⋯ Z_M Y_M`（積）の完全形。順序つき積（`List.prod` / `Finset.noncommProd`）の整備が要る。

## 完了（2026-07-25）: Phase 3 着手 — Lean 4 + mathlib4 の基盤構築と最初の formalization

実体は `lean/`。セットアップ手順・人手証明との対応規約・表現方針の根拠は `lean/README.md` に集約した。
**このセッションでは commit / push をしていない**（`lean/` 配下は作業ツリーに未コミットで存在）。

### 環境（バージョン固定済み）

- elan を新規導入（`~/.elan`）。`lean/lean-toolchain` = `leanprover/lean4:v4.32.1`。
- mathlib4 を **同名タグ `v4.32.1`** に固定（`lean/lakefile.toml` の `rev`、`lean/lake-manifest.json`）。
  toolchain とタグを揃えないとビルド済みキャッシュが効かないので、更新時は必ず両方同時に変える。
- `lake exe cache get` → `lake build` 成功（2405 jobs）。`.lake/` はリポジトリ直下 `.gitignore` で除外済み。

### `Mat(2,ℂ)^{⊗M}` の表現 — **行列表現を採用（最重要の設計判断）**

| | Lean での型 | 実装名 |
| --- | --- | --- |
| 採用 | `Matrix (Fin M → Fin 2) (Fin M → Fin 2) ℂ` | `Ising2D.TensorPow` |
| 比較 | `⨂[ℂ] (_ : Fin M), Matrix (Fin 2) (Fin 2) ℂ` | `Ising2D.AbstractTensorPow` |

**両者の ℂ-代数同型を証明済み**（`Ising2D.tensorPowAlgEquiv`）。同型写像は
`⨂ₜ x ↦ [(s,t) ↦ ∏ᵢ (xᵢ)_{s(i)t(i)}]`（= Kronecker 積）。構成は `PiTensorProduct.liftAlgHom` +
`Basis.piTensorProduct` と行列標準基底の突き合わせ。したがってどちらの表現で述べた命題も移送できる。

採用根拠（実際に両方書いて確認した事実）:

1. **抽象テンソル冪には `NormedRing` インスタンスが無く `NormedSpace.exp` が使えない**
   （`infer_instance` が失敗することを確認）。`V_1, V_2` が `exp` を含む本プロジェクトでは致命的。
   行列表現なら `Mathlib.Analysis.Normed.Algebra.MatrixExponential`（`Matrix.exp_units_conj` 等）が直接使える。
2. `<centralizer_is_scalar>`（`002/003`）が mathlib の `Matrix.center_eq_scalar_image` に帰着して数行で済む。
   人手証明の 4 ステップ（基底展開→積公式→係数比較→結論）が丸ごと既存で賄える。
3. 添字型 `Fin M → Fin 2` がスピン配置そのものなので、サイト局所演算子 `σ^x_k` 等を
   Kronecker 積の再帰なしに書ける。`Fin (2^M)` を使うと `finFunctionFinEquiv` の添字変換が散らばる
   （必要なら `Matrix.reindex finFunctionFinEquiv` で移せる）。
4. 行列式・跡・固有値・`Matrix.reindex` が全部使える（`008` の対角化 `P_μ, D_μ` で必要）。

### 形式化した命題（`sorry` 0。`lean/scripts/check-no-sorry.sh` で機械確認）

- `<tensor_basis>`（`002/000`）→ `Ising2D.tensorPowBasis` / `matTensorPowBasis`。
  mathlib の `Basis.piTensorProduct` に完全に帰着（自前で積んだ部分は「テンソル冪への特殊化」のみ）。
- `<conjugation_is_ring_homomorphism>`（`000/045`）→ `Ising2D.Conjugation.T_mul/T_one/T_add/T_comp/TMonoidHom`。
  mathlib の `MulSemiringAction (ConjAct Rˣ) R` に帰着（加法性まで込みで環準同型が出る）。
  原文の `Matrix.inv` 記法版も `matrix_conj_mul/one/comp` として併記。
- `<scalar_identity_commutes>`（`002/001`）→ `Ising2D.scalar_identity_commutes`。
- `<centralizer_is_scalar>`（`002/003`）→ `Ising2D.centralizer_is_scalar`（抽象側へ移送した版も併記）。
- 補助: 行列単位の積公式 `E_IJ E_KL = δ_JK E_IL`（`Ising2D.E_mul_E`）、`I = Σ_P E_PP`（`one_eq_sum_E`）、
  `exp(U A U⁻¹) = U (exp A) U⁻¹`（`matExp_units_conj`）。

### 形式化で表面化した原文の要修正点

- **`002/000`（`<tensor_basis>`）のステートメントが不正確**。
  (a) 「各 `(i_1,…,i_m)` について `e_{i_1}⊗⋯⊗e_{i_m}` **は基底である**」は誤り。基底なのは**族全体**。
  (b) 添字 `m` を「`V` の次元」と「テンソル冪の階数」に二重使用している（独立な量なので分離が必要）。
  Lean 側では修正版（基底の添字集合 `ι`、階数 `M` を分離し、族が基底）を形式化してある。
- **`000/045` Step 3 の正則性仮定は冗長**。合成則 `T_A ∘ T_B = T_{AB}` は
  `Matrix.mul_inv_rev`（mathlib では特異行列込みで成立）から仮定なしに従う。

### 次にやること（Lean 側）※ 1–3 は上の「Phase 3 継続」で完了済み

1. ~~`000/046`（交換子と反交換子の恒等式）~~ → 完了。
2. ~~`004/000` の記号定義と `006`（Z,Y の反交換関係）~~ → 完了。
3. ~~`004/014`（`Z, Y` が環として生成）~~ → 完了。
4. leanblueprint の導入検討は Phase 2（構造化TeX 移行）の完了状況を見てから。
5. mathlib に無いことが分かっているもの: `Real.arccosh`（自前定義が必要）。
   `Ad(exp X) = exp(ad X)` は `005/003, 007` の級数展開ルートで回避可能。

## 完了（2026-07-25）: Phase 2 T3/T4b — 章見出し・文書順・記号表を構造化TeXへ移行

`main.typ` にしか無かった「章題」「文書順」「インライン記号表」を `structured-latex/content/` へ移した。
これで証明本体で main.typ にしか無い情報は無くなった（残るは作業メモのみ。非移行と確定）。

- **schema に `heading` ブロックを追加**（`structured-latex/schema.mjs` / `schema.d.ts`）。
  `kind: "heading"` + `level`（1 が最上位。Typst の `=` が 1、`==` が 2）+ 必須 `title`。
  本文（statement/proof/notes）は持てない。ビューア側の契約
  （`realtime-web-preview/domain-model/src/block.ts`）も `kind` による discriminated union に更新し、
  `frontend/.../ui/heading-view.tsx` で描画。タイトルの `tex` を KaTeX で描く `TitleView` を追加
  （従来はブロックタイトルの LaTeX ソースが生文字列で表示されていた）。
- **文書順の正準表現＝ブロック配列の並び**（`content/*.mjs` をファイル名昇順 → 各ファイル内は配列順）。
  旧 `main.typ` の `#include` 順と完全一致することを機械照合済み（130 include / 130 sourcePath、差分0）。
  `sourceOrdinal` は「parts 章内でのソースファイル通し番号」であり文書順ではない。
  002章（000,001,**003,002**）と 008章（017 の直後に **036**、031 の後は 034,035,033,032,037,044,041,042,
  038,039,040,043）を実文書順へ並べ替え。008 の content 2ファイルは連番範囲で命名できなくなったため
  `008_TV1_hatZ_hatY_part{1,2}.mjs` へ改名。
- **記号表**: main.typ のインライン `#definition("記号の定義")` は `parts/004_転送行列/000`
  （`def_transfer_matrix_symbols`）との重複だった（相違は双対関係注記の旧版 `sinh(K)sinh(K*)=1` のみで、
  P1-1 で `sinh(2K)sinh(2K*)=1` に訂正済み）。重複ブロックは作らず、インライン側にのみ在った
  σ_k^y, σ_k^z, I_{(Mat(2,C))^{⊗M}}, Z_m/Y_m の p_m/q_m 対応を既存ブロックへ補記して集約。
- **非移行（確定）**: main.typ 末尾の作業メモ（`= 全体のノリ` / `= メモ` / 「次回やること」と
  埋め込み SageMath スニペット）は証明本体でないため移さない。
- 検証: `node structured-latex/tools/validate-content.mjs` → 142ブロック/14ファイル（見出し10・ラベル72・
  ref142 全解決）。`pnpm -r build` / `pnpm -r typecheck` / `biome check` 通過。KaTeX 全1647式 0エラー。
  `GET /api/document` で見出し10件が文書順に配信されることを確認。

## 完了（2026-07-22）: Phase 1 方針B — per-μ γ₂≠0 限定でフェルミオン定義域を厳密化

`docs/tasks/2026-07_toolchain-and-rigor` Phase 1 を Typst 上で完了。方針は **大域非臨界仮定（方針A）を採らず、per-μ の `γ_2(θ_μ)≠0` 条件で限定**。041/042 は削除せず γ₂=0 モードのカバレッジを保持。`typst compile main.typ` は exit 0（警告は既存の cetz deprecation と 002 linebreak の2件のみ、新規由来の警告・未解決 ref なし）。**push はしていない**（ブランチ worktree-cozy-sparking-token に未コミットで保持）。

変更/追加ファイルと要点:
- `parts/004_転送行列/000`: 双対注記を `sinh(2K_i)sinh(2K_i^*)=1` に訂正（旧 `sinh(K_i)sinh(K_i^*)=1` は誤り。K_i^*=-1/2 log(tanh K_i) と整合するのは 2K_i 版）。
- `008/023`（`<arg_of_gamma_2_mu>`）: 前提「γ₂(θ_μ)≠0 なる μ」を追加。末尾 `<0` を `|γ_2(θ_μ)|²=(s_2^*)²·((c_1cosθ_μ-s_1c_2)²+sin²θ_μ)` 経由で B>0 を明示して正当化し、負の実数ゆえ arg=π で claim を閉じた（従来は dangling）。
- `008/024`: 前提「γ₂(θ_μ)≠0」を追加（arg は非零でのみ定義、relation_of_gamma_2 で両者同値を明示）。
- `008/029`（`<def_fermi>`）: ψ_μ, ψ_μ^† を **γ₂(θ_μ)≠0 なる μ にのみ定義**と本体で限定。#note で「γ₂(θ_μ)=0（021 より μ=±M かつ臨界 c_1=s_1c_2、= 043 の Ising 臨界点 sinh2K_1 sinh2K_2=1）では正規化 1/γ_2(-θ_μ) が不能で **ψ_μ は存在しない**」を明記。臨界の μ は 041/042 場合2で hatZ,hatY 経由で直接処理。
- `008/030`,`031`,`037`: ステートメントを γ₂(θ_μ)（031 は γ₂(θ_ν) も）≠0 の μ,ν に限定。037 の X の和も 032 と同じ限定和に更新。特定される ν が限定和の添字集合に属することを明示。
- `008/032`（`<def_Vprime>`）: V' の和を `sum_(mu in {1..M} : γ_2(θ_mu)≠0)` に限定。除外 μ（臨界 μ=M）は 041 Step1 より γ(θ_μ)=0 ゆえ寄与なしを note で明示（041 の旧「規約」依存を解消）。
- `008/041`: 冒頭 #note の「係数0で項を落とす規約」を撤去し「032 の定義で和は γ₂≠0 の ν のみ」に変更。X を限定和に。Step 3 の場合分け「(i) γ(θ_ν)=0」を撤去（限定和では常に γ₂(θ_ν)≠0 ⟹ ψ_ν,ψ_{-ν} 定義済み、Step 2 対偶で δ=0）。Step 2 見出しの結論を γ_2(θ_ν)=0（ゆえに γ(θ_ν)=0）に。
- `008/044`（新規, `<A_theta_is_identity_when_gamma2_zero>`）: 小補題「γ₂(θ_μ)=0 ⟹ A(θ_μ)=I」を証明追加（γ₂(θ_μ)=0 ⟹ γ₂(-θ_μ)=0 [022] かつ det [034]+γ₁≥1 [035] で γ₁=1 ⟹ A=I）。main.typ に 037 と 041 の間で #include。042 場合2の A=I 裏打ちを 027（proof 無し）から本補題へ張り替え。026 の「TODO: 証明」コメントと 027 の A=I も本補題を #ref するよう更新（044 は 016/022/034/035/036 のみ依存、026/027 非依存ゆえ循環なし）。
- `038`/`039`: ステートメント不変。042（全 μ∈cal(M) で両場合カバー）+ 013（全 μ の DFT）経由で臨界含め全 x で成立を維持（compile・ref 解決で確認）。

未着手/TODO 保持:
- `021`（`<gamma_2_theta_is_0>`）と `043`（`<critical_condition_c1_eq_s1_c2>`）の proof は本 Phase では TODO 保持（方針Bの厳密性には非必須）。
- SageMath 数値再検証（X-1）は横断タスクとして継続（今回の変更はステートメント限定と補題追加が主で、030/037/038/039 の数値結論は不変のはず）。

## 進行中（2026-06-27）: 臨界点と γ₂(θ_M)=0 / V' 定義の穴のトレース

- 新規 claim `008/043`（`<critical_condition_c1_eq_s1_c2>`）: `c_1 = s_1 c_2 ⟺ s_1 s_2 = 1`（= Ising 臨界条件 sinh2K_1 sinh2K_2=1）。**proof は TODO**。数値確認済み（c_1=s_1c_2 の曲線上で sinh2K_1 sinh2K_2=1.0000）。
- これにより `γ_2(θ_M)=0`（θ_M=2π、021 `<gamma_2_theta_is_0>` で μ=±M かつ c_1=s_1c_2）⟺ **臨界点**。すなわち ψ_M が def_fermi で未定義になる特異点は臨界点そのもの。
- **「臨界点を除かないと議論できない」最初の箇所のトレース**:
  - 026（A(θ) 固有値・固有ベクトル）: γ₂=0/≠0 で場合分け済み、全 μ で OK（γ₂=0 では A=I）。
  - **027（P_μ, D_μ）が最初に明示的に `γ_2(θ_μ)≠0` を要求**（正規化 c=1/(2√M γ₂(-θ_μ)) に 1/γ₂）。臨界では μ=M で破れる。
  - 029（def_fermi）: ψ_μ を P_μ 経由で定義 → ψ_M が臨界点で未定義。
  - 030/031/037: 「μ∈cal(M) 全体」と称するが proof は ψ/P_μ 経由 → 実質 γ₂≠0 のモードのみ（臨界では μ=M を暗黙除外、ステートメントが過剰に広い）。
  - **032（V' 定義）で和 Σ_{μ=1}^M が μ=M を含むため、臨界点では V' という対象自体が大域的に未定義** = ここから議論が成立しない。038/039 はこれを継承。
- 対処方針（未着手）: 032 の和を「γ_2(θ_μ)≠0 の μ」に限定し非臨界の主張として閉じる / 臨界ゼロモードを別扱い。自由エネルギー導出の方針に依存。

## 完了済み（2026-06-21）: 013 符号バグ修正

数値検証（SageMath）で 013 の符号バグが判明し修正した。`typst compile main.typ` は exit 0（既存 cetz deprecation と 002 linebreak の2件のみ）。

- バグ内容: `<def_hatZ_hatY>`（004/009）の定義では `hat(Z)_mu^((-))` は全 j で重み +1（uniform）。superscript `(-)` のとき `minus.plus` の下側 = +1。ところが `013` が `c_j := cases(-1 if j=1, 1 else)` と置き j=1 を -1 にしていて定義と矛盾していた。
- 数値確認: 正しい復元は `Z_m = (1/M) sum_mu hat(Z)_mu^((-)) exp(+i m 2π μ/M)`（c_m なし）で誤差 1e-16。c_m 版は m=1 で `-Z_1` を返し誤差 2.0（誤り）。
- 修正: `004/013`（`<recover_Z_Y_from_hatZ_hatY>`）から c_j/c_m を全廃し hat(Z)^((-)) を uniform として Y 側と完全対称に再導出。`008/038`（`<T_V_eq_T_Vprime>`）Step2 の `c_m/M` を `1/M` に統一（c_m 定義削除）。`grep c_m|c_j` で 013/038 に残存なし（031 の c_mu はフェルミオン正規化因子で無関係）。
- 038 の定理自体は元々正しく結論 `T_((V))=T_((V'))` は不変。修正は誤った符号規約依存箇所のみ。042/030/037/def_fermi は正しい uniform 版を使用しており未変更。
- 038/039 は数値検証で全空間成立を確認済み（セクター '-'、hat(Z)^((-)) uniform）。`T_V(psi)=e^gamma psi` 全空間 1e-15、037 と整合。

## 次回やること（優先度順）

### 0. 構造化テキストのリアルタイム Web プレビュー（未着手・別ツール）

汎用ツールとしてリポジトリ直下 `realtime-web-preview/` に切り出した。要件は
`realtime-web-preview/docs/requirements.md`。本プロジェクトの `structured-latex/` は
その入力ソースのリファレンス実装という位置づけ。ビューア等は未実装、技術スタック未決定。

### 1. 038 `T_V = T_{V'}` の proof（完了 2026-06-21）

`038_claim_T_V_eq_T_Vprime.typ` の `#proof[TODO]` を完成。`typst compile main.typ` は exit 0（警告は既存の cetz deprecation と 002 の linebreak の2件のみ、新規由来の警告・未解決 ref なし）。

証明構成（環準同型 + 生成元一致）:
- Step1: 合成則 `<conjugation_is_ring_homomorphism>`（新規 000/045）で `T_(V) = T_V`（`V := (V_1^pm)^(1/2) V_2 (V_1^pm)^(1/2)`）。`T_(V), T_(V')` ともに単位的・乗法的・線型。
- Step2: `<recover_Z_Y_from_hatZ_hatY>`（新規 004/013, DFT逆変換）+ `<T_V_eq_T_Vprime_on_hatZ_hatY>`（新規 008/042）で各 `Z_m, Y_m` 上で一致。
- Step3-4: 一致元の集合が部分多元環をなし、`<Z_Y_generate_algebra>`（新規 004/014）より全空間。

新規ファイル: 000/045（共役写像は環準同型）, 000/046（交換子と反交換子 `[ab,c]=a[b,c]_+-[a,c]_+b`）, 004/013（DFT逆変換）, 004/014（Z,Y が環を生成）, 008/041（gamma_2=0 のとき T_(V') が hatZ,hatY を固定）, 008/042（T_(V) と T_(V') が hatZ,hatY 上で一致）。
ラベル付与した既存: 010(`def_T_g`),015(`def_T_V`),018(`def_theta_mu`),027(`diagonalization_P_D`),030(`commutation_V_psi`),033(`def_gamma_theta_mu`,`lambda_eq_exp_gamma`),034(`det_A_theta`),035(`gamma1_geq_1`),002/000(`tensor_basis`),004/000(`def_transfer_matrix_symbols`)。

gamma_2=0 障害の処理: gamma_2(theta_mu)=0 の mu ではフェルミオン未定義で P_mu 経路が使えない。041 で T_(V') が `[X,hatZ_mu]=[X,hatY_mu]=O` 経由で hatZ,hatY を固定と直接証明（鍵: gamma_2=0 ⇔ sin theta=0 かつ c_1 cos theta=s_1 c_2、mu≡±nu mod M ⇒ cos,sin 保存 ⇒ gamma_2(theta_nu)=0 ⇒ gamma(theta_nu)=0 で X の該当項が消える。普遍反交換子 `<anticommutator_of_hat_Z_and_hat_Y>` 使用）。042 で gamma_2≠0 は P_mu 可逆経由、gamma_2=0 は 041 + A(theta_mu)=I で統合。

【未解決の基盤上の注意】032 の V' 定義 `sum_(mu=1)^M psi_mu^dagger psi_(-mu)` は mu=M（gamma_2=0）で psi_M が未定義。041 では「係数 gamma(theta_M)=0 ゆえ当該項を省く」規約を note で明示し Step1 で coefficient=0 を別証。完全厳密化するなら 032 の和を「gamma_2(theta_mu)≠0 の mu に限定」へ書き換えるのが望ましい（今回は既存 proof を壊さない方針で規約対応）。

### 2. 039 `V = cV'` の proof（完了 2026-06-21）

`039_claim_V_eq_Vprime.typ` の `#proof[TODO]` を完成。**009（クリフォード群、TODO）には依存しない**方針に変更（中心性で証明）。`typst compile main.typ` は exit 0（既存の cetz deprecation と 002 linebreak の2件のみ、新規由来の警告・未解決 ref なし）。

証明構成（中心性経由、クリフォード群を経由しない）:
- 新規中心補題 `parts/002_線型空間の一般論/003_lemma_全行列と可換な行列はスカラー.typ`（`<centralizer_is_scalar>`）: `Mat(2,CC)^(⊗M)` の中で全元と可換な元は `c·I` に限る。行列単位 `E_(ij)` の積公式 `E_(ij)E_(kl)=δ_(jk)E_(il)` を `<tensor_basis>` でテンソル積に持ち上げ、`W=Σw_(IJ)E_(IJ)` を全 `E_(KL)` と可換 ⟹ 対角一定・非対角0 ⟹ スカラー。`002/001`（`<scalar_identity_commutes>`、逆向き）と対。main.typ に 001 の直後で #include 追加。
- 039 本体: `W := V'^(-1)V`（可逆）。`<T_V_eq_T_Vprime>`（Step1 の `T_((V))=T_(V)` 含む）+ `<mat_conj>` から全 x で `VxV^(-1)=V'xV'^(-1)`、`V=V'W`・`V^(-1)=W^(-1)V'^(-1)`（`<conjugation_is_ring_homomorphism>` の逆元公式）を代入し `Wx=xW`。中心補題で `W=cI`、可逆ゆえ `c≠0`、よって `V=cV'`、`c∈CC^×`。
- 039 のステートメントの `V` は `<def_T_V>` 由来の `V=(V_1^pm)^(1/2)V_2(V_1^pm)^(1/2)` と同一視（claim 本文と note に明記）。

## 完了済み（2026-05-30）

### structured-latex 残りファイルの変換

`structured-latex/content/` 以下へ残りの `parts/**/*.typ` の変換を追加済み。`node structured-latex/tools/validate-content.mjs` は 123 blocks で通過。

### 032/037 V' 符号修正と SageMath 検証

005（P_μ 正規化）の修正により、新しい反交換関係 $[ψ†_μ, ψ_ν]_+ = δ^M_{μ+ν,0} I$ で 031 が成立することは数値検証済み。しかし、現状の $V' := exp(-Σ_{μ∈M} γ(θ_μ)(ψ†_μ ψ_μ - 1/2))$ では:

$
"ad"(X)(ψ†_μ) = -2γ(θ_μ) ψ†_{-μ}
$

となり、$ψ†_μ$ は $"ad"(X)$ の固有ベクトルでない（$ψ†_{-μ}$ に写る）。よって 037 の Claim「$T_{(V')}(ψ†_μ) = e^{-γ}ψ†_μ$」は成立しない。

修正案:
$
V' := exp(+ sum_{μ=1}^M γ(θ_μ) (ψ†_μ ψ_{-μ} - 1/2))
$

- $ψ†_μ ψ_μ → ψ†_μ ψ_{-μ}$（反交換関係 $[ψ†_μ, ψ_ν]_+ = δ^M_{μ+ν,0}$ と整合）
- 和を $μ ∈ \{1, ..., M\}$ に半分（モードの二重計上を回避）
- 符号は $T_V$ と一致させるため $+$（030 で $T_V ψ†_μ = e^{+γ}ψ†_μ$）

これにより `[ψ†_μ ψ_{-μ}, ψ†_ν] = δ^M_{ν-μ,0} ψ†_μ` で、$ψ†_ν$ が固有ベクトルになる。

実施済み:
- `032_definition_Vprimeの定義.typ`: `V' = exp(+Σ γ(ψ†_μ ψ_{-μ} - 1/2))` に修正
- `037_claim_T_Vprimeのpsiへの作用.typ`: `T_(V')(ψ†_μ) = e^(+γ)ψ†_μ`, `T_(V')(ψ_μ) = e^(-γ)ψ_μ` に修正
- `sagemath/check/037_claim_T_Vprimeのpsi/`: `M=2,4`、`K1,K2` 7組で PASS
- `structured-latex/content/008_TV1_hatZ_hatY_20_40.mjs`: 032/037 の符号を同期
- `typst compile main.typ`: 警告のみで成功

### main.pdf の追跡停止

`exact-solution-of-2d-ising-model/main.pdf` は生成物として Git から削除し、`.gitignore` に追加した。

## 完了済み（2026-05-02）

### 005 P_μ 正規化の修正

- 026: claim 末尾に `<eigenvector_of_A_theta>` ラベル追加
- 027: $P_μ$ の自由定数を $c = 1/(2√M γ_2(-θ_μ))$ に固定
- 029: フェルミオン定義を新 P_μ に合わせて更新（note の簡約形に符号 $ε_μ$ 追加）
- 030: proof を $P_μ$ 抽象的に扱う形に簡素化（A = P D P^{-1} 構造を直接利用）
- 031: ステートメントを $δ^M_{μ+ν,0}$ に統一、proof で $c_μ c_ν$ 因子を頭で因子分け、係数 1 を導出
- 037: 反交換関係参照を更新、proof 構造の破綻を明示（remark + 中断 NOTE）
- SageMath: `sagemath/check/031_claim_psiの反交換関係/` で 3 ケース全 PASS（M=100、7 パラメータ）
- typst compile: エラーなし

## 完了済み（2026-04-04）

- 032: claim → definition に変更（`032_definition_Vprimeの定義.typ`）
- 033: `gamma(theta_mu)` の定義 + `lambda_pm = e^{+-gamma}` の claim/proof
- 034: `det A(theta_mu) = 1` の claim/proof（036 の行列分解を利用）
- 035: `gamma_1(theta_mu) >= 1` の claim/proof
- 036: `A(theta_mu) = B_1 B_2 B_1` の行列分解 claim/proof
- 037: `T_{V'}` の psi への作用 claim/proof（→ 005 で構造的問題が判明）
- 038, 039: claim のみ（proof TODO）

## 未完 TODO の根拠（005 行列空間の内積・ノルム・収束と ad 展開公式）

### `exp_conjugation_proof_002_theorem_Ad_exp_lie`（一般 Lie 群上の $\mathrm{Ad}(\exp X)=\exp(\mathrm{ad}X)$）

`todo()` を残した。根拠（一次情報）:

- `grep -rn "Lie群\|リー群\|\\mathrm{Lie}" structured-latex/content/` の結果、ヒットは
  `005_exp_conjugation_proof.mjs` 内の**この主張自身と、その直前の概要文だけ**である。
  多様体・Lie 群・Lie 環・$\mathrm{Lie}(G)$・$\mathrm{Aut}(G)$ の Lie 群構造を
  **定義したブロックはリポジトリに 1 件も存在しない**。すなわち主張の記号が意味をもつ土台が未整備で、
  証明以前に statement が定義されていない状態である。
- 原本 `_old/typst/parts/005_.../001_theorem_リー群上のAd(exp(X))=exp(ad(X)).typ` も
  proof は `TODO:` のみで、移行漏れではない（`verify-no-lost-proofs.mjs` も同判定）。
- **本論はこの一般版に依存しない。** 本プロジェクトで必要なのは行列環 $\mathrm{Mat}(n,K)$ 上の
  $e^{X}Ye^{-X}=e^{\mathrm{ad}_X}(Y)$ だけであり、これは新規ブロック
  `exp_conjugation_proof_010_theorem_matrix_exp_conjugation`（labels: `matrix_exp_conjugation`）で
  **完全に証明済み**。その旨をこのブロックの statement 本文にも明記した。

埋めるための条件: 多様体・Lie 群・Lie 環・指数写像の定義ブロックを整備し、
$\mathrm{Aut}(G)$ が Lie 群で $\mathrm{End}(\mathfrak{g})$ がその Lie 環であることを示すこと。

### 同章で完成させたもの（参考）

- `exp_conjugation_proof_003_definition_M_n_C_convergence`（内積・ノルム・収束、TODO 3 件）→ 完成。
  Frobenius 内積 $\langle A,B\rangle=\mathrm{tr}(A^{*}B)$ を新規定義（labels: `def_frobenius_inner_product`）。
  ノルム・収束・完備性は 002 章で既に定義・証明済み（`def_matrix_norm` / `matrix_norm_triangle_inequality` /
  `matrix_norm_submultiplicativity` / `matrix_completeness`）なので**重複定義せず参照で結んだ**。
  非可算集合 $\mathbb{R}/\mathbb{C}$ の完備性へ移行する箇所を statement (5) で明示。
- 新規 `exp_conjugation_proof_003b_claim_frobenius_inner_product_axioms`（labels: `frobenius_inner_product_axioms`）:
  Hermite 内積の公理・Cauchy--Schwarz・そこからの三角不等式を証明。
- `exp_conjugation_proof_004_theorem_ad_binomial`（labels: `ad_binomial`）→ $m$ の帰納法で完成
  （Pascal の法則を Step 1 で明示）。原本 note の「未証明につき使用禁止」は撤回した。
- 新規 `exp_conjugation_proof_010_theorem_matrix_exp_conjugation`（labels: `matrix_exp_conjugation`）:
  $\|Q_N-P_N\|\le 2\|Y\|E(a)R_{\lfloor N/2\rfloor}(a)\to 0$ という評価で、二重級数の一般論を使わずに証明。

### 隣接 TODO（2026-07-26 に解消済み）

`exp_conjugation_proof_008_theorem_exp_ad_series`（labels: `brianhall_exc14`）、
`exp_conjugation_proof_009_theorem_exp_conjugation_main`（labels: `brianhall_3.35`）の
「未証明につき使用禁止」注記、および `008_TV1_hatZ_hatY_part1.mjs` の `exp_X_Y_exp_-X` の
「暫定」proof は、いずれも `matrix_exp_conjugation` を根拠に完全証明へ書き換えて解消した。
詳細は本ファイル冒頭の「完了（2026-07-26）: `todo()` 以外の形で残っていた未完 4 箇所」を見よ。
なお `exp_conjugation_proof_002`（一般 Lie 群版）は上記の根拠により **`todo()` のまま残置**である。
