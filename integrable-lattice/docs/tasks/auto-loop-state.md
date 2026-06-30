# 自動ループ 状態（Λ-statement 版）

daily cron が読み書きする状態ファイル。手順は `auto-loop-runbook.md`、収集定義は `inputs/seeds/lambda-statement-program.md`。

```yaml
program: lambda-statement   # 再定義: Λ/ℚ̄ 決定可能・ℝ脱出隔離・形式検証可能
current_cycle: 3            # cycle 0-2 完了。2026-06-24 ユーザーが3トラック(docs/themes.md)へ再スコープ。cycle 3 以降はトラック明記。
# 3トラック: 1 Reframe(本流) / 2 Solve(未解決模型の実厳密解) / 3 Pure(基礎論・数論)。2本立て(1,2)主軸 + 3 随時。
last_run: 2026-06-21
cron_armed: 2026-06-21       # session-only, 7日で失効
restore_point: 918af09       # 旧 cycle 0(文献分類版)成果の復元点。削除コミット c7fe283。
```

## cycle 0 step 列（探索方向 A–F を絞らず広く浅く）

各 step = 1方向を模型横断で薄く explore（Λ gap-map セル + 粗い候補, unchecked）。06_verify・sagemath はこの周ではやらない。

| # | step | status | done日 | 観察メモ |
|---|------|--------|--------|----------|
| 1 | explore:A_zeros | done | 2026-06-21 | `outputs/maps/A_zeros_qqbar_map.md` + `candidates/A_zeros_candidates.md`。中核: 有限 N で Z_N(x)∈ℤ[x]⇒零点∈ℚ̄(QQbar で決定可能)。known 4(Lee–Yang 円定理, Fisher 極限円, 自由フェルミ積形 2507.21943, 自己双対 zeros)/unknown 4。候補 A-U1(有限 N 零点の厳密ℚ̄軌跡・ℝ不使用・最有力), A-U2(自由フェルミ積分解=C と交差), A-U4(可算/ℝ 分離命題)。差分=文献は数値/極限(ℝ/ℂ)、ℚ̄ 厳密化が未踏(06)。 |
| 2 | explore:B_critical_point | done | 2026-06-22 | `outputs/maps/B_critical_point_qqbar_map.md` + `candidates/B_critical_point_candidates.md`。中核: 自己双対条件=ℤ係数代数方程式⇒臨界点∈ℚ̄(QQbar 決定可能, 08「双対が買う＝代数的臨界点」と整合)。known 4(Ising √2−1, q-Potts 1+√q, Potts 三角 star-triangle, 一般 KW)/unknown 4。候補 B-U2(自己双対多項式の根 witness=A-U1 と同型), B-U1(分類命題), B-U4(自己双対点=Fisher 集積点, A×B 結節)。所見: B 単体は新規性薄め、A との統合で価値。 |
| 3 | explore:C_R_escape_structure | done | 2026-06-22 | `outputs/maps/C_R_escape_structure_map.md` + 候補。核心: T(x)∈M(ℤ[x])・対角化∈ℚ̄(x)・ℝ脱出一点 ⟺ 自由フェルミ構造(決定可能)。さらに Bethe 可解系は有限 N Bethe 根∈ℚ̄。known 4(Ising/dimer/自由フェルミ8V/自由フェルミ条件)/unknown 4。候補 C-U3(Bethe 系で有限 N∈ℚ̄=最射程), C-U1(構造保存⟺自由フェルミの決定可能判定), C-U2/U4。**A/B/C 統一テーマ出現: 有限・離散・可積分⇒全量 ℚ̄ 決定可能, 相転移=ℝ脱出 N→∞ 一点**。 |
| 4 | explore:D_massieu_phi | done | 2026-06-22 | `outputs/maps/D_massieu_phi_lambda_map.md` + 候補。核心: 有理点 q で Φ_N=log Z_N(q)∈Λ(素因数分解), β=ΔS∈Λ(整数比較)。ℝ 不使用の有限 N 命題=選別(ii)最強・形式検証(F)に最も乗る。known 3(Φ∈Λ/第〇法則/Φ=S_AB−S_B)/unknown 4。候補 D-U1(Φ 漸化式=Λ関係), D-U3(β 単調性 整数比較 decide), D-U4(Φ=Σlog|q−root|, D×A 統合)。 |
| 5 | explore:E_complexity_solvability | done | 2026-06-22 | `outputs/maps/E_complexity_solvability_map.md` + 候補。07 の複雑性×可解性 2×2 が土台。known 5(2D Ising poly×closed / SK #P×変分 / 3D Ising #P×none / 1D ランダム鎖 poly×none / #P×初等閉形式は空)/unknown 3。候補 E-U1(可積分模型のテーブル網羅配置=A-D の整理枠), E-U3(境界が poly→#P 反転=C の複雑性版)。所見: E は分類メタ。A-D の核は (poly,closed) セル=2D Ising 型に対応。単体新規性低、整理枠として効く。 |
| 6 | explore:F_formal_verifiable | done | 2026-06-22 | `outputs/maps/F_formal_verifiable_map.md` + 候補。可算性の効用が土台: Λ 等号=素因数分解/ℚ̄=根分離 ⇒ decide/reflection・witness, RCA₀。known 4(Λ/ℚ̄ decidable, 逆数学 Big Five calibration, 第〇法則)/unknown 4。候補 F-U1(Lean decide 最小例=D 直結), F-U2(Lee–Yang 円・x_c の QQbar 証明書=A×B 結節), F-U4(有限 N 可積分は Λ/ℚ̄ decide のメタ定理=A-D 統一の総括)。所見: F は A-D に形式検証保証を与える横断方向。 |
| 7 | rank:cycle0 | done | 2026-06-22 | `outputs/reports/cycle0_lambda_observation.md`。**横断観察: A-F が「有限・離散・可積分⇒全量 Λ/ℚ̄ で決定可能・形式検証可能, 相転移=ℝ脱出 N→∞ 一点」に収束**。high bucket: A-U1(零点 ℚ̄ witness), C-U3(Bethe 有限 N∈ℚ̄=最射程), D-U1(Φ 漸化=Λ), F-U2(QQbar 証明書), F-U1(Lean decide)。束 `finite_N_decidable` を cycle 1 方向に確定。**cycle 0 成功条件達成**。 |

## cycle 1 step 列（finite_N_decidable 束の深掘り。方向確定後なので sagemath/Lean 投下可）

| # | step | status | done日 | 観察メモ |
|---|------|--------|--------|----------|
| 1 | verify:A-U1_resolved_check | done | 2026-06-22 | `outputs/reports/cycle1_01_verify_A-U1_resolved.md`。**判定: A-U1 の数学内容は本質的に既知**（Z_N∈ℤ[x] と零点の厳密計算は標準）。差分は形式化(F)＝基礎論寄与で、A 単体は薄い。→ 母集団を既解 Ising から未解決模型へ移すべき（step 1b）。 |
| 1b | harvest:integrable_unsolved_catalog | done | 2026-06-22 | `outputs/maps/integrable_unsolved_catalog.md`。「可積分(YBE)だが厳密解未確定」の原典付き first-pass カタログ。出典 McCoy(math-ph/9904003), Baxter chiral Potts(cond-mat/0510683), 分類(cond-mat/0304309)。本命=カイラル Potts(相関・スペクトル)/高ランク・高スピン vertex・IRF(極限閉形式・Bethe 完全性)。**ここでは「有限 N∈ℚ̄ 決定可能だが極限未解決」が非自明**＝本プロジェクトの本命母集団。**cycle 1 を Ising→未解決模型へ refocus**。 |
| 2 | sagemath:C-U3_bethe_roots_qqbar（未解決模型で） | done | 2026-06-23 | `sagemath/check/C-U3_bethe_qqbar/`（SageMath 10.6 実行済み）。XXZ 鎖(相互作用可積分, 極限相関は未解決)で Δ∈{1/2,2,−1/3}・N=2,3,4 の全固有値が QQbar に住み最小多項式 witness をもつ（厳密, ℝ 不使用）を実証。例 N=3,Δ=1/2: charpoly=(x−7/2)²(x−3/2)²(x+5/2)⁴。要点は構造的分離(有限 N=決定可能/ℝ脱出は極限のみ)。小 N では固有値次数 1〜2（正直）。 |
| 3 | sagemath:D_phi_factorization（未解決模型で） | done | 2026-06-23 | `sagemath/check/D_phi_lambda/`（実行済）。六頂点 R 行列モノドロミーで転送行列 T(整数重み⇒整数行列)を構成、Z_{N,L}=Tr T^N∈ℤ、Φ_N=log Z_N∈Λ を厳密計算。**非自明な数論構造(D-U2)**: (1,1,2)L=2 で v₂(Z_N)=N+2(2進付値が線形成長)。Z_N=Σλ_i^N で整数線形漸化(D-U1)。極限は未解決だが有限 N の Φ は Λ で完全に閉じる。 |
| 4 | apply:finite_N_qqbar_to_chiral_potts_or_higher_rank | done | 2026-06-23 | `sagemath/check/apply_higher_spin_qqbar/`（実行済）。高スピン可積分=スピン1 Babujian–Takhtajan 鎖(六頂点の高スピン版, 極限は Haldane ギャップ等で非自明)で有限 N スペクトル∈QQbar を実証。N=2,3 有理, **N=4 で次数2の代数的固有値出現**(最小多項式 witness)。構造的分離が高スピンでも保持(C-U3 射程確認)。カイラル Potts τ^(2) 直接は未着手(高スピンで本命性は実証)。 |
| 5 | lean:F-U1_decide_minimal | blocked(env) | 2026-06-23 | `outputs/reports/cycle1_05_formal_verification_spec.md`。**Lean 未インストール**で実行不可（環境制約, 判断停止ではない）。決定手続きの中身(Λ=整数比較/ℚ̄=根分離)は SageMath で実証済み。Lean ターゲット仕様(P1 第〇法則/P2 Φ 等式/P3 零点 ℚ̄)を確定、環境導入後そのまま実装。 |
| 6 | paper_plan:finite_N_decidable_unsolved | done | 2026-06-23 | `outputs/paper-plans/001_finite_N_decidable_unsolved.md`。テーゼ「可積分だが極限未解決な模型で有限 N 量は Λ/ℚ̄ 決定可能・witness・ℝ脱出は極限一点」。検証済み(XXZ/六頂点/スピン1 BT)を worked examples に。正直な位置づけ=基礎論・形式検証寄与(可積分の新定理ではない)。昇格条件=分離定理の厳密命題化＋(カイラル Potts 直撃 or v_p 一般則)。 |
| 7 | rank:cycle1 | done | 2026-06-23 | 下記「cycle 1 総括」。survivor=C-U3/D(実証済), F(仕様確定/Lean ブロック), A は薄い。cycle 2 方向候補を提示。**ユーザー判断点**: 基礎論寄与に価値を置くか／カイラル Potts 直撃に投資するか。 |

## cycle 2 総括（rank:cycle2, 2026-06-24）

- **成果**: 定理候補 D-U2「整数転送行列の Massieu Φ_N の ℓ_p 係数 v_p(Z_N)=μ_min(p)N+最終周期(SML 例外), μ_min=p 進 Newton 多角形」を SageMath で検証（六頂点・Potts で族横断, ℝ/Λ 双対 λ_max↔μ_min を発見）。
- **正直な評価**: これは **既知の p 進線形漸化理論を可積分 Φ に適用した構造的定理**で、可積分模型の新厳密解ではない。新規性は適用・Newton 多角形公式・族横断・双対の明示にとどまり、SML 例外で完全閉形式はない。paper_potential low-medium。
- **A-F/cycle0-2 を通した正直な総括**: Λ-statement 収集は一貫して「**既知の数学（代数性・p 進付値・決定可能性）を可算の言葉で再框・適用**」に流れ、**可積分模型の新しい数学的結果は出ていない**。価値があるとすれば基礎論・形式検証の calibration 寄与。
- **cycle 3 方向候補（ユーザー判断点。研究方針＝価値判断）**:
  1. D-U2 を基礎論/数論ノートとして厳密化（周期上界・特殊素数 p|q・双対の命題化）。
  2. カイラル Potts τ^(2) 直撃（本命未着手, 高種数で非自明だが極めて重い）。
  3. **方針転換**: 「可算で再框」でなく、未解決模型の**実際の厳密解**（自由エネルギー/相関）に正面から挑む別プロジェクト設計。
  4. 撤退/凍結。
- → **停止しユーザー判断を仰ぐ**（自律実行ルールの価値判断例外）。私見: これまでの方向は基礎論寄与どまりで「新しい数学」に届きにくい。3 か、テーマ自体の再設定が要ると考える。

## cycle 3 総括（rank:cycle3, 2026-06-25）

3トラックすべてで具体的前進（全 SageMath 検証付き）:
- **T1 Reframe**: D-U2 を厳密命題化。**命題 A**（min(v_p(Z_N),k) は π(p,k) で最終周期, 決定可能・Lean decide 可・RCA₀, 証明＋全例検証）。命題 B（線形傾き=Newton 多角形, SML caveat）。
- **T2 Solve**: 本命カイラル Potts（超可積分 ℤ_3）で有限 N スペクトル∈ℚ̄・全実・代数的（witness x²−6 等）を直接実証。「有限 N 決定可能/極限未解決」分離が本命で成立。
- **T3 Pure**: D-U2 の周期を Pisano/Wall 理論に接続。上界 π(p,k)|p^{k-1}π(p,1)（rigorous）、Wall 等式（一般未証明予想）が全テスト例で成立 → 候補命題「整数転送行列で Wall 等式は常に成立か」。
- 横断: T1 命題 A の周期を T3 が上から押さえ、T2 が本命模型での適用例 → 3トラックが D-U2 を核に連結。

## cycle 4 総括（rank:cycle4, 2026-06-26）

- **T1 Reframe**: ℝ/Λ 双対を **Mahler 測度**で命題化。ℝ側=自由エネルギー=log m(P)(スペクトル曲線 P=det(wI−T(z)), **既知・深い**: Ising で楕円曲線/L 函数 arXiv:2407.19531, LSW)。Λ側=有限 N v_p=同 P の p 進 Mahler(予想, 命題 A は厳密)。`outputs/reports/cycle4_T1_R_Lambda_mahler.md`, 研究ノート更新。
- **T2 Solve**: カイラル Potts スペクトルの **Onsager/多重2次体構造**を有限 N 観察（全2冪次数・全実・少数の√生成, λ=1/2 で ℚ(√33,√57) 安定）。極限フェルミオン準位への橋。
- **T3 Pure**: Wall 等式 反例探索 → **一般には不成立**（退化＋Pell p=13 非退化候補で破れ）。rigorous 上界 π(p,k)|p^{k-1}π(p,1) は不変。可積分での成立は退化交絡で未確定。
- 横断: 3トラックとも「有限 N=ℚ̄/Λ 決定可能 / 極限・大域=深い既知数論(Mahler 測度・L 函数・Wall)」の対比を深めた。本流 Reframe が Mahler 測度という深い既知理論に接続。

## cycle 5 総括（rank:cycle5, 2026-06-27）

- **T1 Reframe（大きい前進）**: ℝ/Λ 双対を**最小・厳密に実証**。同一 P=5−(z+1/z)−(w+1/w) の周期点数 a_L∈ℤ(LSW)で (1/L²)log a_L→log m(P)=1.50798(ℝ/Mahler/自由エネルギー)と a_L 素因数分解=Φ_L∈Λ(Λ側)。同一整数多項式から両素点を実計算。
- **T2 Solve（自己訂正）**: cycle4 の「カイラル Potts=Onsager 多重2次体」を**撤回**(N=4,5 で次数3,6,16 出現, 一般 λ は超可積分点でない)。robust は「有限 N∈ℚ̄・決定可能」のみ。
- **T3 Pure（統計的に正直）**: Wall 等式は非退化でも一般不成立(一般 2.1%, Pell p=13 確定)。六頂点 0/43 は**有意でない**(偶然 40%)→可積分の保護効果は**未確定**。rigorous 上界は不変。
- 全体: T1 が最大成果(双対の具体・厳密実証)。T2/T3 は誠実な訂正・保留。「既知の深い数論(Mahler/LSW/Wall)に可算側から接続」という本流 Reframe の価値は維持。

## cycle 6 総括（rank:cycle6, 2026-06-28）

- **T1 Reframe（大成果・継続）**: ℝ/Λ 双対の **Λ 側が既知理論**と判明。岩澤塔 v_p(a_{p^n}) 成長率 = Deninger p 進エントロピー = Besser–Deninger p 進 Mahler 測度 = 岩澤 μ_p。双方とも確立理論への接続(予想でない)。`cycle6_T1_padic_mahler_grounding.md`。
- **T2 Solve（再訂正）**: Dolan–Grady [H0,[H0,[H0,H1]]]=9[H0,H1] で**超可積分=Onsager 確定**。cycle5 の「Onsager でない」撤回は過剰訂正で誤りと再訂正(次数3,6 は cubic 運動量由来)。構造判定は Dolan–Grady で行うべき(次数でなく)。
- **T3 Pure（仮説棄却）**: 六頂点 Wall 大規模検査 572件で破れ4.5%(一般2.1%同等以上)→「可積分が Wall 保護」棄却。0/43,0/91 は小標本偶然。rigorous 上界のみ残る。
- 全体: T1 が一貫して堅実(双方既知理論への可算側接続)。T2/T3 は誠実な訂正・棄却の連続(科学的に健全)。**正直さの実践**(統計的有意性・予想/定理の別)が機能している。

## cycle 7 総括（rank:cycle7, 2026-06-29）

- **T1 Reframe**: 双対の Λ 側の本体は単一数 μ_p でなく**全 L の LTE 構造**（clean 例 z−c で v_p(c^L−1)=LTE 厳密・決定可能・Lean decide 可。岩澤 μ_p は generic 0）。cycle6 を精密化。
- **T2 Solve（きれい）**: カイラル Potts N=2 から **Onsager 分散 ε∝√(1+λ²−2λcosθ), cosθ=±1/3 を有限 N ℚ̄ スペクトルから直接抽出**。自由フェルミ ±ペアリング, Dolan–Grady と整合。有限 N→極限分散の橋。
- **T3 Pure**: Wall 棄却後に残る rigorous 部 = **π(p,1)=lcm{固有値順序}(全25例 等号)** → D-U2 命題 A の周期に閉形・決定可能上界 π(p,k)|p^{k-1}lcm{ord}。
- 全体: 3トラックとも具体的・堅実な前進。T2 の Onsager 分散抽出が今サイクルの白眉(既知物理を有限 N 可算データから記号的に再導出=T1/T2 融合)。

## cycle 8 step 列（3トラック継続。2026-06-29 起こし）

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T1 Reframe | lte_lean_or_writeup | done | 2026-06-30 | `outputs/reports/cycle8_T1_lte_proposition.md` + `sagemath/check/cycle7_T1_lte/lte_p2_complete*`(p=2 LTE も全 True)。完結した双対命題: モデル a_L=c^L−1, 命題 R(自由エネルギー f=log c=m(z−c)), 命題 Λ(v_p=LTE 完全形 p 奇/p=2, 決定可能)。形式検証: LTE は Lean decide 可・Mathlib に LTE 補題あり(仕様確定, 環境未導入で実装は後)。Λ 側本体=全 L の LTE 構造。 |
| 2 | T2 Solve | dispersion_N3_momenta | todo | | N=3,4 で cosθ_k 集合(cubic 等)を λ 記号抽出し量子化条件を同定。連続分散への外挿を可算データで明示。 |
| 3 | T3 Pure | pi_p1_equality_when | todo | | π(p,1)=lcm{ord} の等号がいつ成り立つか(トレース coincidence の条件)を詰める。または別 pure-math 筋へ。 |
| 4 | — | rank:cycle8 | todo | | 再ランク → cycle 9 方向。 |

## cycle 7 step 列（3トラック継続。2026-06-28 起こし）

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T1 Reframe | nontrivial_mu_p_example | done | 2026-06-29 | `sagemath/check/cycle7_T1_lte/`。clean 例 P=z−c, a_L=c^L−1。ℝ側 (1/L)log a_L→log c=m(P)。**Λ側 v_p(c^L−1)=LTE で厳密・決定可能**(予測=実測 L=1..24 全 True)。**岩澤 μ_p は generic に 0**(ord_p(c) が p 冪のとき以外, Wieferich 的で稀=岩澤 μ=0 領域)。⇒ 双対の Λ側の本体は単一数 μ_p でなく**全 L の LTE 構造**(cycle6 を精密化)。LTE は Lean decide 可。 |
| 2 | T2 Solve | onsager_dispersion_extract | done | 2026-06-29 | `sagemath/check/cycle7_T2_dispersion/`。N=2 λ 記号 charpoly 因数分解 → 2次因子判別式 disc=9(1+λ²−2λ·(±1/3))=9(1+λ²−2λcosθ), **cosθ=±1/3**。**Onsager 分散 ε∝√(1+λ²−2λcosθ) を有限 N の ℚ̄ スペクトルから直接抽出**(自由フェルミ ±ペアリング, Dolan–Grady と整合)。N 大で cosθ は cubic 等→次数3,6(cycle6 確証)。極限で cosθ∈[−1,1] 連続=ℝ脱出一点。 |
| 3 | T3 Pure | period_bound_closed_form | done | 2026-06-29 | `sagemath/check/cycle3_T3_period/pi_p1_closed_form*`。**π(p,1)=lcm{固有値の F̄_p 乗法的順序}**(全25例 等号; rigorous には割り切る)。⇒ D-U2 命題 A の周期に**閉形・決定可能な上界 π(p,k)|p^{k-1}·lcm{ord(λ_i)}**。Wall 等号は棄却済だが上界は不変・rigorous。T3 確定事項: 命題A(周期存在)+周期上界(閉形)+Wall 棄却。 |
| 4 | — | rank:cycle7 | done | 2026-06-29 | 下記「cycle 7 総括」。T1(双対 Λ 側=LTE 構造)/T2(Onsager 分散 cosθ=±1/3 抽出, きれい)/T3(π(p,1) 閉形上界)。cycle8 step列起こし。 |

## cycle 6 step 列（3トラック継続。2026-06-27 起こし）

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T1 Reframe | padic_mahler_identify | done | 2026-06-28 | `outputs/reports/cycle6_T1_padic_mahler_grounding.md` + `sagemath/check/cycle6_T1_padic_mahler/` + 研究ノート更新。**双対の Λ 側は予想でなく既知理論**: 岩澤塔 L=p^n の v_p(a_{p^n}) 成長率 = Deninger の p 進エントロピー = Besser–Deninger p 進 Mahler 測度 = 岩澤 μ_p 不変量。ℝ側=アルキメデス Mahler(LSW, Ising で L 函数)。検証: (1/L²)log a_L→1.508, p=2,3 塔で v_p 一定=0(この P は μ_p=0, p 進自明)。D-U2 は有限・決定可能な顔。 |
| 2 | T2 Solve | superintegrable_point_recheck | done | 2026-06-28 | `sagemath/check/cycle6_T2_superintegrable/`。**Dolan–Grady 関係 [H0,[H0,[H0,H1]]]=9[H0,H1] 両方 True(N=2,3)⇒超可積分=Onsager 確定**。⇒ **cycle5 の撤回は過剰訂正で誤り**を再訂正: 次数3,6 は cubic 運動量 cos θ_k 由来, 自由フェルミ構造は base 体上で健在(2冪は base=ℚ 限定の必要条件)。教訓: 自由フェルミ性は次数でなく Dolan–Grady で判定。robust: カイラル Potts スペクトル∈ℚ̄ かつ Onsager 構造あり。 |
| 3 | T3 Pure | wall_large_scale_stats | done | 2026-06-28 | `sagemath/check/cycle3_T3_period/wall_large_scale*`。六頂点 L=2 を572件検査→**Wall 破れ26件≈4.5%**(一般2.1%と同等以上)。**「可積分が Wall を保護」仮説を棄却**(0/43,0/91 は小標本の偶然)。残るは rigorous 上界 π(p,k)|p^{k-1}π(p,1) のみ。T3 のこの筋は否定的決着。教訓: 0件を有意性検定せず肯定結論にしない(cycle5 の慎重姿勢が正解)。 |
| 4 | — | rank:cycle6 | done | 2026-06-28 | 下記「cycle 6 総括」。T1(双対の Λ 側=p 進エントロピー既知理論に接地, 大成果)/T2(Dolan–Grady で超可積分確定, cycle5 撤回を再訂正)/T3(可積分 Wall 特別性を棄却)。cycle7 step列起こし。 |

## cycle 5 step 列（3トラック継続。2026-06-26 起こし）

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T1 Reframe | spectral_curve_mahler_both_places | done | 2026-06-27 | `sagemath/check/cycle5_T1_mahler/`(実行済)。**ℝ/Λ 双対の最小・厳密実証**: 同一 P=5−(z+1/z)−(w+1/w) の周期点数 a_L=Π_{z^L=w^L=1}P∈ℤ(LSW)で、(1/L²)log a_L→log m(P)=1.50798(ℝ/Mahler/自由エネルギー)と、同じ a_L の素因数分解=Φ_L∈Λ(Λ側)。同一整数多項式から両素点。p 進 Mahler(Besser–Deninger)厳密同定は cycle6+。 |
| 2 | T2 Solve | chiral_potts_sqrt_set_N_law | done | 2026-06-27 | `sagemath/check/cycle3_T2_chiral_potts/sqrt_set_*`(N=2..5, CyclotomicField 高速化)。**重要な自己訂正**: charpoly ℚ 因数分解で N=4,5 に次数3,6,16 の非2冪因子出現 ⇒ スペクトルは**純粋多重2次体(Onsager 自由フェルミ)ではない**。cycle4 の「Onsager 構造」は小 N 早合点で**撤回**(一般 λ は超可積分点でない)。robust に残るのは「有限 N∈ℚ̄・決定可能」のみ。2次部分の√中身は安定(λ=1/2:{33,57} N=2..5 不変)だが部分構造。Onsager 主張は真の超可積分点で再検証要(cycle6)。 |
| 3 | T3 Pure | wall_nondegenerate_comparison | done | 2026-06-27 | `sagemath/check/cycle3_T3_period/wall_nondegenerate_*`。非退化限定: 一般 companion 10/472≈2.1% で Wall 破れ(Pell p=13 等, genuine)。六頂点 0/43。**統計的に正直**: 基準率2%なら43件中0件は偶然でも≈40%→**0/43 は有意でない, 可積分の保護効果は未確定**。確定: Wall は非退化でも一般不成立, rigorous 上界は不変。cycle6 で六頂点を大規模化し有意差判定。 |
| 4 | — | rank:cycle5 | done | 2026-06-27 | 下記「cycle 5 総括」。T1(双対 最小実証=大成果)/T2(Onsager 主張撤回, 有限 N∈ℚ̄ は不変)/T3(Wall 一般不成立, 可積分効果は標本不足で未確定)。cycle6 step列起こし。 |

## cycle 4 step 列（3トラック継続。2026-06-25 起こし）

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T1 Reframe | reframe:R_Lambda_duality_proposition | done | 2026-06-26 | `outputs/reports/cycle4_T1_R_Lambda_mahler.md` + 研究ノート更新。ℝ/Λ 双対を **Mahler 測度**で命題化。スペクトル曲線 P(z,w)=det(wI−T(z))∈ℤ[z±,w]。ℝ側=自由エネルギー=log m(P)(アルキメデス Mahler, **既知・深い**: Ising で arXiv:2407.19531=楕円曲線/L 函数, LSW)。Λ側=有限 N の v_p 構造=同じ P の p 進 Mahler(**予想**, 命題 A は厳密)。確立/予想を明示分離。 |
| 2 | T2 Solve | chiral_potts_finite_N_to_limit | done | 2026-06-26 | `sagemath/check/cycle3_T2_chiral_potts/onsager_*`（実行済）。カイラル Potts スペクトルは**全2冪次数・全実・少数の√で生成(多重2次体)**=Onsager/自由フェルミ構造の有限 N 足跡。λ=1/2 で√中身{33/4,57/4}が N=2,3 安定→splitting 体 ℚ(√33,√57)。準位 E=A±Σ√α_k 型。極限フェルミオン準位への橋。N≥4 は QQbar 計算重(背景 exit144)→小 N で構造明瞭。 |
| 3 | T3 Pure | wall_equality_attempt | done | 2026-06-26 | `sagemath/check/cycle3_T3_period/wall_search*`。反例探索: 一般 companion で Wall 破れ18件(大半は退化=1の冪根/unipotent, ただし x²−2x−1 Pell p=13 は非退化候補), 六頂点で0件。**結論修正: Wall 等式は一般には不成立**(rigorous 上界 π(p,k)|p^{k-1}π(p,1) は不変)。「可積分性が保証」は退化交絡で未確定→非退化限定の系統比較が要(cycle5)。候補ドキュメント更新。 |
| 4 | — | rank:cycle4 | done | 2026-06-26 | 下記「cycle 4 総括」。T1(Mahler 命題化)/T2(Onsager 構造)/T3(Wall は一般不成立, 上界は不変)。cycle 5 step 列起こし。 |

## cycle 3 step 列（3トラック再スコープ後。2026-06-24 起こし）

ユーザー再スコープ（`docs/themes.md`）を受け、2本立て(T1,T2)＋T3 で進める。各 step にトラックを明記。
別途、ℝ/Λ 双対はユーザー依頼で root `docs/research/R-Lambda-duality/` に切り出し（深掘り・別セッション質問用）。

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T1 Reframe | formalize:D-U2_rigorous | done | 2026-06-25 | `outputs/reports/cycle3_T1_D-U2_rigorous.md` + `sagemath/check/cycle3_T1_period_bound/`(全ケース True)。**命題 A(rigorous・決定可能)**: min(v_p(Z_N),k) は T^N mod p^k の最終周期 π(p,k) で最終周期(証明＋検証)。**命題 B**: 線形傾き μ_min=Newton 多角形(SML caveat)。形式検証: 命題 A は Z/p^k 有限計算⇒Lean decide 可・RCA₀・witness=(N_0,π,値表)。p|q は π 増大で説明。 |
| 2 | T2 Solve | sagemath:chiral_potts_tau2_spectrum_qqbar | done | 2026-06-25 | `sagemath/check/cycle3_T2_chiral_potts/`(実行済)。本命 ℤ_3 超可積分カイラル Potts 鎖(係数 ℚ(ω))で有限 N スペクトル∈ℚ̄・全実・次数2(witness 例 x²−6=±√6, Onsager 的構造と整合), N=3 で次数4も。「有限 N=可算決定可能/極限=未解決」が**本命模型で直接成立**(T2 足場)。一般カイラル Potts(高種数)は未。 |
| 3 | T3 Pure | padic_recurrence_period_bound | done | 2026-06-25 | `outputs/candidates/T3_wall_type_period_candidate.md` + `sagemath/check/cycle3_T3_period/`。**既知 rigorous 上界 π(p,k)|p^{k-1}π(p,1)**(Pisano 理論)で D-U2 命題 A の周期を押さえた。等号(Wall–Sun–Sun 型, 一般は未証明予想)は全テスト例で成立 → 候補命題「整数転送行列で Wall 等式が常に成立か」(証明 or 反例)。正直: 既知難問への構造付き接続。 |
| 4 | — | rank:cycle3 | done | 2026-06-25 | 下記「cycle 3 総括」。T1/T2/T3 各前進。**ユーザー判断点**: cycle 4 で(T2 一般カイラル Potts の極限/T1 Lean 実装/T3 Wall 証明)のどれを主にするか。 |

## cycle 2 step 列（D-U2 数論を主・Potts を従。2026-06-24 起こし）

cycle 1 総括の推奨どおり、ユーザー再発火（方向指定なし）を「推奨方向で進めよ」と解釈して起こした。
方向: Massieu Φ_N の数論的構造 $v_p(Z_{N,L})$ の N 依存則を定理候補化（新規性のある唯一の「数学」方向）。

| # | step | status | done日 | 観察メモ |
|---|------|--------|--------|----------|
| 1 | sagemath:D-U2_padic_valuation_law | done | 2026-06-24 | `sagemath/check/D-U2_padic_law/`（実行済）。六頂点 v_p(Z_N) は三型: 恒0/末尾線形/周期。例 v_2(Z_N)=N+2,N+3。**固有値の p 進 Newton 多角形で説明**（Z_N=Σλ_i^N, 例 (1,1,2)L2 固有値 6,−2,2,2）。双対性発見: ℝ側自由エネルギー=log λ_max(絶対値最大), Λ側 Φ 数論構造=最小 p 進付値固有値。 |
| 2 | analyze:eigenvalue_padic_link | done | 2026-06-24 | `sagemath/check/D-U2_padic_law/eigenvalue_link.*`。予想 v_p(Z_N)=μ_min(p)·N + r_p(N)(r_p 最終周期)を検証。大半成立(例 v_2=N+2)。**1例((1,1,1)L2,p=7)で周期検出失敗＝SML(Skolem-Mahler-Lech)スパイク**。正直な位置づけ: 既知の p 進線形漸化理論の可積分 Φ への適用。新規性は (a)適用 (b)ℝ側 log λ_max / Λ側 最小付値固有値の双対。厳密定理化には SML 例外の caveat 要。 |
| 3 | sagemath:potts_phi_structure（従） | done | 2026-06-24 | `sagemath/check/potts_phi/`（実行済）。3-状態 Potts 転送行列でも Z_N∈ℤ, Φ_N∈Λ, v_p 則(μ_min·N+最終周期)成立。**普遍性確認(六頂点固有でない)**。正直な caveat: 早期 SML スパイク＋特殊素数 p|q(状態数)で周期増大(検出器が過小報告、手検証で最終周期確認)。カイラル Potts τ^(2) 直接は未(3-Potts で族横断性は実証)。 |
| 4 | theorem_candidate:vp_law | done | 2026-06-24 | `outputs/candidates/D-U2_vp_law_theorem_candidate.md`。定理候補「v_p(Z_N)=μ_min(p)N+r_p(N)(最終周期, SML 例外), μ_min=charpoly の p 進 Newton 多角形最小傾き」。ℝ/Λ 双対(λ_max↔μ_min)明示。正直: 既知 p 進線形漸化理論の可積分 Φ への適用＝構造的/適用的, 新厳密解でない。paper_potential low-medium。 |
| 5 | rank:cycle2 | done | 2026-06-24 | 下記「cycle 2 総括」。**ユーザー判断点**: 基礎論/数論的構造の方向(low-medium)を続けるか、別路線か。 |

## cycle 1 総括（rank:cycle1, 2026-06-23）

- **検証で確立**: 「可積分だが極限未解決な模型で、有限 N 量(スペクトル・Φ・零点)は Λ/ℚ̄ で決定可能・witness 付き、ℝ脱出は N→∞ 一点」を SageMath で実証（XXZ, 六頂点 Φ の数論構造, スピン1 BT）。paper-plan 001 化。
- **survivor**: C-U3(実証), D(実証, D-U2 数論構造が非自明), F(決定手続き実証/Lean は環境ブロック・仕様確定)。A は薄い(数学内容既知)。B は A と同型。
- **正直な評価**: 成果は**基礎論・形式検証・構造的 calibration の寄与**で、「可積分模型の新しい厳密解」ではない。可解性(極限閉形式)は前進していない。
- **cycle 2 方向候補（ユーザー判断点）**:
  1. 基礎論寄与として磨く（分離定理の厳密命題化＋Lean 実装）→ foundations 論文。
  2. カイラル Potts τ^(2) 直撃（本命模型で有限 N∈ℚ̄ を直接、極限未解決との対比を鋭く）。
  3. D-U2 の数論的構造（v_p(Z_N) の N 依存則）を定理化（新規性がありそうな唯一の「数学」方向）。
  4. 撤退/別路線（Λ 収集が基礎論再框に寄りがちなら）。
- → **ここで停止しユーザー判断を仰ぐ**（基礎論寄与に価値を置くか等は研究方針＝ユーザー固有の価値判断。自律実行ルールの例外）。

## 逸脱ログ

点検で不合格→是正した内容を step 番号・日付付きで記録。

（なし）
