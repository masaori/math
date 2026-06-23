# 自動ループ 状態（Λ-statement 版）

daily cron が読み書きする状態ファイル。手順は `auto-loop-runbook.md`、収集定義は `inputs/seeds/lambda-statement-program.md`。

```yaml
program: lambda-statement   # 再定義: Λ/ℚ̄ 決定可能・ℝ脱出隔離・形式検証可能
current_cycle: 1            # cycle 0(A-F 広い探索)完了。cycle 1 = finite_N_decidable 束の深掘り。
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
| 3 | sagemath:D_phi_factorization（未解決模型で） | todo | | 未解決模型の小 N で Φ_N=log Z_N(q) の素因数構造(D-U2 数論的内容)を観察。 |
| 4 | apply:finite_N_qqbar_to_chiral_potts_or_higher_rank | todo | | カタログ本命（カイラル Potts / 高ランク）に C-U3 を当て、「有限 N スペクトル∈ℚ̄ だが極限未解決」を具体命題化。 |
| 5 | lean:F-U1_decide_minimal | todo | | 第〇法則 or Φ 恒等式の Lean decide/reflection 最小例。 |
| 6 | paper_plan:finite_N_decidable_unsolved | todo | | survivor を `outputs/paper-plans/` に。未解決模型での「有限 N 可算決定可能 vs 極限未解決」を軸に。 |
| 7 | rank:cycle1 | todo | | 深掘り結果で再ランク → cycle 2 方向。 |

## 逸脱ログ

点検で不合格→是正した内容を step 番号・日付付きで記録。

（なし）
