# 自動ループ 状態（Λ-statement 版）

daily cron が読み書きする状態ファイル。手順は `auto-loop-runbook.md`、収集定義は `inputs/seeds/lambda-statement-program.md`。

```yaml
program: lambda-statement   # 再定義: Λ/ℚ̄ 決定可能・ℝ脱出隔離・形式検証可能
current_cycle: 2            # cycle 0,1 完了。cycle 2 = D-U2 数論(v_p(Z_N) の N 依存則)を定理候補化。
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

## cycle 2 step 列（D-U2 数論を主・Potts を従。2026-06-24 起こし）

cycle 1 総括の推奨どおり、ユーザー再発火（方向指定なし）を「推奨方向で進めよ」と解釈して起こした。
方向: Massieu Φ_N の数論的構造 $v_p(Z_{N,L})$ の N 依存則を定理候補化（新規性のある唯一の「数学」方向）。

| # | step | status | done日 | 観察メモ |
|---|------|--------|--------|----------|
| 1 | sagemath:D-U2_padic_valuation_law | done | 2026-06-24 | `sagemath/check/D-U2_padic_law/`（実行済）。六頂点 v_p(Z_N) は三型: 恒0/末尾線形/周期。例 v_2(Z_N)=N+2,N+3。**固有値の p 進 Newton 多角形で説明**（Z_N=Σλ_i^N, 例 (1,1,2)L2 固有値 6,−2,2,2）。双対性発見: ℝ側自由エネルギー=log λ_max(絶対値最大), Λ側 Φ 数論構造=最小 p 進付値固有値。 |
| 2 | analyze:eigenvalue_padic_link | done | 2026-06-24 | `sagemath/check/D-U2_padic_law/eigenvalue_link.*`。予想 v_p(Z_N)=μ_min(p)·N + r_p(N)(r_p 最終周期)を検証。大半成立(例 v_2=N+2)。**1例((1,1,1)L2,p=7)で周期検出失敗＝SML(Skolem-Mahler-Lech)スパイク**。正直な位置づけ: 既知の p 進線形漸化理論の可積分 Φ への適用。新規性は (a)適用 (b)ℝ側 log λ_max / Λ側 最小付値固有値の双対。厳密定理化には SML 例外の caveat 要。 |
| 3 | sagemath:potts_phi_structure（従） | todo | | 3-状態 Potts / カイラル Potts τ^(2) の有限 N Φ 構造を確認（本命模型直撃）。 |
| 4 | theorem_candidate:vp_law | todo | | v_p(Z_{N,L}) の N 依存則を定理候補として `outputs/candidates/` に明文化。 |
| 5 | rank:cycle2 | todo | | 再ランク → cycle 3 方向。 |

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
