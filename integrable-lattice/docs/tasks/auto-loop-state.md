# 自動ループ 状態（Λ-statement 版）

daily cron が読み書きする状態ファイル。手順は `auto-loop-runbook.md`、収集定義は `inputs/seeds/lambda-statement-program.md`。

```yaml
program: lambda-statement   # 再定義: Λ/ℚ̄ 決定可能・ℝ脱出隔離・形式検証可能
current_cycle: 29           # cycle 0-28 完了。cycle 29 は 2026-08-04 に cycle 28 総括の「cycle 29 の焦点（案）」6 点から起こした。着手時に 6 点すべての前提を実測し、全点が一次情報と一致することを確認してから起こしている（前提の食い違い 0 件）。最優先はユーザー方針の全数 Lean 形式化で、本サイクルは「残り 19 件を実際に減らす」ことを主題に据えた。
                            # cycle 0-27 完了。cycle 28 は 2026-08-04 に cycle 27 総括の「cycle 28 の焦点（案）」7 点から起こし、同日 rank:cycle28 で総括した。着手時に 7 点すべての前提を実測し、全点が一次情報と一致することを確認してから起こしている（前提の食い違い 0 件）。最優先はユーザー方針の全数 Lean 形式化。
                            # cycle 0-26 完了。cycle 27 は 2026-08-03 に cycle 26 総括の「cycle 27 の焦点（案）」5 点から起こした。着手時に 5 点すべての前提を実測し、4 点は一致・1 点（日本語版 PDF のアスタリスク「410 箇所」）は数え方が行数だったことを確認してから起こしている。
                            # cycle 26 は 2026-08-02 に cycle 25 総括の「cycle 26 の焦点（案）」6 点から起こし、同日 rank:cycle26 で総括した。着手時に 6 点すべての前提を実測し、一次情報と一致することを確認してから起こしている。
                            # cycle 0-25 は次のとおり。cycle 25 は 2026-08-01 に cycle 24 総括の「cycle 25 の焦点（案）」4 点から起こし、同日 rank:cycle25 で総括した。
                            # cycle 24 は 2026-08-01 に cycle 23 総括の「cycle 24 の焦点（案）」4 点から起こした。
                            # cycle 23 は 2026-08-01 に cycle 22 総括の「cycle 23 の焦点（案）」4 点から起こした。
                            # 2026-06-24 ユーザーが3トラック(docs/themes.md)へ再スコープ。cycle 3 以降はトラック明記。
                            # cycle 16 は 002 の昇格承認後の「論文 001 の残務を閉じる」サイクル。
                            # cycle 17 は cycle 16 総括が挙げた4点（照合の穴・退化トーラス・Lean・既出性）を潰すサイクル。
                            # cycle 18 は cycle 17 総括が挙げた4点（一般の退化塔／π_tr(p,k) 上界／命題 N・T・W の Lean 化／Monsky 1989 入手）を潰すサイクル。
# 3トラック: 1 Reframe(本流) / 2 Solve(未解決模型の実厳密解) / 3 Pure(基礎論・数論)。2本立て(1,2)主軸 + 3 随時。
last_run: 2026-08-04
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

## cycle 8 総括（rank:cycle8, 2026-06-30）

- **T1 Reframe**: 最小双対モデル $z-c$ の**完結した命題**（命題 R: $f=\log c=m(z-c)$; 命題 Λ: $v_p(c^L-1)=$ LTE 完全形 p 奇・p=2、決定可能・Lean decide 可・Mathlib 補題あり）。`outputs/reports/cycle8_T1_lte_proposition.md`。
- **T2 Solve**: N=3 でも Onsager 分散 confirmed、deg-2 運動量 $\cos\theta=\pm1/3$（ℤ_3 由来）、deg-4 に追加運動量。cubic は N≥4。
- **T3 Pure**: **π(p,1) の精密公式 $=\mathrm{lcm}\{\mathrm{ord}(\lambda): p\nmid m_\lambda\}$（rigorous, 全31例）**＋等号条件確定＋strict 構成例実演。D-U2 の Λ 側周期が固有値 order と mod-p 重複度で完全決定可能に。
- 全体: 訂正なしの堅実サイクル。T1/T3 が rigorous な命題として固まり、T2 が分散抽出を N=3 へ拡張。「既知物理・数論を可算・決定可能・形式検証可能に書き換える」本流が積み上がっている。

## cycle 9 総括（rank:cycle9, 2026-07-01）

- **T1 Reframe**: 2変数スペクトル曲線を実模型（離散ラプラシアン=全域木/ダイマー/GFF）へ。**ℝ側 (1/L²)logτ(L)→4G/π（既知 Catalan 全域木エントロピー）と一致=枠組み裏付け**、Λ側=τ(L) 素因数分解。cycle5 toy を実模型へ拡張。
- **T2 Solve**: N=4 で cubic 因子（判別式621=S₃）=cubic 運動量の存在 confirmed。厳密 cosθ 同定は超可積分スペクトル理論照合が要（cycle10+, 正直な限界明記）。
- **T3 Pure**: D-U2 の Λ 側を**統合命題**に確定（`outputs/candidates/D-U2_consolidated_proposition.md`: 周期性+π(p,1)精密+上界+Newton+Wall 否定, 決定可能, Lean 仕様, 双対 cross-ref）。
- 全体: T1 が「既知物理定数(4G/π)の可算側からの再現」で本流を強化。T3 が確定命題として結実。T2 は誠実に限界明記。

## cycle 10 総括（rank:cycle10, 2026-07-03）

- **T1 Reframe**: 全域木数 τ(L) の Λ 側 clean 法則 **奇 L で v_2(τ(L))=2(L−1)**（L=3..11 全一致, 2変数 LTE 的）。一般 v_p・対角 v_p(τ(p)) は円分的で複雑（p=5 が 2p 破れ）。
- **T2 Solve**: AMP 1989 文献照合 — 超可積分スペクトルは Ising 的自由フェルミ √(1+λ²−2λcosθ)（私の数値と整合, 準粒子外励起もあり）。cosθ=±1/3 の AMP 運動量同定は論文本体照合が要（未確定, 正直）。
- **T3 Pure**: 自由エネルギー=Mahler 測度=エントロピー → Lehmer 問題（最小正エントロピー）への接続を地図化。**スケール違いの偶然（4G/π vs Lehmer 数）に注意**を明記。Mahler/エントロピーは ℝ 側で決定可能成果とは別。
- 全体: T1 で clean な Λ 側法則, T2/T3 は既知理論への正確な接続と限界の明示。誇張なし。

## cycle 11 総括（rank:cycle11, 2026-07-04）

- **T1 Reframe**: $v_2(\tau(L))=2(L-1)$（奇 L）を L=3..19 で検証強化。**全域木数の ℓ 進付値＝グラフの岩澤理論**（abelian ℓ-towers, 類数の岩澤不変量と平行）に接地。cycle6 の p 進エントロピー＝岩澤 μ と同構造。
- **T2 Solve（正直な現状整理）**: XXZ 2マグノン∈ℚ̄（cubic 因子=Bethe 根）。**cycle1-11 の T2 は「既知可積分構造を可算で確認・再導出」で新厳密解を産出しておらず、実質 T1 と重複**。真の solve は専門機構（BBP/TQ/量子群/楕円）が要り現行道具で困難。
- **T3 Pure**: **Lehmer 問題は双対の ℝ 側固有**。Λ 側（岩澤 μ_p∈ℤ, Ferrero–Washington で generic 0）は離散・決定可能で Lehmer 型問題なし。**双対の決定可能性非対称の集約**（研究ノート §3.1 と一致）。
- 全体像の収束: Mahler 測度(ℝ)/岩澤理論(Λ)/決定可能性非対称/Lehmer が一貫した双対像に。**T2 の扱いが方針判断点**（下記, rank で提起）。

### 方針判断点（ユーザー価値判断）: T2 トラックの扱い
T2（未解決模型の実厳密解）は 11 cycle を通して新厳密解を産まず、可算 Reframe（T1）に収束。選択肢:
1. **T2 を T1 に統合**し「既知可積分結果の可算・厳密・形式検証可能な書き換え」に一本化（現実的・堅実）。
2. 特定の小さく未解決な量（例: 特定境界の有限サイズ補正の可算表示）に**深く張る**（専門文献精読, 重い, 新解の可能性）。
3. 現状維持（T2 で既知構造の可算確認を続ける）。
→ 指定なければ cycle12 は **1（T1 統合寄り）+ 蓄積成果の paper-plan 化**で進める。

## cycle 12 総括（rank:cycle12, 2026-07-26）

- **T1 Reframe**: 11 cycle の蓄積を `outputs/paper-plans/002_R_Lambda_duality.md` に統合。既知（LSW / Besser–Deninger / Deninger / Ferrero–Washington / グラフ岩澤 / Lehmer / LTE・Pisano・SML）と本プロジェクトの寄与（再框4点）を表で分離し、確定した部分命題 A/B/C/N/L と未証明の観察 T を分節した。**据え置き**（G1 未達＝双対命題 D の一般性が未確定）。
- **T2→T1 統合（方針判断1の実行）**: `sagemath/check/cycle12_T2_onsager_qqbar/`。2D Ising Onsager 解の有限 L 構造を、$\mathbb{Z}[x]$・$\mathbb{Q}(\zeta_{2L})(x)$・`QQbar`/`AA` 上の**記号的等号**として厳密検証。分散関係・$\pm\gamma$ ペアリング・臨界条件 $(x^2+2x-1)^2$・KW 双対不変性はすべて多項式/有理関数の恒等式。**ℝ 脱出は 2 点（モード和の $\log\rho$、連続極限）に隔離**され、$\log\rho\notin\Lambda_\mathbb{Q}$ は共役 $1/\rho$ を使う論証で決着。**新厳密解は無い（既知の書き換え）と明記済み**。
- **T3 Pure（今 cycle の白眉）**: `sagemath/check/cycle12_T3_nonzero_mu_p/`。cycle 6/11 の「$\mu_p$ は generic に 0」の**外側**を明示構成。$\mu_\ell=v_\ell(\mathrm{content}_z\det L(z))$ という**決定可能な判定式**を得て、$\mu_2=2,\mu_3=1$（同一塔）、$\mu_2=4$、$\mu_{23}=1$、$\mu_3=2$（$\lambda=3$）、$\mu_5=1$ の例を matrix-tree の直接計算で独立検証。**bouquet では $\mu>0$ が自明例に限り、2頂点以上で行列式の content に $\ell$ が入る非自明な相殺が源**という構造的理由も特定。新規性は文献本文を機械可読に取得できず**未確認**（主張しない）。
- **運用面の成果**: `outputs/paper-plans/README.md` に昇格ゲート G1–G6 ＋ユーザー承認の最終ゲートを新設（判定語彙・G1 前提ルール・状態語彙・崩れた場合の扱いを含む）。選別基準 (iv) に**メタ軸**（可算化・決定可能性・形式検証可能性）を明文化し、T1 Reframe の成果が (iv) を満たせるようにした。検証3ディレクトリの `README.md` 欠落を補完。
- **全体像**: T2 の T1 統合が実際に機能した（Onsager が可算側で完全に書ける）。T3 で Λ 側の「内容の薄さ」（全例 $\mu_p=0$）が解消され、双対の Λ 側に非自明な算術が入った。**決定可能性は保たれたまま**（$\mu_\ell$ は content の付値で計算できる）。
- **cycle 13 の焦点**: 002 の G1（双対命題 D の一般性確定）と観察 T の決着。T3 の判定式 $(☆)$ の証明。

### 方針判断点は無し（cycle 12）
cycle 11 で提起した T2 の扱いは既定方針 1（T1 統合）で実行し、機能することを確認した。新たなユーザー判断点は生じていない。

## cycle 13 総括（rank:cycle13, 2026-07-26）

- **T1 step 1（誤りの検出）**: `outputs/reports/cycle13_T1_padic_entropy_generality.md`。
  ($\infty$) 側の一般性を**文献本文で確定**（LSW Invent. math. 101 Thm 3.1 / Thm 7.1、LSV arXiv:1108.4989 Thm 1.2・1.3 の 3 段）。
  一方 ($p$) 側は、002 が既知として並置していた「$p$ 進エントロピー ＝ $p$ 進 Mahler 測度 ＝ 岩澤 $\mu_p$」が**誤り**と判明。
  $\hbar_p, m_p$ は岩澤対数 $\log_p$（$\log_p p=0$）で定義され付値部分を捨てるので $v_p$ の増大を測らず、
  定義域もほぼ排他的（定義できる条件下では $v_p(a_L)=L^d v_p(c)$ と自明化）。002 を訂正した。
  **正しい量は Ueki の $\mathrm M_p$ だが、2 変数・$\mathbb{Z}_p^2$ 塔での増大則は文献に特定できず、G1 は未達のまま。**
- **T3 step 2（証明）**: `outputs/reports/cycle13_T3_mu_content_criterion_proof.md`。
  cycle 12 で数値照合のみだった $(★)$ と $(☆)$ を**証明**。さらに cycle 12 が既知理論に依拠していた
  岩澤型漸近 $\mathrm{ord}_\ell(\kappa_n)=\mu\ell^n+\lambda n+\nu$ **そのものを証明**し、$\lambda=\lambda_{\mathrm W}-1\ge1$ も決定。
  $(★)$ は連結性の仮定なしで成立する形へ強化。**新規性は主張しない**（McGown–Vallières III Thm 6.1 の言い換え）。
  **射程の限界も特定**: $\ell\nmid N$ の段では content が支配しない（反例 6 件）、$d\ge2$ の塔は対象外
  ＝本プロジェクトの $L\times L$ トーラスにはそのまま適用できない。
- **T1 step 3（証明）**: `outputs/reports/cycle13_T1_observation_T_settlement.md`。
  観察 T（奇 $L$ で $v_2(\tau(L))=2(L-1)$）を**証明**し、002 の「検証済みだが未証明の観察」から
  確定部分命題「命題 T」へ移した。骨子は $\tau(L)=\prod_j(r_j^L-1)^2/r_j^L$ への分解＋2 の不分岐性＋
  Newton 多角形（$v(m_j)=1$）＋LTE 段。敵対的レビューで反証されず、独立経路（終結式）で
  合成奇数 $9,15,21,25,27,33,35$ と $L=19$ まで確認。**新規性は主張しない**（本文未確認）。
- **全体**: cycle 13 は「証明のサイクル」になった。cycle 12 で数値・観察だった 3 件のうち 2 件
  （判定式、観察 T）に証明が付き、1 件（双対命題 D）は**既知だと思っていた同一視が誤りだった**ことが判明した。
  誤りの検出は前進であり、002 の G1 は依然未達だが理由が正確になった。
- **cycle 14 の焦点**: 002 の G1 の残る唯一のボトルネック＝2 変数・$\mathbb{Z}_p^2$ 塔での $v_p$ 増大則。
  cycle 13 step 2 の証明機構（$(★)$＋Weierstrass）を $d=2$ へ拡張できるかが自然な筋
  （DuBose–Vallières Thm A の $P(\ell^n,n)$ 型を目標形とする）。

### 方針判断点は無し（cycle 13）
新たなユーザー判断点は生じていない。

## cycle 14 総括（rank:cycle14, 2026-07-26）

目標は 002 の G1 の残るボトルネック（2 変数・$\mathbb{Z}_p^2$ 塔での $v_p$ 増大則）の解消。**完全解消には至らなかったが、
未達の理由を 2 点まで絞り込み、その過程で 4 つの命題を証明した。**

- **T1 step 2（呼び出し元が担当）: 命題 V**。`outputs/reports/cycle14_T1_vp_growth_two_variable.md`。
  $a_{p^n}\equiv P(1,\dots,1)^{p^{dn}}\pmod p$（$\bmod p$ で $z^{p^n}-1=(z-1)^{p^n}$ となり終結式が潰れる）から
  **$v_p(a_{p^n})>0\iff p\mid P(1,\dots,1)$** を初等的に証明（$\mathbb{Q}_p$ も代数的整数論も不使用）。
  併せて **cycle 13 の content 判定式が $d=2$ で崩れる反例**（content$=1$ でも増大、8 件）と、
  **レジームの三分法**（$p\nmid P(1,1)$ 自明／$p\mid P(1,1)\ne0$ 非自明／$P(1,1)=0$ トーラス零点）を確定。
  敵対的レビューで**誤り 3 件を検出・訂正**（Deninger との包含関係の誤り、4 段フィットの数値的誤り、$X^2$ 係数の未証明断定）。
- **T3 step 1: $(★_2)$ と非退化塔の閉形式**。起動事故で**2 経路が独立に走り**、
  `cycle14_T3_two_variable_criterion.md`（第 1 経路）と `cycle14_T3_Zl2_tower_criterion.md`（第 2 経路）が
  **同じ境界に到達**した: $(★_2)$・連結性判定・下界 $a\ge v_\ell(\mathrm{content})$ は自前で証明でき、
  **上界 $a\le v_\ell(\mathrm{content})$ は自前では証明できない**。第 1 経路はさらに非退化条件
  （$H$ が $\mathbb{P}^1(\mathbb{F}_\ell)$ 上に零点なし）の下で**完全な閉形式**
  $\mathrm{ord}_\ell(\kappa_n)=\mu\ell^{2n}+\frac{k(\ell+1)}{\ell-1}\ell^n-2n+\nu$ を証明（命題 W）。
  $L\times L$ トーラスの $\ell=3$ 塔で $\mathrm{ord}_3(\tau(3^n))=4\cdot3^n-2n-4$ を独立に検算（$n=0,1,2$ で $0,6,28$）。
  $\ell=2$ は退化ケースで射程外。**文献 Kataoka arXiv:2606.03579 を発見**（$\mathbb{Z}_p^d$ グラフ被覆の主要係数の明示公式。abstract 確認）。
- **T1 step 3: 命題 T の一般化**。`outputs/reports/cycle14_T1_proposition_T_generalization.md`。
  定理 A（判定条件）・B（次元の漸化式）・C（$L$ 奇なら任意の $d$ で $4\mid v_p$）・D（命題 T の 10 行証明）・
  E（部分トーラス下界 $v_p(\tau_d(L))\ge L^{\lfloor d/p\rfloor}-1$）・F（$p=2,d=2$ が特別な理由＝
  $\bmod 2$ で零点集合が 2 つの部分トーラスの合併）を証明。
  **負の結果も確定**: 奇素数に clean な法則は無い（$L=13,p=5$ 等の反例）、$d\ge3$ で等号は成らない、
  $c(L^{d-1}-1)$ 型は誤りで正しい指数は $L^{\lfloor d/p\rfloor}$。
- **新規性はいずれも主張しない**（命題 V は初等的で folklore の可能性、命題 W は Kataoka が同種の公式を与えている、
  定理 A–F は本文未確認）。
- **002 の G1 は依然未達**。ただし残るのは **(a) 一般の $P$（グラフのラプラシアンでないもの）で $p\mid P(1,1)$ のときの
  増大の完全な形、(b) $\ell^{2n}$ 係数の上界方向（Cuoco–Monsky / Kataoka に依拠、本文未取得）** の 2 点。
- **cycle 15 の焦点**: (b) は Kataoka arXiv:2606.03579 の本文取得で決着する可能性が高い（文献参照で済むなら
  自前証明は不要）。(a) は一般の $P$ を扱う必要があり、命題 W の機構が $\det L$ 以外へ広がるかが鍵。

### 方針判断点は無し（cycle 14）
新たなユーザー判断点は生じていない。

### 逸脱（記録）
cycle 14 step 1 の起動でシェル展開の事故があり、同じ課題が 2 回走った。成果は破棄せず、
**独立な 2 経路**として両方を残し、相互に参照ヘッダを付けた（両者が同じ境界に到達したことは境界の信頼性を高める）。

## cycle 15 総括（rank:cycle15, 2026-07-26）

**目標を達成した。002 は G1–G6 すべて `達成` となり、状態が `据え置き` から `昇格提案済` へ移った。**
残る条件は「ユーザーが論文として書くと承認すること」の 1 点のみである。

- **step 1+2（呼び出し元が担当。一本の発見で両方が閉じた）**:
  `outputs/reports/cycle15_T1_kataoka_and_general_P.md`。
  Kataoka arXiv:2606.03579 の**本文を取得**（PDF をページ単位で pp.1–8 直読。HTML 版は 404）。
  **(b)**: $\mu=m_0(f)$ は Definition 2.2（＝Cuoco–Monsky Def 1.1/1.2）で「$f$ を割り切る $p$ の最大冪」と
  **定義**されており、Theorem 2.3（＝Cuoco–Monsky Thm 1.7）が等号 $\mu=m_0(f)$ を与える。
  cycle 14 で自前証明できなかった上界方向は外部定理を引けば済むと確定。
  **(a)**: Theorem 2.1（＝**Monsky Thm 5.6**）は**グラフに限定されていない**。任意の $f\in\mathbb{Z}_p[[\Gamma]]$ と
  半代数的 $S$ についての定理で、$a^{\mathrm{red}}_{p^n}=\prod_{\chi(f)\neq0}\chi(f)$ がちょうどその左辺なので
  **一般の $P$ にそのまま適用できる**。cycle 13 step 1 の「文献に特定できなかった」は
  探索範囲がグラフの文献に偏っていた誤りであった。
  敵対的レビューで**誤り 2 件を検出・訂正**（$l_0=0$ と非退化条件の同値は偽で一方向のみ／
  簡約積と $\kappa$ は $-dn$ ずれる）。$\lambda=l_0$ の**計算可能性は未確立**と正直に記録した。
- **step 3**: `outputs/reports/cycle15_T3_tau_d3_structure.md`。$d=3$, $p=2$ の追加解を
  **型 I（部分トーラス）/ 型 II（$\{u,\omega u,\omega^2u\}$）/ 型 III（$15\mid L$ の 48 個）**に分類し、
  分解公式 $v_2(\tau_3(L))=6(L-1)+8(L-3)[3\mid L]+144[15\mid L]+(\text{散発})$ を証明。
  cycle 14 が「散発的」としていた $L=9,15,21,27$ が**説明され**、真に散発なのは $L=17$ のみに絞られた。
  独立検算で $L=3..15$ の全例一致（散発分 0）を確認。
- **002 の判定**: G1 達成（命題 D を仮定・結論・一般性の範囲まで書き下した）／G2 達成（台帳に $\mu,\lambda,\lambda_i,\mu_i,\nu,a^{\mathrm{red}}$ を追加）／
  G3 達成／G4 達成（寄与 (b) の既知性調査も実施。Ax–Kochen/Ershov を隣接既知結果として記録）／
  G5 達成／G6 達成／最終ゲート未取得。
- **新規性はいずれも主張しない。** 閉じ方は「正しい既知定理を特定し本文で仮定と命題番号を確認した」であって自前証明ではない。

### ユーザー判断点（cycle 15 で発生）
**002 を `outputs/papers/` へ昇格させるか。** G1–G6 はすべて満たした。承認前の判断材料は 002 の
「昇格判断」節に 4 点（新規性が無いこと／残る未解決点 3 つ／Lean 非対象／投稿前の専門家確認事項）明示してある。
**cycle 16 の内容はこの判断に依存するため、step 列は承認後に起こす。**

## cycle 19 step 列（2026-08-01 起こし。cycle 18 総括の「cycle 19 の焦点（案）」から起こした）

**前提**: cycle 18 で 4 点はすべて潰れたが、退化塔の閉形式は $\theta(P)\le\ell$ の下でしか出ておらず、
(a) $\theta\ge\ell+1$（第 2 $\ell$ 進桁が入る領域）、(b) $\theta=\infty$（方向上で $\bar E$ が恒等的に消える）
の 2 つが未解決として残った（`cycle18_T3_general_degenerate_tower.md` §6.1・§6.2）。
また (c) $\pi_{\mathrm{tr}}(p,k)$ の閉じた公式（指数列 $(e_k)$ を固有値データから決める式）と
$w^*$ の代数的記述、および命題 C′ の Lean 化が未着手である（`cycle18_T3_trace_period_bound.md` §7.2）。
cycle 19 はこの 3 点を step にする。

**焦点 4 番目「論文 001 の投稿判断」は step にしない。** 投稿するか・どこへ出すか・さらに強化してから
出すかは研究方針＝ユーザー固有の価値判断であり、自動ループでは決めない（下記「方針判断点」）。

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T3 Pure | degenerate_tower_theta_ge_ell_plus_1 | done | 2026-08-01 | `outputs/reports/cycle19_T3_theta_ge_ell_plus_1.md` / `sagemath/check/cycle19_T3_theta_ge_ell/`（FAIL 0、打ち切り 1 件＝下記）。**cycle 18 §6.1 が「予想ではなく次に試すべき具体的な手順」として残した計算をやり切った。** (1) **桁定理（定理 J2）**: $0\le m\le\ell^L$ なら $\bar A_m$ は $(a,b)\bmod\ell^L$ だけの関数。cycle 18 補題 A3（Lucas）は $L=1$ の場合で、**これが「第 2・第 3 桁への延長」の答え**。閾値の鋭さも**必要十分**にした（命題 J2′。$\ell$ 奇なら破れる $\iff k=2$、$\ell=2$ なら $\iff\bar A_2$ が平方でない）。cycle 18 命題 G は「起きうる」としか言えていなかった。(2) **$\theta$ の $M$ 依存の正体を特定**: $\theta$ を $\mathbb{P}^1(\mathbb{F}_\ell)$ の関数と見るのをやめ **$\mathbb{P}^1(\mathbb{Z}_\ell)$ 上の関数**へ延ばすと、$M$ 依存は $\mathbb{G}_m$ の $\ell$ 冪 Frobenius に関する**ファイバー Newton 多角形**として書ける（定理 J4）。(3) **定理 K**: $\mathrm{ord}_\ell(\kappa_n)$ が $D$ の係数だけからの有限計算で決まる（塔の値も円分体も使わない）。(4) **閉形式**: $\theta$ が至る所有限なら型 II（定理 J6。cycle 18 定理 C は $L=1$ の場合）、$\theta=\infty$ の点があれば型 III で **$n\ell^n$ の係数は $b=\sum_{P\in S_\infty}j^*(P)$**（定理 J7）。$S_\infty$ は**有限かつすべて有理点**で候補が有限計算で尽きる（系 J10）ので、当初の仮定 (F) は不要になった。(5) **cycle 18 §4.4 の「数値支持どまり」の観察を証明へ格上げ**（$\ell=3$ の $(1,0),(0,1),(1,1)$ の一定性と閉形式 $5(3^n-1)-2n$）。**step 2 との突き合わせ済み**: 定理 J8 は step 2 定理 X′ の $(p,q)=(\ell-1,1)$ の場合で**族としての正本は step 2 側**、$S_\infty$ の有限性は step 2（$\mathbb{Z}^2$ の直線）と本 step（$\mathbb{P}^1(\mathbb{Z}_\ell)$ の点）を**合わせて完全**になる、$n\ell^n$ の出所も両者一致（機械照合済み）。**自分の誤りを 2 件明記**（最大のものは $S_\infty$ を $\mathbb{P}^1(\mathbb{F}_\ell)$ の方向の集合と思い込んだこと。$\ell=2$ トーラスを「定理 J7 の反例」と誤結論し命題まで書いたが撤回。**気づいたきっかけは、うまくいった例ではなく検証が吐いた見慣れない出力**）。**数値支持どまりは 2 件**（最小点の一意性の広さ／基点の取り直し）で検出力を明記。**打ち切りを隠していない**: $\ell=5$ は壁時計 900 秒上限で母集団 430 個中 254 個までしか処理しておらず、未処理 176 個はすべて 2 頂点 3 重辺の族。射程が狭まる主張も特定して書いてある。**呼び出し元の検証**: sage を再実行して **FAIL 0** と、ℓ=5 の打ち切り位置以外の全出力一致を確認（**打ち切り位置は壁時計依存で揺れる**: 再実行では 193 個スキップ・照合 588 段。この 1 行だけは実行ごとに変わる）。さらに**定理 J2・命題 J2′ を独立に検算**（実際の $A_m$ で、奇素数では破れが厳密に $m=\ell^L+1$、$\ell=2$ トーラスでは破れないことを確認）し、**定理 J8 の閉形式も独立計算**（ラプラシアン余因子）で $\ell=3,5$ の 4 例一致。`npm run check`・`validate-content.ts`・`verify-check-linkage.ts` も再実行。規約どおり作業ブランチのみ push。 （当初の指示: cycle 18 step 1 §6.1 が「予想ではなく次に試すべき具体的な手順」として置いた計算をやる。$\theta_M(a,b)$ を $a,b$ の $\ell$ 進展開の**桁ごと**に記述する式（Lucas を第 2 桁・第 3 桁へ延長）を作り、$\theta$ が $\ell^2$ に届かない範囲で閉じるかを確かめる。閉形式が出ないなら**何が妨げているかを反例つきで確定**させる。§4.4 の「$\theta\ge\ell+1$ は $M$ 依存の必要条件だが十分条件でない」を証明された判定条件へ格上げできるかも見る。数値だけで支持を積んで「示した」と書かない。） |
| 2 | T3 Pure | degenerate_tower_theta_infinity | done | 2026-08-01 | `outputs/reports/cycle19_T3_theta_infinity.md` / `sagemath/check/cycle19_T3_theta_infinity/`（PASS 44950・FAIL 0・打ち切り 0 件）。**§6.2 が「考えられる」とだけ書いた段階的処理は機能し、しかも反復不要で 1 段で閉じる**（定理 S。割るのは $E$ ではなく 1 径数部分群へ制限した 1 変数多項式の内容）。**$\theta=\infty$ の軌跡の正体を確定**: $\theta(u)=\infty\iff(\chi^{u^\perp}-1)\mid\bar{\tilde E}$（命題 2）で、Newton 多面体の Minkowski 分解（Ostrowski）から**原点を通る有限本の直線**に限り、$D$ の係数からの有限計算で完全に決まる（命題 3）。cycle 18 が「$M$ 依存の具体的な姿」と呼んだ同居は「方向（mod $\ell$）と整数ベクトルの直線（$\mathbb{Z}$）のずれ」で、レベル $M$ の例外点の割合はちょうど $\ell^{1-M}$（系 5）。**主結果（定理 X′）**: 1 頂点 bouquet $p(1,0)+q(0,1)$ について $\ell$ 奇なら全レベル・全点の付値が閉形式で決まり $\mathrm{ord}_\ell(\kappa_n)=\mu(\ell^{2n}-1)+2n\ell^n+\Lambda(\ell^n-1)$。**これは任意の奇素数で型 III の実例を与える**（系 X″）。cycle 18 §5.1 の「型 III は小さい $\ell$ の現象」という読みは**母集団の人工物**（辺数 5 以下では $\ell\ge7$ で例外直線が作れない）であり、**肯定側の観察（全件型 II）にも 0 件の罠が働く**ことを示した。$n\ell^n$ 項は $\theta=\infty$ の点**からは出ず**、その $\ell$ 進近傍で $\theta$ が $1+\ell^r$ と深くなる点の集積から出ることも証明。自分の誤り 1 件（命題 8 を「$\theta=\infty\iff\ell\mid p+q$」と狭く立てた。Newton 多角形の候補を $\mathbb{F}_\ell$ でなく $\mathbb{Z}$ 上で取ったのが原因。436 件の FAIL で検出）を報告に明記。**数値支持どまりの主張は 0 件**（分類件数は宣言した母集団の全走査）。延長の失敗も反例で確定（§9.1、$\ell=3$ の $(1,0),(1,-1),(1,2)$ で実測 $0,10,50$ に対し延長式 $0,8,44$）。**呼び出し元の検証**: sage を再実行し時間表示を除いて出力が完全一致（PASS 44950 / FAIL 0）、さらに**主結果 (5.1) を完全に独立な経路**（$(\mathbb{Z}/\ell^n)^2$ Cayley グラフのラプラシアン余因子から全域木数を厳密計算）で $\ell=3,5,7,11$ の 12 例照合して全一致、`npm run check`・`validate-content.ts`・`verify-check-linkage.ts` も再実行。規約どおり作業ブランチのみ push。 （当初の指示: cycle 18 step 1 §4.5・§6.2 の第 3 の破れ方。方向上で $\bar E$ が恒等的に消える（$\theta=\infty$）場合に、$E$ を $\ell$ で割って取り直す段階的処理が機能するかを一次情報で確かめる。$\ell=5$、$4(1,0)+(0,1)$ の方向 $(1{:}1)$ が具体例。$\theta=\infty$ の点と有限の点が同じ方向に同居する構造を、付値の言葉で記述できるかを詰める。） |
| 3 | T3 Pure | trace_period_closed_form_and_lean_prop_C | done | 2026-08-01 | `outputs/reports/cycle19_T3_trace_period_closed_form_and_lean.md` / `sagemath/check/cycle19_T3_trace_period/`（FAIL 0・未決定 0）/ `lean/IntegrableLattice/PropCTracePeriod.lean`。**4 点すべて決着。** (iii) **予想 A を証明した**（定理 A′）。cycle 18 が $k\ge2w^*+1$ でしか出せなかったのは評価が粗かっただけで、$B^i$ の $i$ 個の因子のうち**1 個をトレース直交性のために残す**と要求が $(i-1)(k-w^*)\ge1$ に落ち、しきい値が $w^*+1$ になる。**副産物として主定理が強化された**: $\pi_{\mathrm{tr}}(p,k)\mid p^{\max(k-w^*-1,0)}\pi_{\mathrm{tr}}(p,w^*+1)$（cycle 18 は $p^{k-1}$）。指数はこれ以上下がらない（5544 件中 3111 件で 1 段下げ版が破れる）。(i) **閉形式は存在しないことを反例つきで確定**。$e_k=\min\{m:g_m\ge k\}$ という完全な構造式は得たが、入力 $g_0$ が Wieferich 型の量で固有値データから決まらず（$c=2,p=1093$）、増分も 1 とは限らない（最小反例 $T=(3)$, $p=2$。$w^*=0$ なのに $t_k=1,2,2,4,8,16$ で $t_2=t_3$）。**「閉形式が無い」は「決定できない」ではない**ことも明記。(ii) **$w^*$ の代数的閉形式を得た**（定理 W）。Euler の双対基底公式から $\mathrm{coker}(G)\cong A/\eta A$、$\eta=(\chi'/(\chi/\rho))(\theta)$、$w^*=\min\{j:p^j\eta^{-1}\in A_{(p)}\}$、$\det G=\pm N(\eta)$。$p$ 極大なら差積・分岐指数で $w^*=\max_{\mathfrak p\mid p}\lceil v_\mathfrak p(\eta)/e_\mathfrak p\rceil$ と書け、「不分岐かつ $p\nmid$ 重複度 ⟺ $w^*=0$」「従順分岐は $w^*$ を 1 しか上げない」が読める。**Smith 標準形を計算せずに $w^*$ が決まる**。(iv) **Lean 化で本文の誤りは見つからなかった**（cycle 18 の命題 T と同じ「食い違いなし」型）が、**過剰仮定を 2 件検出**: 定理 A′ に $p$ の素数性は不要、「周期」の最小性も使っていない（最小性を仮定すると結論が述べられない）。mathlib に `traceDual`・`differentIdeal`・`aeval_derivative_mem_differentIdeal` が**実在する**ことを 3 段 grep で確認してから「無いのは配線と整数行列の単因子」と書いた。**数値支持どまりは 1 件のみ**（奇素数での Wall 型等式。3600 件で反例 0 だが検出力は破れ率 $\ge0.083\%$ まで、と明記）。**呼び出し元の検証**: sage を再実行して出力が完全一致（FAIL 0）、`lake build` を再実行して **8668 jobs 成功**、`check-no-sorry.sh` も再実行して通過、**中心的な反例 3 件を素の Python で独立計算**（$T=(3)$, $p=2$ の $t_k=1,2,2,4,8,16$／$p=1093$ が Wieferich で $\mathrm{ord}_2$ が mod $p$ と mod $p^2$ で一致／$F\oplus F$, $p=2$ の $\pi_{\mathrm{tr}}=1,3,6,12,24,48$）して全一致、`npm run check`・`validate-content.ts`・`verify-check-linkage.ts` も再実行。規約どおり作業ブランチのみ push。 （当初の指示: cycle 18 step 2 §7.2 の未解決。(i) $\pi_{\mathrm{tr}}(p,k)=p^{e_k}\pi(p,1;S)$ の指数列 $(e_k)$ を固有値データから決める式、(ii) 最大単因子の付値 $w^*$ を代数的不変量（Newton 多角形・分岐データ）で書けるか、(iii) 予想 A（$k\ge w^*+1$ で $\pi_{\mathrm{tr}}(p,k+1)\mid p\,\pi_{\mathrm{tr}}(p,k)$、隙間 $w^*+1\le k\le2w^*$）の証明、(iv) 命題 C′ の Lean 化（主張の検算が目的。cycle 17・18 で 2 サイクル連続で本文の誤りを検出した手法）。） |
| 4 | — | rank:cycle19 | done | 2026-08-01 | 下記「cycle 19 総括」。**掲げた 3 点（4 点目はユーザー判断なので step にしない）はすべて潰れた。** 最大の成果は**退化塔の型 III の原因が特定されたこと**（$\theta=\infty$ の $\mathbb{Z}_\ell$ 点の $\ell$ 進近傍）と、**cycle 18 で「数値支持どまり」と明記した主張が 2 件とも定理へ格上げされたこと**。cycle 20 の焦点は 4 点。 |

## cycle 20 step 列（2026-08-01 起こし。cycle 19 総括の「cycle 20 の焦点（案）」4 点をそのまま step にした）

**前提**: cycle 19 で退化塔の分類は $\ell$ 奇についてほぼ閉じた（型 II は定理 J6、型 III は定理 J7・定理 X′）。
残る穴は 3 つで、(a) 定理 J4 が $\theta$ を決めない唯一の場合＝**打ち消し**（$|J(r)|\ge2$）、
(b) $S_\infty$ の候補集合は有限計算で尽きるが**各候補での判定手続き**が族についてしか完成していない、
(c) **$\ell=2$** は $S_\infty$ の点が $\bmod\ 2$ で分離されず両 step の仮定が破れる。
加えて (d) cycle 17・18・19 と 3 サイクル連続で形式化が主張の検算として効いているのに、
**cycle 19 の新定理群はまだ Lean に通していない**。cycle 20 はこの 4 点を step にする。

**運用上の申し送り（cycle 19 の失敗から）**: 長時間の数値掃引を**起動しただけでターンを閉じない**。
掃引は前景で、宣言した壁時計上限つきで回し切る。打ち切ったら件数と中身を必ず書く。
検証は PASS/FAIL だけでなく**内訳を吐かせる**（cycle 19 の最大の誤りはそこから見つかった）。

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T3 Pure | cancellation_recursion | done | 2026-08-01 | `outputs/reports/cycle20_T3_cancellation_recursion.md` / `sagemath/check/cycle20_T3_cancellation/`（FAIL 0、打ち切り 1 件＝下記）。**打ち消しは起きない。障害は消えた。** (1) **定理 L1（桁枝再帰）**: $\overline{\Phi}$ を Hasse 微分ではなく**指数の剰余類**で分解すると $\overline{\Phi}=\sum_{c<\ell}(1+x)^cg_c(x^\ell)$ となり、干渉行列が $\binom{c}{s}$（$\mathbb{F}_\ell$ 上の下三角単位行列）なので**退化しえない**。よって $\theta$ は**常に決まる**。定理 J4 で打ち消しが起きたのは項を「寄与する位数」でまとめたせいで干渉行列が根を持ちえたからで、**まとめ方を変えるだけで消える**（§4）。cycle 19 の反例（$\ell=2$ トーラス $\theta(1,3)=6$。定理 J4 は $\ge4$ しか出せない）で再帰は真値を返す。(2) **系 L2・L3′**: 鋭い上界 $\theta\le\ell^{\mathrm{sep}}-1$（達成される）と、**係数から計算できる一様な有効上界**。cycle 19 系 J3 が $\mathbb{P}^1(\mathbb{Z}_\ell)$ のコンパクト性という**非構成的**な根拠で得ていた有界性（どのレベルで止まるか教えない）を置き換えた。(3) **定理 L4（終結式公式）** $\hat\theta_M=v_\ell(\mathrm{Res}_x(\Psi_M,\Phi))$ により**定理 B′ の「最小点が一意」という仮定が不要**になり、**定理 K′（無仮定の予言アルゴリズム）**が得られた。(4) **課題設定の前提のずれを自分で見つけて明記**: cycle 19 が落としていた 174/165 個の塔は**定理 J4 の打ち消しではなく定理 B′ の tie** が原因で、別の障害だった（cycle 19 の検証コードを読んで判明）。結果的に本 step は両方を潰した。母集団測定では $\ell=2$ で 174 個**全て**が埋まり塔の値と全一致、$\ell=3$ は 99 個が埋まり全一致。**打ち切りを隠していない**: $\ell=3$ は壁時計 1500 秒上限で 430 個中 252 個で停止し 178 個（すべて 2 頂点 3 重辺の族）が未実施。測定が bouquet 族に偏ることも明記。**step 4 の指摘（桁定理の暗黙の仮定 $A_1\equiv0$）への対応も済み**（影響は系 L3′ だけで、しかも本設定ではラプラシアン行列式の対称性から無条件に従うので追加仮定にならない、と切り分けて注記）。**呼び出し元の検証**: **中心的な主張 2 つを完全に独立な経路で確認**した——反例の点で再帰が真値 $\theta(1,3)=6$ を返すこと（$\mathbb{F}_2$ 冪級数で直接計算）と、**定理 L4 の終結式公式が円分体での直接付値計算と 720/720 一致**すること（$\ell=2,3,5$、仮定なし）。sage も再実行。`npm run check`・`validate-content.ts`・`verify-check-linkage.ts` も再実行。規約どおり作業ブランチのみ push。 （当初の指示: cycle 19 step 1 §7.1。定理 J4 の Newton 評価は $\mathrm{argmin}$ が一意なら等号だが、$|J(r)|\ge2$（打ち消し）では $\theta$ を決めない。破れるのは $\sum_{j\in J(r)}\lambda_j\beta_v^j=0$ となる高々 $\max J(r)$ 個の $\beta_v$ に対してだけなので、**$\beta$ の次の桁が効く階層へ降りる再帰**を書けば閉じる可能性がある。奇素数でも起きる実例が §7.1 の表にある。閉じないなら**何が妨げているかを反例つきで確定**させる。） |
| 2 | T3 Pure | s_infinity_decision_procedure | done | 2026-08-01 | `outputs/reports/cycle20_T3_s_infinity_decision.md` / `sagemath/check/cycle20_T3_s_infinity/`（FAIL 0、前景で完走 173 秒）。**判定手続きが完成した**（定理 W3 `S∞-DECIDE`）: $D$ の係数だけから $\mathbb{F}_\ell$ 上 $O(|S|^3)$ で $S_\infty$ を完全決定する。塔の値も円分体も $\mathbb{R}$ も使わない。**さらに中心的な発見**: **$j^*(P)$ は $\bar{\tilde E}$ の二項式因子 $\chi^{u^\perp}-1$ の重複度に等しい**（定理 W4）。帰結として **$n\ell^n$ の係数は $b=\bar{\tilde E}$ の原始二項式部分の次数**（系 W6）で、上界 $b\le\frac12\mathrm{per}(\mathrm{Newt}(\bar{\tilde E}))$ も出る（系 W7）。cycle 19 step 2 §9.1 の「分解しない場合は手がかりが無い」は $b$ については誤りで、残りの因子は $b$ に効かない。**定理 J7 の仮定 (N) も不要になった**（系 W5、$r_0$ の明示式つき）。残る仮定は (B\*) だけ。**(B\*) は外せないことを反例で確定**し、しかも **cycle 20 step 1 の「(B\*) の破れは $\ell=2$ 固有」という読みが誤りであることを示した**（$\ell=3$ の bouquet $(1,0),(0,1),(1,1),(1,-1)$、$b=4$ で破れる）。**数値支持どまりは 2 件**で、標本 13 組では破れ率 23% までしか除外できないと**弱さを明記**。**自分の誤りを 3 件記録**（判定基準の誤り／(B\*) を $\ell=2$ 固有と思い込みかけたこと／検証ログを `tail` にパイプして進捗が見えない状態を作ったこと）。**打ち切りも明示**（深い掃引の対象外 114 塔＋$\ell=11$ の 1 塔、$\ell=7$ の 3 塔はレベル不足で $b$ の当てはめ不可）。**呼び出し元の検証**: **反例の塔を完全に独立な経路で確認**——塔の値をラプラシアン余因子から厳密計算して $n=1,2,3$ で $14,100,450$ を得、当てはめが $b=4$（係数すべて整数）になること、そして $\bar{\tilde E}$ を $\mathbb{F}_3$ 上で因数分解して二項式因子の次数の和も **4** になること（系 W6 と一致）を確認。sage も再実行。`npm run check`・`validate-content.ts`・`verify-check-linkage.ts` も再実行。規約どおり作業ブランチのみ push。 （当初の指示: cycle 19 step 1 §7.2。$S_\infty$ の候補集合（$\mathrm{supp}(\bar{\tilde E})$ の差ベクトル）は有限計算で尽きることが証明済み（系 J10）だが、**各候補で $\theta=\infty$ かを判定する手続き**は 1 頂点 bouquet 族についてしか完成していない（step 2 命題 8）。一般の塔で判定手続きを**実装し、母集団で検証する**。step 2 の命題 2（$(\chi^{u^\perp}-1)\mid\bar{\tilde E}$）と step 1 の系 J10 を突き合わせて使うこと。） |
| 3 | T3 Pure | ell_equals_2 | done | 2026-08-01 | `outputs/reports/cycle20_T3_ell_equals_2.md` / `sagemath/check/cycle20_T3_ell2/`（PASS 13925・FAIL 0・打ち切り 0 件、前景で完走 7397 秒）。**結論: $\ell=2$ は構造的に射程外ではない。道具が足りなかっただけだった。** cycle 19 step 2 注 5.2 が挙げた「$\ell$ が奇であること」の 3 つの使用箇所は**3 つとも修復でき**、族 $p(1,0)+q(0,1)$ について $\ell=2$ でも**全レベル・全点の付値と全ての $n$ の閉形式**が得られた（定理 Y・**定理 Y′**）。$\ell$ 奇に無い枝が 2 つ出る: **飽和**（$v_2(4)$ で止まる）と**打ち消し**（次の 2 進桁が効く）。**$\ell$ 奇との差は 3 点に集約**: (a) $\ell=2$ の族は**例外なく型 III**（非退化も型 II も無い。命題 P1。$\ell$ 奇の 3 分割＝cycle 19 命題 9 の $\ell=2$ 版）、(b) $n\ell^n$ の係数は**両者とも 2 で同じ**、(c) **$\ell=2$ だけ追加の不変量 $w$（係数の次の 2 進桁）が要る**。cycle 19 定理 X′ を $\ell=2$ に当てて正しいのは case B かつ $\lambda_1\ge2$ のときちょうど（系 Y″）。**cycle 16 補題 5.5 の $(M+1)2^M-4$ の正体も同定**（定理 J7 の証明 (b) と同じ相殺＋$\ell$ 奇には無い**飽和層 1 本**）。cycle 16 定理 D2（$\ell=2$ トーラス）は 4 つの場合のうち 1 つの 1 点にすぎないことも判明。**数値支持どまりは 1 件だけ**（族の外の一般 $\ell=2$ 塔でも $n2^n$ の係数が $\sum j^*$ になること。母集団 430 塔の全走査で対象 174 塔すべて一致・不一致 0。検出力は破れ率 1.7% までと明記）。**自分の誤りを 3 件記録**（チャートの選び方を誤って 75 塔で偽の結論を書きかけた／自由度 0 のフィットを out-of-sample と誤認／「形が合わない」と「安定が遅い」を混同）。**執筆中に main へ入った step 1 の定理 L4 を踏まえて自分の §6.3 を訂正**（「$\Theta_M$ の定数項が出ない」は「cycle 19 の道具では出ない」の意味に限定）。論文本文は「一般の $\ell=2$ 塔が未決着のまま移すと cycle 18 型の転記事故を招く」との理由で意図的に触っていない。**呼び出し元の検証**: **主結果 (5.4) を完全に独立な経路で検算**——ラプラシアン余因子から塔の値を厳密計算し、**4 つの場合分けすべてと $\mu>0$ の場合で 24/24 一致**。さらに **$w$ が本当に必要であること**（同じ $\mu,\lambda_1$ で $(2,1),(2,3),(2,7)$ の値が $n=2$ で $21,23,25$ と分かれ、$w=v_2(p'/2+q')$ の式と一致すること）も独立に確認。`npm run check`・`validate-content.ts`・`verify-check-linkage.ts` も再実行。規約どおり作業ブランチのみ push。 （当初の指示: cycle 19 step 1 §7.3・step 2 §9.3。$\ell=2$ では $S_\infty$ の 2 点が $\bmod\ 2$ で分離されないため、定理 J7 の仮定 (N)・(B\*) も定理 X の場合分けも破れる（$\ell$ が奇であることを 3 箇所で使っている。step 2 注 5.2）。cycle 16 が $\ell=2$ トーラスを特別扱いした理由は説明がついたが、**$\ell=2$ 自体の閉形式は無い**。$\ell=2$ トーラスでは $n2^n$ の係数だけは当たる（cycle 19 step 1 §5.4）ので、そこから何が一般化できるかを詰める。**$\ell=2$ が構造的に射程外なのか、道具が足りないだけなのかを決着させる**のが成果。） |
| 4 | 運用 | lean_cycle19_theorems | done | 2026-08-01 | `outputs/reports/cycle20_ops_lean_cycle19_theorems.md` / `lean/IntegrableLattice/DigitTheorem.lean`・`TowerTypeCoefficients.lean`。**4 サイクル連続で形式化が主張の検算として効いた。** (1) **誤り 1 件**: cycle 19 step 2 の report §5.4 の**例示 2 行**が誤り（$\ell=7$ の $(3,4)$、$\ell=11$ の $(5,6)$ はどちらも $\ell\mid p'+q'$ ＝命題 8 の場合 [A] で例外直線 2 本なので $\Lambda=2$ なのに、$\Lambda=1$ の式を書いていた）。**定理 X′ 本体・命題 8 の表・機械検証はいずれも正しく、誤りは例示だけ**。呼び出し元がラプラシアン余因子から独立に計算して確認（$n=1$ の真値は 26・42、誤った式は 20・32）し、**cycle 19 の report を訂正した**。(2) **暗黙の仮定 1 件 → 本文を訂正**: 桁定理 (J1) が $A_1\equiv0$ を仮定として書いていなかった。$m<\ell^L$ の段は Lucas だけで通るが **$m=\ell^L$ ちょうどの段はこれなしでは偽**（$\tilde E=z$, $\ell=3$, $L=1$ で反例）。仮定・出所・反例を本文へ追記。**根拠 report 側は正しく引いていた**ので、これも「report から本文へ移す段で壊れる」型（cycle 18 と同型）。(3) **過剰仮定 2 件**（定理 J6 の仮定 (ii) は総和の段には効かない／「係数が $L$ に依らない」は比例関係 2 本から出る）。それ以外は食い違いなし。**定理 J8（step 1 の道具）と定理 X′ の $\Lambda=2$（step 2 の道具）が Lean 上でも一致**し、cycle 19 が主張した相互検証が再現した。**mathlib の欠落と配線不足を分離**: matrix-tree は**欠落**（`kirchhoff` 0 件を確認）、定理 J7 の主張・定理 X の付値計算・命題 J2′ の同値は**配線不足**（`PowerSeries.order`・二項冪級数・`IsCyclotomicExtension`・`Nat/Choose/Lucas.lean` の実在を検索で確認済。ログ `lean/logs/mathlib-gap-survey-cycle20.log`）。**呼び出し元が `lake build`（8671 jobs 成功、cycle 19 は 8668）と `check-no-sorry.sh`（156 定理が sorryAx 非依存、cycle 19 は 107）を再実行**し、指摘された誤りを独立計算で確認、`npm run check`・`validate-content.ts`・`verify-check-linkage.ts` も再実行。規約どおり作業ブランチのみ push。 （当初の指示: cycle 19 の新定理群を Lean に通して**主張を検算する**（目的は証明の正しさではなく主張の一意性）。対象は定理 J6（$\theta$ 有限 ⇒ 型 II）・定理 J7（$n\ell^n$ の係数 $b=\sum j^*$）・定理 X′（bouquet 族の閉形式）・定理 J2（桁定理）。cycle 17 は命題 B の誤り、cycle 18 は命題 N・W の誤り、cycle 19 は過剰仮定 2 件を検出しており、**3 サイクル連続で効いている**。`lake build` と `check-no-sorry.sh` を自分で実行し sorryAx 依存 0 を確認する。**mathlib に補題が「無い」と書く前に必ず検索で実在確認する**（cycle 16 で偽陰性の事故、cycle 18・19 でも書きかけた）。） |
| 5 | — | rank:cycle20 | done | 2026-08-01 | 下記「cycle 20 総括」。**掲げた 4 点はすべて潰れた。** cycle 19 が挙げた 3 つの障害（打ち消し／判定手続き／$\ell=2$）は**いずれも「原理的な壁」ではなく道具の選び方の問題だった**。cycle 21 の焦点は 4 点。 |

## cycle 21 step 列（2026-08-01 起こし。cycle 20 総括の「cycle 21 の焦点（案）」4 点をそのまま step にした）

**前提**: cycle 20 で cycle 19 の 3 障害はすべて消え、仮定も次々に落ちた。残るのは
(a) 定理 J7 の**最後の仮定 (B\*)**（$\ell=2$ にも奇素数にも反例がある）、
(b) 一般の塔の閉形式は $n\ell^n$ の係数 $b$ しか出ておらず**残りの係数 $c,d,e$ は族でしか出ていない**、
(c) cycle 20 の新定理群（定理 L1・L4・K′・W3・W4・Y′）が**まだ Lean に通っていない**、
(d) cycle 19・20 の結果で**本文へ移していないものが溜まっている**（step 3 は転記事故を避けて意図的に見送った）。

**本文の担当を step 4 に一本化する（衝突回避）**: 本サイクルでは **step 1・2・3 は
`structured-latex/` と `structured-latex-en/` を一切触らない**（report と sagemath だけ）。
本文への反映は step 4 がまとめて行う。

**運用上の申し送り（cycle 19・20 で 3 回再発）**: 長時間掃引の起動直後にセッションが終了する事故が
指示の明記だけでは防げていない。**1 本のスクリプトの壁時計上限を 20 分以内に設計し、
超えるなら分割する**ことを設計要件として課す。

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T3 Pure | drop_assumption_B_star | done | 2026-08-01 | `outputs/reports/cycle21_T3_drop_assumption_B_star.md` / `sagemath/check/cycle21_T3_b_star/`（3 本とも FAIL 0・打ち切り 0、**設計上限 20 分に対し 3 本とも 20 秒以内で前景完走**）。**(B\*) は $b$ については落ちた**（定理 Q1）。cycle 20 §7.2(a) が「標本 13 組・破れ率 23% までしか除外できない」と隔離していた予想＝「(B\*) が破れても $b$ は当たる」が**定理に格上げ**された。**(B\*) が本当に効く場所も切り分けた**: $S_\infty$ の各点の最内側 $O(1)$ 個での付値の正確さで、**$b$ には効かないが $\ell^n$ 以下の係数 $c,d,e$ には効く**。実測でも (B\*) の破れ 143 点は**すべて**その $O(1)$ 個側で起き、等号が主張される 17781 点では 0 件。**そして本 step 最大の成果は既知性の同定である**: **定理 Q1 は Cuoco–Monsky, Math. Ann. 255 (1981) Theorem 1.7 ＋ Definition 1.2 そのもの**で、$b$ は彼らの $l_0(F)$ と定義から一致する（cycle 16 が取得済みの原文と対応表で照合）。**$b$ の式に新規性を主張してはならない。** 本 step が与えたのはグラフ側に閉じた初等証明のみ。**呼び出し元の追加確認**: 引用された Definition 1.2（$l_0(F)=\sum\mathrm{ord}_P(\bar F_0)$、$P$ は $(\bar\sigma-1)$ の形）は、**cycle 20 step 2 の系 W6（$b$＝原始二項式部分の次数）と同じ内容**である。したがって**系 W6 も既出**であり、本文の命題 K に Cuoco–Monsky の帰属を書き足す必要がある（cycle 22 の焦点に入れた）。なお本文は全体として新規性を主張しておらず、第 5 章で既に Cuoco–Monsky Theorem 1.7 を引用しているので**偽の新規性主張は存在しない**。**数値支持どまりは 2 件**（誤差比の収束・上界の緩さ）で検出力は「無いに等しい」と明記。**自分の誤りを 4 件記録**（うち 1 件は Step D が 108 件全 FAIL を出しその**内訳が「1 だけずれている」ことから特定**できた）。**呼び出し元の検証**: sage 3 本を再実行し全て FAIL 0・打ち切り 0 を確認。定理 Q1 の内容は、呼び出し元が cycle 20 で (B\*) の破れる例（$\ell=3$ の bouquet $(1,0),(0,1),(1,1),(1,-1)$）について**塔の値からの当てはめと二項式因子の次数の両方で $b=4$** を独立計算済みであり、それと整合する。`npm run check`・`validate-content.ts`・`verify-check-linkage.ts` も再実行。指示どおり本文・MEMORY・state を触っていない。 （当初の指示: cycle 20 step 2 §9・step 3。定理 J7 に残った最後の仮定 (B\*) を落とす。反例は $\ell=2$ トーラスと $\ell=3$ の bouquet $(1,0),(0,1),(1,1),(1,-1)$（$b=4$）。妨げは step 2 が具体化済み（$\bmod\ \ell$ の因数分解は $v_\ell(A_m)$ の列に届かない）。**cycle 20 step 1 の定理 L4（終結式）は同点でも値を出す**ので、そこから攻める道がある。落とせないなら**何が本質的に妨げているかを反例つきで確定**させる。） |
| 2 | T3 Pure | general_tower_closed_form | done | 2026-08-01 | `outputs/reports/cycle21_T3_general_tower_closed_form.md` / `sagemath/check/cycle21_T3_general_closed_form/`（FAIL 0、3 本とも設計上限 20 分の内側で完走）。**$\ell^n$ の係数 $c$ を一般の塔で明示式にした**（定理 G4）。$\Theta_M$ との照合 **1140 件**（母集団 124 塔 × $\ell\in\{2,3,5,7\}$、名前つきの塔は $\ell=2$ で $M\le9$ まで）と、Matrix–Tree 定理で独立計算した塔の値との照合 **371 件**がいずれも不一致 0。**当てはめは一切していない**（係数は $D$ から計算するので照合は自由度 0。**cycle 20 step 3 が犯した「自由度 0 のフィットを out-of-sample と誤認」する誤りを設計で回避**した）。**文献との関係を正しく切り分けた**: $b=\sum j^*$ は Cuoco–Monsky 1981 Thm 1.7 そのもので本 step の寄与ではない（同サイクル step 1 が先に証明）。**足しているのは $c$** で、Monsky 1989 が $\ell^n$ の係数について存在と $d=2$ での有理性しか示さず「no easy description」と明記している量を、voltage グラフの $\det L$ 型・$d=2$・(H) という限定の中で明示式にした。$d,e$ は Monsky の誤差項の外側。**それでも新規性は主張していない**（文献調査は網羅的でなく、捻り分解自体は岩澤理論で標準）。**取れなかったことも原理的に確定**: $(\Lambda_k,\theta^\sharp_k)$ を $\bar{\tilde E}$ だけから読む式は**存在しない**（$\ell=2$ トーラスの $\tilde E$ に $2zw$ を足すと $\bar{\tilde E}$ も $S_\infty$ も不変なのに $\Lambda_1$ が $2\to1$ に変わる。機械確認済み）。**$\ell^{2n}$ と $n\ell^n$ の係数だけが $\bmod\ \ell$ で決まる、という切れ目を確定させた。** **打ち切り 2 件**（どちらも $\ell=5$ の重い計算。$\ell=2,3$ には無し）を明示。**自分の誤りを 3 件記録**（cycle 19 注 4.2 を無条件だと思い込んだ／3 例が全部同じ形だったので一般化しかけた（母集団には別形が 41 個）／安定判定を十分条件でない形にしていた）。**呼び出し元の検証**: sage 3 本を再実行して FAIL 0 を確認。`npm run check`・`validate-content.ts`・`verify-check-linkage.ts` も再実行。指示どおり本文・MEMORY・state を触っていない。 （当初の指示: cycle 20 step 3 §9.1。$n\ell^n$ の係数 $b$ は族の外でも決まるようになった（定理 W4・系 W6）が、**残りの係数 $c,d,e$ は族でしか出ていない**。定理 K′（無仮定の予言アルゴリズム）と定理 L4 を使えば一般の塔でも $\Sigma_n$ が計算できるはずなので、そこから $c,d,e$ を不変量で書けるかを詰める。） |
| 3 | 運用 | lean_cycle20_theorems | done | 2026-08-01 | `outputs/reports/cycle21_ops_lean_cycle20_theorems.md` / `lean/`。**6 サイクル連続で本文の問題を検出した。** **本文の不備 2 件**（いずれも日本語版・英語版の両方）: (1) 定理 Y′ の場合分け第 3 行の条件が「および**全ての場合**の $n=1$」となっていたが、**case A では $\lambda_1$ が定義されていない**。実際に必要なのは case B かつ $\lambda_1=1$ の $n=1$ だけで（無いと偽になることを反例で確認）、case A では第 1・2 行から従う＝冗長。**同 cycle の step 4 がこれをそのまま本文へ移していた**。(2) 命題 R (R1) で押し下げた族の係数が**添字なしの $\mu$**（$\mu_{c+\ell\gamma}$ であるべき）。**根拠 report 側は正しく、本文へ移す段で落ちた型の事故（cycle 18・20 に続き 3 回目）**。**この 2 件は呼び出し元が日英とも訂正し、`verify:correspondence` の違反 0 を確認した。** ほかに **証明の根拠不足 1 件**（系 Y″ の「$n=1,2$ の 2 点で既に食い違う」は $\Lambda$ を動かすと偽。case A$\alpha$ は $\Lambda=1$ の定理 X′ と $n=1,2$ で一致し $n=3$ で初めて分かれる。**主張自体は正しく本文は無傷**、report の括弧内だけの問題）、**過剰仮定 2 件**（定理 L1 の $s^*$ 存在に二項係数行列の可逆性は不要——$C$ の最大元 1 つで済み、$\ell$ の素数性も体であることも不要、上界も $s^*\le\max C$ と鋭い／係数取り出しに $c<\ell$ は不要）、**役割分担が読み取りにくい箇所 1 件**（本文 (K3)「$S_\infty$ を完全に決める」で決まるのは点集合まで。$\ell=3$ の族で $|S_\infty|=1$ なのに $b=2$＝重複度）。**形式化できなかったものを欠落と配線不足に分離**: Kirchhoff／全域木数／Newton 多面体・格子周長は **mathlib の欠落**（3 段検索で 0 件）、定理 L4・K′・W4 等は**配線不足**（`Polynomial.resultant`・`IsCyclotomicExtension`・`PowerSeries.Binomial`・`AddMonoidAlgebra.mapDomain_mul` はいずれも実在を確認済）。**自分の誤りを 5 件記録**（記憶で型を思い込んだ件、欠落調査でフレーズをファイル名検索して無意味な 0 件を出した件を含む）。定理 Y′ を **Matrix–Tree ＋整数 Bareiss 法で独立再計算**（12 塔 × $n\le4$ ＝ 48 件、FAIL 0。report の 3 経路とは別経路）。**呼び出し元の検証**: 指摘された本文 2 件を自分で確認して訂正し、日英の検査一式と対応検証（違反 0）を再実行。`lake build` と `check-no-sorry.sh` も再実行して**完走を確認した**（**8674 jobs 成功**／cycle 20 は 8671、**196 定理**が sorryAx 非依存／cycle 20 は 156。サブエージェントの報告と一致）。**ただし他セッションの並行ビルドでマシンの負荷平均が 432 に達し、完走まで約 2 時間半かかった**（総括を書いた時点では未完了で、いったん「確認できていない」と記録してから完走を受けて訂正した）。定理 Y′ については呼び出し元が cycle 20 で全 4 場合分け 24/24 の独立計算を済ませており、サブエージェント側でも Matrix–Tree ＋整数 Bareiss 法という別経路で 48 件を再計算している。 （当初の指示: cycle 20 の新定理群を Lean に通して**主張を検算する**。対象は定理 L1（桁枝再帰）・定理 L4（終結式公式）・定理 K′・定理 W3（判定手続き）・定理 W4（$j^*$＝二項式因子の重複度）・定理 Y′（$\ell=2$ の閉形式）。**とくに定理 K′ と定理 W3 は「有限手続き」の主張なので形式化と相性がよい**。**5 サイクル連続で本文の問題を検出している**（17: 誤り／18: 誤り 2／19: 過剰仮定 2／20: 誤り 1・暗黙の仮定 1・過剰仮定 2）。`lake build` と `check-no-sorry.sh` を自分で実行。**mathlib に「無い」と書く前に必ず検索で実在確認する。**） |
| 4 | 運用 | reflect_to_paper | done | 2026-08-01 | `outputs/reports/cycle21_ops_reflect_to_paper.md`。**移したのは 1 件**（cycle 20 step 3 の定理 Y′ ＝ $\ell=2$ の bouquet 族の閉形式）を**命題 G″**（`content/005c_ell2_family.ts`）として新設。場合分けの排反性・網羅性、族が例外なく型 III であること、点ごとの付値（$\ell$ 奇に無い**飽和**と**打ち消し**の 2 枝）、4 通りの閉形式、命題 G′ が $\ell=2$ で正しい範囲（case B かつ $\lambda_1\ge2$ ちょうど）を含む。**射程が族に限ることを本文に明示**し、一般の $\ell=2$ 塔の未決着とその妨げを限界として書いた。母集団 430 塔の走査は report が数値支持どまりと書いているので**主張として立てず「証明ではない」と明記**。**残る 3 件は既に本文へ入っていた**（cycle 20 step 1 → 命題 R／step 2 → 命題 K／cycle 19 step 3 → 命題 W\*・C″）ことを根拠 report と 1 対 1 で突き合わせて確認し、**仮定の書かれ方まで一致**していた。**主張の食い違いは 0 件**だが**記述の不備 1 件を検出・修正**（命題 R (R3) の上界が report の但し書きを落として空集合上の max になっていた）——**まさに本 step が警戒していた「report にある但し書きが本文で落ちる」型**。**自分の誤りを 1 件記録**: 英語版の整形中に**インライン数式ノードを 11 個落とし**、しかも当該ブロックが**数式差の例外表に登録済みだったため日英対応検証をすり抜けた**。自分で多重集合照合を書いて検出し全て復元。**「例外表への登録は検査に穴を開ける操作である」という認識の薄さが原因**と明記。英語版にも `005c_ell2_family.ts` を新設し用語集も更新。**呼び出し元の検証**: 日本語版・英語版の `npm run check`、`validate-content.ts`、`verify-check-linkage.ts`、**英語版の `verify:correspondence`（違反 0 件）**を再実行。さらに**日英の数式を独立に多重集合照合**し、新規ブロックが **174 対 174 で一致**、残る差は翻訳部分（`\text{}` の中身）と規定どおり除いた内部パス参照だけであることを確認（例外表が穴を開けていないことの独立チェック）。本文へ移された閉形式が**呼び出し元が cycle 20 で全 4 場合分け 24/24 独立検算した式と一致**することも確認。規約どおり作業ブランチのみ push。 （当初の指示: cycle 19・20 の未反映分を論文本文へ移す。**本サイクルで本文（`structured-latex/` と `structured-latex-en/`）を触るのはこの step だけ。** 重要: **「report は正しいのに本文へ移す段で壊れる」型の事故が cycle 18・20 で 2 回出ている**ので、**根拠 report と機械的に突き合わせながら**移すこと。**英語版が別セッションで完成している**ので、日本語正本を変更したら `structured-latex-en/` にも反映し、`verify-ja-en-correspondence.ts` を通すこと。） |
| 5 | — | rank:cycle21 | done | 2026-08-01 | 下記「cycle 21 総括」。**掲げた 4 点はすべて潰れた。最大の成果は、主要係数の式が既出（Cuoco–Monsky 1981）だと同定されたこと**と、**その次の係数を一般の塔で明示式にしたこと**（Monsky 1989 が「easy な記述は無い」と書いた量）。cycle 22 の焦点は 4 点。 |

## cycle 22 step 列（2026-08-01 起こし。cycle 21 総括の「cycle 22 の焦点（案）」4 点をそのまま step にした）

**前提**: cycle 21 で掲げた 4 点はすべて潰れた。残るのは
(a) **帰属の書き足しと既出性の未決着**（命題 K は Cuoco–Monsky 1981 Definition 1.2 そのもの。
定理 W3・W4 が CM で既出かは **CM §2 以降が未読**で判定していない）、
(b) **転記事故が 3 回目**（cycle 18・20・21）。「本文を触るのは 1 step だけ」は衝突回避には効いたが
転記事故は防げていない。**移した直後に根拠 report と機械的に差分を取る道具**が要る。
併せて**例外表への登録が日英対応検証に穴を開ける**問題（cycle 21 step 4 で実地に露見）を塞ぐ、
(c) **係数 $d,e$ が未取得**（$b$ は既出、$c$ は cycle 21 step 2 が明示式にした。残りは Monsky の
誤差項の外側で、「$\bmod\ \ell$ では読めない」という切れ目は確定している）、
(d) **cycle 21 の新定理群（定理 Q1・G4）が Lean に通っていない**。加えて **cycle 21 step 3 の
`lake build` は他セッションの並行ビルドで負荷平均 432 に達し、呼び出し元が完走を確認できていない**。

**本文とツールの担当を分ける（衝突回避）**:
- `structured-latex/content/` と `structured-latex-en/content/`（本文）を触ってよいのは **step 1 だけ**。
- `structured-latex/tools/` と `structured-latex-en/tools/`（検査道具）を触ってよいのは **step 2 だけ**。
- step 3・4 は本文もツールも触らない（report・sagemath・lean だけ）。

**運用上の申し送り（cycle 21 で有効性が確認された設計要件を継続）**: **1 本のスクリプトの壁時計上限を
20 分以内に設計し、超えるなら分割する**。cycle 19・20 で 3 回再発した「掃引起動直後にセッションが
終了する」事故は、cycle 21 でこの設計要件にしたことで 0 件になった。
**検証は PASS/FAIL だけでなく内訳を吐かせる**（過去サイクルの重要な誤りはすべて内訳から見つかった）。

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T3 Pure | cuoco_monsky_attribution | done | 2026-08-01 | `outputs/reports/cycle22_T3_cuoco_monsky_attribution.md`。**既出性を決着させた。** (K6)（$b$＝原始二項式部分の次数）は **Cuoco–Monsky (1981) Definition 1.2 ＋ Theorem 1.7 そのもの**で、本文の命題 K・命題 J に帰属を書き足した（日英とも）。**定理 W3 は半分が既出**——中核の同値は **Monsky, *Some invariants of $\mathbb{Z}_p^d$-extensions*, Math. Ann. 255 (1981) Lemma 2.3（$d=2$）と同じ内容**（特殊化 $z\mapsto(1+T)^a,w\mapsto(1+T)^b$ の下で $\theta=\infty\iff\bar G_a=0$、$X_1\mid\bar G$ が (K2)(iii) にあたることを導出して同定）。一方 **(K3) の有限手続きと定理 W4（$j^*$＝重複度）は読んだ範囲に無い**（Lemma 2.3 の逆向きは $\lambda(G_a)\le r$ という**上界**しか与えない）。**読んだ範囲を明示**: CM 1981 は pp.235–258 の全 24 ページ、Monsky *Some invariants* は全 5 ページ、Cuoco (1980, Compositio Math. 41) は Introduction と Theorem 1.1 周辺。**未読は Cuoco の学位論文（Brandeis, 1979）**で「そこに無いとは言えない」と本文にも書いた。**自分の誤りを 3 件記録**（強調記号を数式ノードをまたいで書きビルドが日英計 4 箇所で落ちた／英語版で書誌を `cite` に任せて日本語版にだけ数式が 1 個残り、**例外表に登録済みのブロックだったため公式の検査では出ず**自前照合で検出／引用元の References から表題を写しかけた）。**本文の既存の不備 1 件を検出・修正**（英語版が (K4) の解説で $\ell$ 進近傍を "p-adic neighbourhood" と書いていた。本論文で $p$ は別の素数）。**呼び出し元の検証**: **Monsky 1981 p.231 の原ページ画像を GDZ から自分で取得して直読し、Lemma 2.3 の本文・証明・「逆向きは上界のみ」が report の引用と一致することを独立に確認**した。日本語版 `npm run check`、`validate-content.ts`、`verify-check-linkage.ts`、英語版 `check:full`（対応検証 違反 0・例外表は 11 件のまま増えていない）を再実行。指示どおり検査道具・MEMORY・state を触っていない。 |
| 2 | 運用 | transcription_guard | done | 2026-08-01 | `outputs/reports/cycle22_ops_transcription_guard.md` / `structured-latex/tools/`。**転記事故を機械検出できるようにした。** 事故 3 件を git 履歴から形で分類し、検査を 2 本に分けた——**検査 A**（本文ブロック↔根拠 report を台帳で結び、report の条件・例外・仮定を述べる文の数式アトムと専門語が本文にもあるかを見る。$\mu_\gamma$ と $\mu$ を別物として区別）が cycle 18・20 型を、**検査 B**（同じブロックが添字つきで使う記号を、その添字を束縛する和の中で裸で使う）が cycle 21 型を捕まえる。**検査 B が必要な理由も実データで確認済み**（report 側にも裸の $\mu$ が出るので report 照合では原理的に捕まらない）。**「エラーが出なかった」を根拠にせず、検出を実証**: 事故 3 件を再現データに起こして 3/3 検出、当たらなくなればテストが落ちる。**例外表の穴を塞いだ**——免除の単位を**ブロックから差分 1 つへ**落とし、許す差の種類を宣言させる形にした。**登録済み 11 ブロックの英語版の数式を 1 個ずつ落として 765/765 で違反**（**旧実装ではこの全件が黙って通っていた**）。**限界を明示**: cycle 21 の命題 G″ の場合分け（未定義の記号を含む条件）は挙がらない＝**転記検査は Lean 化の代わりにならない**／台帳は定理型 32 ブロック中 8（25%）で残りは検査 A の対象外（毎回件数を出力）／語の切り出しは形態素解析ではないので「語が無い」は疑いであって誤りの証明ではない。**自分の誤りを 4 件記録**。**step 1 が直した英語版の $\ell$ 脱落を独立に検出**していた（本文は step 1 の担当なので触らず report に直し方を書いた）。**呼び出し元の検証**: step 1 とマージしたうえで日英の検査一式を再実行し、**新しい厳しい対応検証が 違反 0 で通る**こと（step 1 の修正で緑になる、という報告どおり）、転記検査が 違反 0・検出テスト 3/3、`test:correspondence` が 765/765・7/7 であることを確認。指示どおり本文・MEMORY・state を触っていない。 |
| 3 | T3 Pure | coefficients_d_e | done | 2026-08-01 | `outputs/reports/cycle22_T3_coefficients_d_e.md` / `sagemath/check/cycle22_T3_coefficients_d_e/`（FAIL 0）。**まず step の前提が誤っていた**——**$d,e$ は cycle 21 定理 G4 で既に決まっていた**（$d=\gamma-2$ は (5.4) が、$e$ は定理 G1 (2.3) が与え、cycle 21 の `coeffs_of` は実際に 5 係数すべてを返して 371 件照合済み）。**この step 列を書いた呼び出し元（私）の読み違いである。** 残っていたのは値ではなく**構造の理解**で、本 step はそちらを取った。**定理 D1（$c$ と $d$ の分業）**: 捻り段データの**付値側** $\Lambda_k$ は $c$ にだけ、**位置側** $\theta^\sharp_k$ は $d$ にだけ入る。$d$ は $S_\infty$ の各点の局所量だけで書け大域平均も過渡も使わない。系として **$d$ は常に整数**（$c,e$ は $13/3$ 型の非整数になりうる）＝**5 係数のうち $d$ が最も局所的**で、「次数が低いほど難しい」は成り立たない。**定理 D2**: $e=v_\ell(\kappa(X))-a-c+T_\mathrm{def}$（$T_\mathrm{def}$＝過渡欠損。有限和・$M^*$ 非依存）。**情報階層を 3 層に確定**——$(a,b)$ は $\bmod\ \ell$ 層、$(c,d)$ は捻り段データ層、$e$ だけがさらに過渡層を要する。**これが「どの追加情報が要るか」への答えである。** **切れ目は $b$ と $(c,d,e)$ の間**（定理 D3。$\bar{\tilde E}$ も $\mu$ も一致する**実在の voltage グラフ 2 本**で $d,e$ が違う。**cycle 21 §9.1 の強化**——同 §9.1 の反例は $\tilde E$ への摂動でグラフとして実現できるか未確認だった）。**さらに「どんな固定精度でも足りない」**（定理 D4: 任意の $N$ で $\bmod\ 2^N$ 一致なのに $c$ が 3 違う対／定理 D5: 同じく $\Lambda_1$ 不変・$\theta^\sharp_1$ だけ動いて $d$ が 2 違う対。**位置側の障害は付値側の系ではない**）。**逆向きも取れている**（定理 D6: $N>\max\Lambda_k$ なら $\bmod\ \ell^N$ が $(c,d)$ を決める。必要精度は各塔で有限・計算可能だが塔を渡ると非有界）。**当てはめは一切なし（自由度 0）**、手計算した段データと機械計算を 1 対 1 で突き合わせる二重の担保つき。**自分の誤りを 5 件記録。新規性は主張しない。** **呼び出し元の検証**: sage 4 本を再実行し **FAIL 0・打ち切り 0**。**しかも `tower_check` は呼び出し元の再実行で $\ell=5$ まで完走し、照合 505 件・不一致 0（サブエージェント側は 317 件で $\ell=5$ を打ち切っていた）＝報告された唯一の打ち切りは壁時計依存で、呼び出し元の実行で塞がった。** cycle 21 の `coeffs_of` が $d,e$ を返していることもコードを読んで確認（前提の誤りの裏取り）。`verify-check-linkage.ts` も再実行（本 step の check は本文未反映のため孤立扱い。cycle 23 の反映対象）。 |
| 4 | 運用 | lean_cycle21_theorems | done | 2026-08-01 | `outputs/reports/cycle22_ops_lean_cycle21_theorems.md` / `lean/`。**7 サイクル連続で根拠 report の問題を検出した。** 最大の成果は **定理 G4 の内部の食い違い**: §5.3 の $M^*$ 条件 2 が 1 つ強すぎ、**同じ report の §6.1（定理 J8 との照合）が自分でその条件を破っている**。Lean で層の総和公式の成立条件を型に出したところ**正しいのは §6.1 の側**で、直すべきは §5.3。ほかに **「明示定数」が明示定数でない 1 件**（定理 Q1 の $C$ が $\lvert\mathcal B_M\rvert$ 経由で $M$ 依存）、**根拠が書かれていない 2 件**（補題 Q5 に効くのは**狭義**不等式／定理 G4 注 4.2 の打ち消しの理由）、**暗黙の仮定 1 件**（補題 Q0 の非零性）、**検証範囲の逸脱 1 件**（§6.3 の $n=1$ からの一致は定理の保証範囲外。一致自体は事実）。食い違い無しの側では定理 G1 の **5 係数すべて**が恒等式として通り、定理 Q1 の $b$ と定理 G4 の $b$ が**別経路で同じ値になること**も型で確認。**負荷平均の読み方を訂正**——着手時 `uptime` は 582 だが `top` の CPU idle は 42.8% で、負荷平均は 9400 スレッドに引きずられ空き容量を表していない。**cycle 21 の「負荷平均 432 で完走を確認できなかった」は指標の読み違いだった可能性が高い。以後この判断には `top` の idle を使う。** **自分の誤りを 3 件記録**（うち 1 件は「mathlib に在ると確認せず書く」で**前サイクルが記録した誤りの再発**）。**呼び出し元の検証**: **`lake build` を自分の作業ツリーで独立に実行し `Build completed successfully (8676 jobs)`、`check-no-sorry.sh` で 231 個（依存公理を出力する 228 ＋ 公理なし 3）すべて sorryAx 非依存を再現**——**cycle 21 で確認できていなかった 8674 jobs／196 定理は、これで独立に裏が取れた**。`check-no-sorry.sh` の差分が**対象定理の追加だけ**（検査を緩めていない）ことも確認。なお worktree に mathlib が無く初回取得が途中で壊れたため `.lake/packages/mathlib` を消して取り直した（gitignore された依存の復旧）。その際 `lake update` が `lake-manifest.json` の `name` を旧プロジェクト名 `Ising2D` から `IntegrableLattice` へ直した（**依存の revision は変わっていない**）ので、そのまま取り込んだ。 |
| 5 | — | rank:cycle22 | done | 2026-08-01 | 下記「cycle 22 総括」。**掲げた 4 点はすべて潰れたが、うち 1 点は前提そのものが誤っていた**（$d,e$ は既に決まっていた）。cycle 23 の焦点は 4 点。 |

## cycle 26 step 列（2026-08-02 起こし。cycle 25 総括の「cycle 26 の焦点（案）」6 点をそのまま step にした）

**着手時に前提を一次情報で実測した（cycle 25 の教訓 (a)「step 列の前提が一次情報と食い違う事故が
2 サイクル連続」への対処）。実測の結果、6 点すべてが一次情報と一致した。** 実測値:

- 焦点 1（Lean で証明そのものを検算）: 本文は `theorem`/`claim` **24 件すべてが証明を持つ**
  （`verify:proofs`。証明なし 0・宣言 0）。`lean/IntegrableLattice/` は **23 モジュール**。
  **worktree に mathlib（gitignore）が無い**ので復旧が要る（cycle 25 の教訓 (d) と同じ状況）。
- 焦点 2（腐った参照 17 件）: `verify:refs` が **実在しない参照 41 件・免除 40 件**、うち
  型 `outOfScope`＝**本当に腐っている 17 件**。内訳を実測: `locales/en/` 5 件・`README.md` 1 件・
  `docs/architecture.md` 4 件・`docs/schemas.md` 1 件・`docs/paper001-en-glossary.md` 3 件・
  `docs/tasks/auto-loop-runbook.md` 3 件。**本文（`content/`）には 1 件も無い。**
- 焦点 3（持ち越し 2 件）: `cycle22_T3_coefficients_d_e.md` 注 3.1 に
  「**この帰結は Step L では確認していない**」が実在（$T_\mathrm{def}=0$ の 108 本で $(1.1)$ が $n=0$ から
  成り立つか）。`cycle21_T3_general_closed_form.md` §6.3 に「**$n=1$ から完全に一致する**」が実在
  （cycle 22 step 4 が「定理の保証範囲外」と指摘した箇所）。
- 焦点 4（転記検査の弱点）: `verify:transcription` が **照合対象が 0 件だったブロック 5 件**
  （`paper_023_definition_massieu`, `paper_045_theorem_lte`, `paper_054_remark_limits`,
  `paper_072_remark_qp_free`, `paper_082_remark_formalization`）と
  **機械検証できない免除 14 件（型「report の位置づけの言葉」）** を出力。件数が一致。
- 焦点 5（再発する誤りを検査にする）: `package.json` の `check` は **15 段**。
  英語ロケールの数式ノードをまたぐ強調も `field_simp` 後の不要な `ring` も、**落とす段が無い**。
- 焦点 6（命題 G′ の仮定）: `content/005b_theta_infinity.ts` の **statement（125–135 行）に
  $\theta^*-m_1<\ell-1$ が無く、proof（529 行）にだけある**。「この仮定なしには次の等式は
  述べられない」と proof 自身が書いている。

**担当を分ける（衝突回避）。step は上から順に 1 つずつ実行し、各 step で 点検 → 状態更新 → main push を回す**:
- `outputs/reports/` と `sagemath/` を触ってよいのは **step 1 だけ**。
- `docs/`・`README.md`・`locales/en/` の非 content を触ってよいのは **step 2 だけ**
  （併せて `tools/reference-rot-allowances.ts` から免除を消すのも step 2）。
- `structured-latex/tools/` の**検査道具本体**と `package.json` の検査段を触ってよいのは
  **step 3・step 4 だけ**（step 3 が新検査、step 4 が転記検査。触るファイルは重ならない）。
- **本文**（`structured-latex/content/` と `structured-latex/locales/en/content/`）を触ってよいのは
  **step 5 だけ**。
- `lean/` を触ってよいのは **step 6 だけ**（本文が確定した step 5 の後に起こす）。

**申し送り（cycle 25 総括より。読むだけでなく設計に反映する）**:
- **「記録を読む」では再発が止まらないことが 3 サイクルで確定している**（英語ロケールの強調・
  `field_simp` 後の `ring`）。step 3 はこれを**検査**にするのが仕事であって、注意書きを増やす仕事ではない。
- **「プロセスが止まっている」はプロセス表と生成物の増加を見てから言う。** 生存確認と進捗確認を分ける。
  `pkill`/`killall` を使わない。稼働中のビルドを強制解除しない。
- **パイプの後ろで `$?` を取らない**（`${PIPESTATUS[0]}`）。「エラーが出なかったこと」を成功の根拠にしない。
- 1 本のスクリプトの壁時計上限は 20 分以内。負荷判断は `uptime` でなく `top` の CPU idle。

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T3 Pure | close_carryover_verifications | done | 2026-08-02 | `outputs/reports/cycle26_T3_carryover_verifications.md` / `sagemath/check/cycle26_T3_carryover_verifications/`（FAIL 0・打ち切り 0・419.0 秒）。**3 サイクル持ち越しの 2 件を両方とも閉じた。** **持ち越し (i)（cycle22 注 3.1）**: $T_\mathrm{def}=0$ の 108 本で $(1.1)$ が $n=0$ で成り立つことを確認（191 組で同値の破れ 0 件）。**実際にはもっと強く、108 本すべてで $\delta_M$ が全て $0$ ＝ 全ての $n\ge0$ で成り立っていた**（「総和だけ $0$」の塔は 0 本）。さらに**定理 D2 のレベルごとの判定を Matrix–Tree の塔の値と 860 件突き合わせ、食い違い 0**。内訳が重要で、**判定「一致しない」かつ実測も不一致が 139 件（16%）**あり、**判定が空振りでないことが数で出た**。従来の照合（cycle 22 Step E）は $n\ge n_0$ に限っていたので、**$n=0$ と $n<n_0$ はこれが初めての突き合わせ**である。**定理 D2 の証明の但し書き「実在の塔で $\delta_M$ の符号が混ざる例は確認していない」も半分解消**——**混ざる塔は 47 本実在した**（例: $\ell=2$ `BQ3 (1,0),(1,0),(0,1)` で $\delta=(-1,2,0)$）。**ただし $T_\mathrm{def}=0$ のものは 0 本**＝証明が構成した反例の配置（総和 $0$・部分和 $\ne0$）はこの母集団では実現していない。**持ち越し (ii)（cycle21 §6.3）**: $\ell=2$ トーラスは $T_\mathrm{def}=3\ne0$・$\delta=(3,0,0)$ で、**$(1.1)$ の成立開始レベルはちょうど $n=1$**（機械が実測から決める形にした）。**「$n=1$ から完全に一致する」は正しく、しかも定理 D2 がその開始レベルをちょうど言い当てている。** cycle 22 step 4 の「定理の保証範囲外」という指摘は**当時は妥当**で、**説明を与えたのが cycle 22 定理 D2、それを実測したのが本 step**である。以後この記述は保証範囲外ではない。**$\mathbb{R}$ へは一度も脱出しない**（整数行列式・有理数・$\ell$ 進付値のみ。浮動小数点 0 箇所）。**自分の誤りを 3 件記録**（最重は **$(1.1)$ の $a$ を $1$ と書いたこと**——§6.3 の $\alpha=1$ との取り違え。印字された閉形式に $2^{2n}$ の項が無いので $a=0$ である。初回実行が FAIL 2 件で終わり、**どちらも私の期待が誤りで理論が正しかった**。是正は検証を緩めず期待を原典へ合わせる方向で行った。**2 件とも「確かめる前に期待を書いた」型で、cycle 25 step 2 が最重の誤りに挙げた形の 1 サイクルでの再発**である）。**限界を明示**: 母集団の外は見ていない／レベルは $\ell=2$ で $n\le4$・$\ell=3$ で $n\le3$／これは証明ではない。本 step は本文を触らないので、検証ディレクトリは `verify-check-linkage.ts` に孤立として出る（**参照を張るのは step 5 の担当**）。 |
| 2 | 運用 | fix_rotten_refs_outside_content | done | 2026-08-02 | `outputs/reports/cycle26_ops_fix_rotten_refs_outside_content.md`。**「本当に腐っている」17 件 → 0 件。** 実在しない参照 41 → **24 件**、免除 40 → **25 件**。**改名・移設で腐った 11 件は現在の実ファイルへ向け直した**（`math-exceptions.ts`→`structure-exceptions.ts`、`verify-ja-en-correspondence.ts`→`verify-localization.ts`、glossary の `content/008_prior_art.ts`→`locales/en/content/010_prior_art.ts`、runbook の `.mjs`→`.ts` 等）。**うち 1 件は監査のエラーメッセージの中にあり、違反時に実在しないファイル名を案内していた**（読んだ人が探して見つからない種類の腐り）。**作られなかった設計上のファイル 6 件**（`inputs/queries/`・`operations.md`・`axes.md`・`canonical-papers.md` 等）は、**cycle 0 の再定義より前の設計で一度も作られておらず作る予定も無い**ことを実測（`inputs/seeds/` の現存は 2 ファイルだけ）したうえで、**現在形の参照をやめ「当初こう置く設計だったが作っていない」という過去形の記述へ書き換え**、`historical` 型（目印を機械検証する）へ判定ごと変えた。**黙らせたのではなく判定を変えた。** ついでに runbook の `content/*.mjs` / `notes/*.mjs` も `.ts` へ直した（検査 R は glob を検出しないので挙がっていなかったが、runbook 自身が「`.mjs` は使わない」と書いている）。**設計どおりに働いた仕掛けが 2 つある**: (1) `outOfScope` は「直れば宣言が余って赤くなる」型として作られており、実際 17 件を直した時点で登録を消さねばならなくなった。(2) **検出テストが生きた表から `outOfScope` の免除を拾っていたため、表が空になった瞬間に例外で落ちた**——**cycle 25 step 4b が `PROOF_DEBTS` で踏んだのと同じ形**で、同じ直し方（基準を固定値へ移す）で直した。**腐らせ方は 1 つも減らしていない**（検出テストは 24/24 のまま）。**自分の誤りを 3 件記録**（最重は**免除を消す正規表現が 40 件すべてを消したこと**——非貪欲の繰り返しがオブジェクト境界を越えるのを確かめずに全体へ掛けた。**破壊的な一括置換を少数で試さずに走らせた**）。 |
| 3 | 運用 | guard_recurring_mistakes | done | 2026-08-02 | `outputs/reports/cycle26_ops_guard_recurring_mistakes.md` / `structured-latex/tools/{emphasis-model,verify-emphasis,lean-tactic-model,lean-tactic-allowances,verify-lean-tactics,verify-recurrence-detection-test}.ts`。**3 サイクル連続の再発 2 型を検査にした。`npm run check` は 15 段 → 18 段**（新設 3 段は `validate` の直後）。**検査 E（ノードをまたぐ強調）**: **原因を一次情報で確定させた**——`editions.ts` が日本語版を `bold: false`、英語版を `bold: true` と宣言し、`applyBold` が `if (!edition.bold) return value;` で**日本語版では何もしない**。**同じ書き方が日本語で静かに通り英語でだけ落ちる**という非対称が、cycle 25 step 4b の言う「原文で通っている形をそのまま訳すと必ず踏む」の正体である。**落とす条件は生成器と同じにした**（厳しくも緩くもしていない）。変えたのは 2 点——(1) 落ちる段を `verify:no-notes:en` から `validate` 直後へ早めた、(2) **原文側の在庫 298 件を毎回印字する**（違反ではないが「そのまま訳すと落ちる形」の在庫）。走査 9603 件（ja 4607・en 4996）、違反 0 件。**検査 T（`field_simp` の直後の `ring`）**: 一律禁止にはできない——実測 **10 件**あり、**`lake build` が通っている以上その `ring` は必要**（不要なら `No goals to be solved` で落ちる）。そこで**宣言制**にし、既存 10 件を台帳へ根拠つきで登録、**未宣言の対は即座に赤**にした。新しく書いた手は `lake build` を回すより早く止まる。台帳が腐ったら赤くなる（宣言名が無い／対がもう無い／個数が合わない）。**検出の実証 16/16**（再現データは実際に再発した形そのもの。cycle 25 step 3 が落ちた `Q1_b_zero_matches_layer_count` を含む）。**この step が見つけた別件（未修正・記録のみ）: 日本語版の PDF は `**` を素のアスタリスクとして印字している**——`build/document.tex` に **410 箇所**、「（\*\*対数順序群\*\*）」がそのまま組まれる。**50 頁の日本語正本の全体にわたる。** 直すには日本語版も `bold: true` にする必要があり、**本文 298 箇所の書き換えを伴う**（正本 PDF の見た目を変える判断でもある）ので cycle 27 へ送った。**自分の誤りを 3 件記録**（最重は**検査 E を最初「ロケールに依存させない」設計で書き日本語 298 件を違反にしたこと**——生成器より厳しい検査を作れば本文 298 箇所を直すまで check が通らなくなる。**一次情報（`editions.ts` と `applyBold`）を読む前に設計を決めた**のが原因で、**cycle 25 step 2 が最重の誤りに挙げた形の再発**である）。 |
| 4 | 運用 | strengthen_transcription_checks | done | 2026-08-02 | `outputs/reports/cycle26_ops_strengthen_transcription_checks.md` / `structured-latex/tools/{transcription-model,verify-transcription,verify-transcription-detection-test,source-links}.ts`。**弱点は「件数を出しているのに減らない」ことだったので、実際に減らした。** **照合対象が 0 件だったブロック 5 → 0 件**、**型として機械検証できない免除 14 → 8 件（43% 減）**、照合したアトム 181 → **201**・語 186 → **254**。**弱点 1 の直し方**: 台帳の `covers`（cycle 25 まで型の doc に「検査には使わない」と書いてあった）を、**条件文が 1 文も取れなかった passage に限り**照合対象へ回す。台帳が「この範囲は本文のこれに当たる」と宣言している以上、そこのアトムと語は本文にあるはずである。**`checkCoverage` と `checkExemptionGrounds` の両方に同じフォールバックを掛けた**（片方だけだと免除が書けなくなる）。**黙って回さず、回した passage 28 件を毎回印字する。** 新たに挙がった **21 件をすべて本文を読んで判定し**、機械検証できる根拠つきの免除にした（記法の選択 6・言い換え 11・位置づけ 4）。**弱点 2 の直し方**: `positioning` に**閉じた語彙の目印**（`POSITIONING_MARKERS` 15 語。report が自分について語る言い回しだけで構成し数学の語は入れない）を必須にした。**これで任意の数学の文を positioning と名乗って黙らせられなくなった。** 導入直後に**既存 14 件のうち 6 件が目印を持たず赤くなり、読んだところ 6 件とも分類が誤っていた**ので、本文を読んで機械検証できる型へ付け替えた（例: 命題 W の「完全」は本文の「$D$ の係数からの**有限計算で判定できる**」の言い換え、四軸の「本体軸」は本文が序列を主張しない＝本文のほうが弱い）。**検出テストを 12 → 16 件**に増やし、**現存する positioning 8 件がすべて目印を持つことを毎回確認する**。**限界を明示**: `covers` は台帳の書き手の要約であって report 本文より弱い出所である／`positioning` 8 件は依然として人の判定に依存する／免除は 89 → 110 件に増えたが照合対象のほうが大きく増えている。**自分の誤りを 3 件記録**（最重は**フォールバックを `checkCoverage` にだけ入れ `checkExemptionGrounds` に入れ忘れたこと**＝その状態では免除が書けずずっと赤いまま。**2 箇所が同じ文の集合を独立に作っていることを設計時に見ていなかった**。なお **3 件目の誤り（`bodyQuote` を本文で確かめずに書き、隣のブロックの文を指した）は本 step が作った検査自身が捕まえた**）。 |
| 5 | 運用 | state_g_prime_assumption | done | 2026-08-02 | `outputs/reports/cycle26_ops_state_g_prime_assumption.md` / `structured-latex/content/{005b_theta_infinity,010_general_closed_form}.ts` ＋ 英語ロケール同名 2 ファイル。**証明が「この仮定なしには次の等式は述べられない」と自分で書いている等式を、主張は無条件に述べていた。** 着手時の実測: 仮定 $\theta^*-m_1<\ell-1$ は `proof`（529 行）にだけあり `statement`（125–135 行）に無い。**これは注記の不足ではなく主張が偽になりうる欠落**である（`docs/context/証明の書き方.md`「正しさに必要ならそれは注記ではない」）。なお上流の付値公式のより弱い仮定 $\theta^*-m_1<\varphi(\ell^M)$ は**主張に書かれていた**。落ちていたのは、それを全レベルで一様に使うための強い形だけである。**主張へ仮定を入れ（日英同時）**、なぜ 1 条件で足りるか（$\varphi(\ell^M)\ge\ell-1$）と (G′3) の族では自動的に満たされること（$\theta^*=2$・$m_1=+\infty$）も主張の側へ移した。**証明は「主張が置いた仮定を使う」形へ改めた**（証明が仮定を導入する形だと、主張と証明のどちらが仮定を持つのか読者に分からない）。**証明から情報は落としていない。** 併せて **step 1 の検証ディレクトリを命題 U の `verification` へ結びつけた**（孤立 8 → **7 件**）。検証: `npm run check`（18 段・exit 0）／`build:pdf` 日 **50 頁**・英 **64 頁**（未解決参照 0・組めない文字 0・版面外 0・ノート混入 0・参考文献 20 件）／日英の構造照合 違反 0／`verify-check-linkage.ts` exit 0／ブロック 日 48・英 55、証明 24、TODO 0。**cycle 26 step 3 が入れた検査 E が本 step で実際に働いた**（英語版の追記で強調が数式ノードをまたがないように書いた。`validate` の直後で落ちるので `.tex` 生成前に分かる）。**限界**: 主張へ移しただけで、この仮定が必要十分かは検討していない（原本が置く形をそのまま運んだ）。 |
| 6 | 運用 | lean_cycle26_proofs | done | 2026-08-02 | `outputs/reports/cycle26_ops_lean_proof_steps.md` / `lean/IntegrableLattice/Cycle26ProofSteps.lean`（9 定理）＋ 本文の訂正（日英）。**11 サイクル目。対象を主張から証明そのものへ移した最初の回で、主張の規約の欠落を 1 件検出した。** **検出**: 命題 G′ の**証明**は「そのような $m$ が 1 つも無ければ $m_1=+\infty$ と読む」と規約を明記しているのに、**主張の側にこの規約が無い**。主張は $m_1$ を引き算に 2 回使う（(G′2) の付値公式の仮定と、**本サイクル step 5 が主張へ移した** $\theta^*-m_1<\ell-1$）。**$\min\emptyset=0$ で読むと (G′3) の族（$\theta^*=2$）で仮定が $\ell\ge5$ を要求し、「任意の奇素数で成り立つ」という (G′3) の主張から $\ell=3$ だけが落ちる。** **これは cycle 25 step 1 が定理 G2 $(3.2)$ で見つけたのとまったく同じ形の 2 例目**で、そのときも落ちたのは $\ell=3$ だけだった。**1 つの素数だけが落ちるから長く見過ごされる。** 型に出して（`gprime3_hypothesis_holds` / `junk_reading_excludes_ell_three` / `junk_reading_keeps_five_and_seven`）**主張へ規約を入れ、規約が無いと $\ell=3$ が落ちることまで本文に書いた**（日英同時）。**食い違いが無かった側**: 命題 G′ の証明の主要 6 ステップを形式化していずれも根拠から従った——本文の一行 $\varphi(\ell^M)\ge\ell-1$、**step 5 が主張へ移した 1 条件が全レベルの条件を含意すること**、$\sum\varphi(\ell^M)=\ell^n-1$、**直線の寄与の総和計算そのもの**（分母がレベルごとに相殺する）、(G′2) の割合 $\ell^{1-M}$、**(G′3) の閉形式と 5 係数が恒等式として一致すること**（本文が「すなわち」で繋ぎ計算を書いていない一歩）。`sum_phi_pow_prime` は**素数性が落とせないことも確認**した。**ℝ 脱出**: 本 step の 9 定理は `Real` を 1 つも使わない。`lean/` 全体で `Real.` が出るのは Cycle24/25 の 2 ファイルだけで、**命題 G′ の証明は非可算側を一切通らない**ことが型で確認された。**ビルド**: `lake build` **8680 jobs** exit 0、`check-no-sorry.sh` **336 定理**（cycle 25 は 327）すべて sorryAx 非依存。`npm run check`（18 段）exit 0、PDF 日 50 頁・英 64 頁。mathlib は worktree に無かったので**同一リビジョン `520045a` を別 worktree から複製して復旧**（**プロセスの停止は 1 件も行っていない**）。**本サイクルの新しい検査が実地で働いた**——**検査 E が、私が英語版の訂正で数式ノードをまたぐ強調を書いた瞬間に落とした**（3 サイクル連続の再発の 4 回目。従来は PDF 生成まで進んで初めて分かった）。**「記録を読んでも止まらない」と「検査にすれば止まる」が同時に実証された。** **自分の誤りを 4 件記録**（上記の強調／**存在しない mathlib の import と補題名を実在を確かめずに書いた**（cycle 22 step 4 の記録の再発）／`sorry` を置いたまま先へ進んだ（最終的に 0 件）／`omega` が閉じると決めつけた）。**限界**: 形式化したのは計算に還元できる 6 ステップだけ（Newton 多面体・$\pi$ 進評価・例外直線の決定は未形式化）／**cycle 25 が運んだ 7 件のうち触ったのは命題 G′ だけ**／**$\min\emptyset$ の規約の欠落が他の命題に残っていないかは全数では見ていない（同型の事故が 2 例目なので全数走査が要る。cycle 27 へ）**。 |
| 7 | — | rank:cycle26 | done | 2026-08-02 | 下記「cycle 26 総括」。掲げた 6 点はすべて潰れた。cycle 27 の焦点は 5 点。 |

## cycle 27 step 列（2026-08-03 起こし。cycle 26 総括の「cycle 27 の焦点（案）」5 点をそのまま step にした）

**着手時に前提を一次情報で実測した（cycle 25 の教訓 (a) への対処。cycle 26 に続き 2 サイクル目）。
実測の結果、5 点のうち 4 点は一次情報と一致し、1 点（焦点 3 の件数）は数え方が違っていた。** 実測値:

- 焦点 1（$\min\emptyset$ の規約の全数走査）: 本文の `\min` / `\max` は **日本語版 129 件**
  （`content/` 14 ファイル中 9 ファイル。最多は `010_general_closed_form.ts` 37 件、
  `009c_drop_assumption_b_star.ts` 34 件）、**英語ロケール 130 件**。全数走査はまだ誰も行っていない。
- 焦点 2（未検算の 6 件）: cycle 25 が本文へ運んだ 7 件は命題 G′・G″・J・K・R（step 4a）と
  命題 M・U（step 4b）。cycle 26 が Lean で見たのは命題 G′ だけ（`Cycle26ProofSteps.lean`）。
  **残り 6 件は未検算**。`lean/IntegrableLattice/` は 24 モジュール。
  **worktree に mathlib（gitignore）が無い**ので復旧が要る（cycle 25・26 と同じ状況）。
- 焦点 3（日本語版 PDF の素のアスタリスク）: **「410 箇所」は行数だった。**
  `build/document.tex` で `**` を含む行が **410 行**、`**` の出現は（コメント行を除いて）**1220 個**
  ＝**強調 610 対**。英語版 `build/en/document.tex` の `**` は **0 個**で、代わりに
  `\textbf` が **640 個**（日本語版は 8 個）。**現象そのものは報告どおり実在する。**
  なお総括が「本文 298 箇所」と書いた在庫は、いま測ると **302 件**（cycle 26 step 5・6 の加筆で増えた）。
  これは「ノードをまたいでいる強調」の件数であって、書き換え対象の総数（610 対）とは別の数である。
- 焦点 4（転記検査に残る弱点）: `verify:transcription` が **機械検証できない免除 8 件**
  （型「report の位置づけの言葉」）と、**`covers` へ回した passage 28 件**を出力。件数が一致。
- 焦点 5（`field_simp` 直後の `ring` の台帳）: `tools/lean-tactic-allowances.ts` に **10 件**
  （4 ファイル: `Cycle24Corrections` 2・`Cycle25Corrections` 1・`GeneralTowerClosedForm` 5・`PropT` 2）。
  **10 件すべての根拠が同一文字列**（「`lake build` が通っているから必要」）で、実測ではない。

**担当を分ける（衝突回避）。step は上から順に 1 つずつ実行し、各 step で 点検 → 状態更新 → main push を回す**:
- `structured-latex/tools/` の**検査道具**を触ってよいのは **step 1（$\min$ の走査）と step 4（転記検査）だけ**。
  触るファイルは重ならない。`tools/lean-tactic-allowances.ts` は **step 5 だけ**。
- **本文**（`structured-latex/content/` と `structured-latex/locales/en/content/`）を触ってよいのは
  **step 1 と step 2 だけ**（step 1 が規約の欠落の補い、step 2 が Lean 検算で出た訂正）。
- `lean/` を触ってよいのは **step 2 と step 5 だけ**（step 5 は本文が確定した後に起こす）。
- **step 3 は `outputs/reports/` にしか書かない。本文の強調を 1 箇所も書き換えない**（下記）。

**申し送り（cycle 26 総括より。読むだけでなく設計に反映する）**:
- **「記録を読む」では再発が止まらない。「検査にすれば止まる」は cycle 26 で同一サイクル内に実証された。**
  焦点 1 は注意書きを増やす仕事ではなく、**機械で洗う**仕事である。
- **一次情報を見る前に設計を決めない**（cycle 25・26 で通算 4 件再発）。検査を作るなら
  先に生成器・既存の型定義を読む。
- **「プロセスが止まっている」はプロセス表と生成物の増加を見てから言う。** 生存確認と進捗確認を分ける。
  `pkill`/`killall` を使わない。稼働中のビルドを強制解除しない。
- **パイプの後ろで `$?` を取らない**（`${PIPESTATUS[0]}`）。「エラーが出なかったこと」を成功の根拠にしない。

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | 運用 | scan_min_empty_conventions | done | 2026-08-03 | `outputs/reports/cycle27_ops_scan_min_empty_conventions.md` / `structured-latex/tools/{extremum-model,extremum-allowances,verify-extremum,verify-extremum-detection-test}.ts`（新設）＋ 本文 5 ファイルと英語ロケール同名 5 ファイル。**全数走査で規約の欠落を 4 件見つけた。同型の事故は 2 例目ではなく 6 例目だった。** 着手時の実測: 日 129 出現・英 130 出現。形で分けると判断が要るのは**集合の上 15・添字族の上 27 = 42 指紋（44 出現）**で、残り（記号の名前の一部 46・2 引数 31・言及 9・規約そのもの 1）は判断が要らない。**42 出現を 1 つずつ本文と原本で読んだ。** **最も射程が広い 1 件: 命題 G の (G1′) のずれ指数 $\delta$。** 原本（cycle 17 report の命題 A $(A.2)$）は「$d<k$ の項が無ければ $\delta:=+\infty$」と**規約を明記していた**のに、本文へ運ぶときに落ちていた。**空になるのは例外ではなく一般の場合である**——実質の範囲は $k_{\min}\le d<k$ で、これが空になるのは $k=k_{\min}$、すなわち最低次部分が $\ell$ で割れない一般の塔であり、**原本の検証例（$k_{\min}=2$ の 11 例、$k=2$ の 5 例）はすべてこの場合に入る**。$\min\emptyset=0$ と読むと $\delta=-k<0$ で**十分条件が成り立つべき当の場合で成り立たなくなる**。既知の 2 件が $\ell=3$ だけを落としたのとは射程が違う。**2 件目: 消滅深度 $\theta$ の $\infty$ 規約**（命題 G (G6) と命題 J）。本文は $S_\infty=\{P:\theta(P)=\infty\}$ でこの読みを**実際に使っている**のに規約が無かった。$\min\emptyset=0$ と読むと (G6) の仮定「全ての $P$ で $\theta(P)\le\ell$」が**偽から真へ反転**し、仮定を満たさない塔へ結論を適用してしまう。**3 件目: $S_\infty$ 上の $\max$**（命題 K の $r_0$、命題 M の $r^\sharp$、命題 U の (U6)）。$S_\infty=\emptyset$ は命題 K 自身が (K6) で $b=0$（**型 II**）と名指ししている場合であり、$|S_\infty|=1$ では対が無いので命題 K の前者だけが空になる。**4 件目: 命題 W の $e_k=\min\{m:g_m\ge k\}$** は空でない理由が本文のどこにも無く、近くにあるのは逆向きに読める一文だけだった（$S^{\tau}\equiv I\pmod p$ から $g_m\ge m+1$ を導く初等的な議論を入れた）。**検査にした**（`npm run check` は 18 段 → **20 段**）。空になりうるかは機械で判定できないので 2 段に分け、**形の分類は機械が、判断は台帳が**持つ。**未登録の出現は即座に赤**で、根拠 4 種のうち目印を持つ 3 種（25 件）は目印の実在を毎回確かめる。**機械検証できないのは「構成から空でない」17 件**で、件数を毎回印字する。**検出の実証 16/16**（再現データは実際に落ちていた形そのもの。分類の側と台帳の側の両方）。**設計どおり赤くなった副作用**: 本文へ「最小」「仮定」の語が入って転記検査の免除 2 件が失効（110 → **108 件**）、その 1 件を引いていた再現データが例外で落ちた（**cycle 25 step 4b・cycle 26 step 2 と同じ形**、同じ直し方）。日英の構造照合も 4 ブロックで落ちた（数式の並びが一致しないため）。検証: `npm run check`（20 段・exit 0）／`build:pdf` 日 **51 頁**・英 **64 頁**／`verify-check-linkage.ts` exit 0。**自分の誤りを 4 件記録**（最重は**一次情報を見る前に設計を決めかけた**——$\varepsilon_d$ の定義を入れるとき原本の $c_{pq}$ を本文の (G6) が別の意味で使う $c_{pq}$ と同じ記号のまま書きかけた。**cycle 25 step 2 が最重に挙げ cycle 26 で 3 件再発した形の 4 件目**）。**限界**: 「構成から空でない」17 件の判断が誤っていれば検査は静かなまま通る／直した規約が正しいことは本 step では Lean で検算していない（命題 K・M・U は step 2 の対象）。 |
| 2 | 運用 | lean_cycle25_remaining_six | done | 2026-08-03 | `outputs/reports/cycle27_ops_lean_remaining_six.md` / `lean/IntegrableLattice/Cycle27ProofSteps.lean`（**21 定理**）＋ 本文 6 ファイルと英語ロケール同名 6 ファイルへの `lean` 紐づけ（**本文の文言は 1 文字も変えていない**）。**12 サイクル目。cycle 25 が運んだ 7 件のうち残り 6 件（命題 G″・J・K・R・M・U）を検算し、加えて本サイクル step 1 が命題 W へ入れた議論も検算した。** **発見は 1 件で、既存の形式化の側にあった**——step 1 が入れた持ち上げ（$p\mid x-1\Rightarrow p^{m+1}\mid x^{p^m}-1$）と**同じ主張が `PropC.lean` に既にあり、しかも $p$ が素数という仮定つきだった**。向こうは二項展開を取り $0<m<p$ で $p\mid\binom pm$ を使うので素数性が要るが、**等比の因数分解を取れば素数性は 1 度も要らない**（$y^p-1=p(y-1)+(y-1)^2d$）。**仮定は主張が要求したものではなく道具立てが要求したものである。** 必要十分版の要件 4 に従い、既存の形が本ファイルの形の特殊化として導けることを明示した（`w_lifting_pow_specializes`）。命題 C は $p$ 進の文脈で素数しか扱わないので主張の誤りではなく、**記録に留めた**。**食い違いが無かった側**: 6 命題とも形式化した範囲で本文と一致。**(G″1) の一歩は $\mathbb{F}_2$ の特殊性**（「付値がちょうど $k$ の 2 元の和は付値 $\ge k+1$」は奇の $\ell$ では成り立たない）で、奇の余因子の言葉で書いたのでその一歩が型に出た。**(R2) は mathlib の行列の可逆性へ委ねずに済んだ**——人手証明が実際に使う事実は「$c<s$ なら $\binom cs=0$」と「$\binom ss=1$」の 2 つだけで、$\lambda$ の台の最大値を取れば行列を経由しない。**step 1 の規約が Lean でも整合した**: $\max\emptyset:=0$ の下でも本文の書き換え $\max(1+A,B)=1+\max(A,B-1)$ は成り立ち（$\mathbb{N}$ の切り捨て引き算では $B=0$ でも成立）、$S_\infty=\emptyset$ で 2 通りの書き方はどちらも $r_0=1$ を与える。**付値は `padicValInt` で書かなかった**（mathlib の一般論へ流れて 1 対 1 対応が崩れるため）。検証: `lake build` **8681 jobs** exit 0、`check-no-sorry.sh` **356 定理**（cycle 26 は 336）すべて sorryAx 非依存、**`Real` の使用 0 件**、`npm run check`（20 段）exit 0、PDF 日 51 頁・英 64 頁。**自分の誤りを 4 件記録**（実在を確かめずに mathlib の import と補題名を書いた＝**cycle 26 step 6 の記録の再発**／`omega` が非線形を閉じると決めつけた＝**同じく 2 回目**／$\mathbb{Z}$ で `linear_combination` に除算を書いた／**既存の形式化を探さずに書き始めた**）。**限界**: 形式化したのは計算に還元できるステップだけで、各命題の中核（Newton 多面体・$\pi$ 進評価・例外直線の決定・(U1) の導出そのもの）は未形式化／(K5) は $j>m_u$ 側だけ。 |
| 3 | 運用 | measure_ja_emphasis_only | done | 2026-08-03 | `outputs/reports/cycle27_ops_ja_emphasis_measurement.md`。**計測と提示だけ。本文は 1 文字も変えていない**（`git status` で確認済み。触ったのは本 report と本状態ファイルだけ）。**実測**: 日本語版 `document.tex` の `**` は**コメント行を除いて 1246 個**（**413 行**にわたる）で、これは本文の強調 **623 対**にあたる。英語版は `**` が **0 個**で `\textbf` が **643 個**。cycle 26 が記録した「410 箇所」は**行数**のことで、いま測ると 413 行（その後の加筆で 3 行増えた）。**内訳**: 1 つの地の文ノードで閉じている強調 **466 対**／数式ノードをまたぐ強調 **157 対**（地の文ノード 306 件にまたがる）。**可逆な実験で変化を確かめて元に戻した**: 日本語版を `bold: true` にすると `verify:emphasis` が**違反 306 件**で落ち、生成器が「対応の取れない `**` が地の文にある」で停止して **PDF が作れない**。切り替えるには**本文の 157 対を数式の前後で分けて書き直す**必要がある。**頁数の変化は実測できていない**（157 対を直すまで PDF が作れないため）。**管理役へ上げた 1 点**: 正本 PDF の見た目を変えるかどうか。形は 3 つ——**太字にする**（157 対を書き直す。623 箇所が太字になり英語版と同じ見た目）／**アスタリスクを落とす**（書き直し不要。生成器に「変換せず落とす」動作を足すだけ。ただし**強調という情報そのものを失う**）／**現状のまま**（51 頁の全体にアスタリスクが出続ける）。何を正本 PDF に求めるかの判断であり一次情報からは決まらない。**英語版（投稿稿）はこの問題を持たないので投稿には影響しない。** |
| 4 | 運用 | transcription_covers_provenance | done | 2026-08-03 | `outputs/reports/cycle27_ops_transcription_covers_anchor.md` / `structured-latex/tools/{transcription-model,verify-transcription-detection-test,source-links}.ts`（**本文は 1 文字も変えていない**）。**`covers` を両端で固定した。** cycle 26 step 4 が入れた「条件文が 0 文の passage は台帳の `covers` を照合対象へ回す」仕組みは、`covers` が**台帳の書き手が書いた文**であるため「本文に在る語を `covers` へ書けば通る」状態を残していた（report 側が固定されていない）。**`covers` から出た数式アトムが report 本文にも現れることを要求**し、`covers` を「report と本文を橋渡しする宣言」にした（どちらか片方が動けば落ちる）。**錨を打つのは数式アトムだけ**——地の文まで要求する形も実際に走らせたが**未確認 30 件以上**が「構造」「限界」「明記」のような要約語で埋まり検査にならなかった（測ったうえで絞った）。**範囲の不備を 3 件見つけて直した**: 命題 W の passage は範囲が 1 行しかなく `covers` が挙げる $w^*$ は反例の行にあった／極限の注記も 1 行しかなく $m_0$ は原論文の Definition 1.1 にあった／非対称性の注記は **report が $\mu_p$ と書いているのに `covers` が添字を落としていた**（直した結果、本文が同じ量を添字なしで書いていることが見え、`notation` の免除として登録した。免除 108 → **109 件**だが**増えた 1 件は機械検証できる型**）。**positioning の 8 件は 1 件ずつ読んだが、いずれも実際に位置づけの語で型の付け替えでは減らせなかった**（cycle 26 が付け替え可能なものを付け替え済み）。そこで**件数ではなく型を強くした**——**positioning は数式アトムを免除できない**ようにした（自己言及の文に含まれる数式を positioning と名乗って黙らせる余地が残っていた）。**検出の実証 16 → 19 件**。検証: `npm run check`（20 段）exit 0、`verify:transcription` 違反 0 件（照合対象 0 件のブロック 0 件・`covers` へ回した passage 28 件は変わらず）、PDF 日 51 頁・英 64 頁。**限界**: 機械検証できない免除は **8 件のまま減っていない**（減らせなかった理由は付け替え可能なものが残っていなかったこと。できたのは数式に使えないようにしたことだけ）／`covers` の錨は数式にしか打っていない／`covers` へ回った 28 件は減らしていない（減らすには report を検査に合わせて書き換えることになるので採らなかった）。 |
| 4b | ユーザー判断の反映 | remove_emphasis_and_authoring_leaks | done | 2026-08-03 | `outputs/reports/cycle27_ops_reader_facing_text.md` / 本文 30 ファイル（日英）＋ `structured-latex/tools/{emphasis-model,verify-emphasis,authoring-leak-model,verify-authoring-leak,verify-authoring-leak-detection-test,verify-recurrence-detection-test,build-latex,editions,source-links,transcription-fixtures}.ts` ＋ `locales/en/{frontmatter,structure-exceptions}.ts` ＋ `package.json`（検査段 20 → **22 段**）。**step 3 で管理役へ上げた判断点にユーザーの回答が出たので、同じサイクル内で反映した。回答は「太字を使うのではなく、強調指定そのものを本文から削除する。今後も使わない。再発は検査で止める」。** **強調指定を全部落とした**——日本語版 1246 個・英語版 1286 個・英語版の要旨 2 個、**合計 2534 個の `**` を除去**（強調 1267 対）。数式（`String.raw`）とコメントには触れていないので**数学の内容は 1 文字も変えていない**。**検査 E の意味を変えた**: 「ノードをまたぐ強調を落とす」から「**本文に強調指定を書かない**」へ。ロケールに依存しない判定になり、`editions.ts` の `bold` フラグは不要になったので削除した。**生成器も自分で落とす**ようにした（検査を迂回して生成だけ走らせてもアスタリスクは出ない）。**日本語版 PDF から素のアスタリスクが消えた**（51 頁 → **50 頁**。英語版は 64 頁で不変）。**併せてユーザーの新しい指摘（執筆指示の混入）にも着手した**——「本論文の位置づけ（最初に明示する）」のような**書き手向けの指示が読者の読む題・本文として出力されていた**。走査して**日本語版 10 箇所・英語版 7 箇所**を除去し、さらに**読者が開けないリポジトリ内部の資料への参照 5 箇所**（`根拠レポート outputs/reports/...`）と**作業ツリーのサイクル番号 2 箇所**も本文から落とした。**新しい検査 W（執筆指示の混入）を作った**——作業ツリー固有の語（cycle 番号・step 番号・TODO 等）と書き手への指示の括弧を、**見出しと題も含めて**落とす。**検出の実証 13/13**（再現データはユーザーが指摘した当の形）。**設計どおり赤くなった副作用**: 転記検査の免除の `bodyQuote` 38 個が本文の `**` を引用していて失効（除去）／再現データ 1 件が消した文を指していた（更新）／日本語版から内部パスが消えたことで**日英対応の免除 4 件が「登録が古い」で赤くなった**（削除。骨格の規則 49 → **45 件**）。検証: `npm run check`（**22 段**）exit 0、`build:pdf` 日 **50 頁**・英 64 頁、日本語版 `document.tex` の印字されるアスタリスク **0 個**。**限界**: 検査 W が落とせるのは閉じた語彙に当たる形だけで、「読者にとって意味があるか」は機械で判定できない。 |
| 4c | ユーザー判断の反映 | fix_definition_order_and_titles | done | 2026-08-03 | `outputs/reports/cycle27_ops_reader_facing_text.md`（step 4b と合わせた 1 本の report）/ `structured-latex/tools/{definition-order-model,definition-order-terms,verify-definition-order,verify-definition-order-detection-test}.ts`（新設）＋ 本文（日英の序論・設定の見出しと位置づけ）＋ 英語版の読者案内の移設 ＋ `docs/paper001-en-glossary.md`。`npm run check` は 22 → **24 段**。**ユーザーが生成後の PDF を読んで出した指摘「序論の第 1 章から Λ が定義されないまま使われていて読みづらい。定義の登場順序が依存関係のトポロジカル順序を厳密に保つこと。見出しにも同じ規則を適用すること」への対応。** 着手時の実測で指摘のとおりだった——**整数スペクトル曲線と決定可能は第 1 章の見出し（0 番目のブロック）で使われ、定義は 5 番目と 2 番目**／$\Lambda$ は 1 番目（位置づけ）で使われ定義は 2 番目／Massieu 自由エントロピーは 1 番目で使われ定義は 7 番目。**「後で定義する」と断る形は要求を満たさないので、3 通りで直した**: (1) **見出しからその章で定義する語を落とした**（「序論 — 整数スペクトル曲線の二素点と、Λ 側の決定可能性」→「序論」、「設定 — 整数スペクトル曲線と周期点数」→「設定」。日英とも）、(2) **位置づけのブロックを定義済みの語だけで書き直した**（「整数スペクトル曲線」「Mahler 測度」「Massieu 自由エントロピー」「決定可能」を、まだ定義していない名前を使わない言い方へ。**主張の内容は同じ**）、(3) **英語版だけにある読者案内を第 1 章末尾から第 3 章の後へ移した**（案内が第 2–3 章で定義する語を使うため。案内の中の「消滅深度」も語を使わない言い方へ）。**検査 O（定義の登場順序）を作った**——本論文が自分で定義する語（日英とも 9 語）について、初出が定義より前でないこと（**見出しを含む**）と、定義そのものが依存関係のトポロジカル順序に並んでいることを見る。**検出の実証 8/8**（再現データはユーザーが指摘した当の並び）。**副作用**: 読者案内の改名で用語集の参照 2 件が腐り、腐ったツール参照の検査が捕まえた（直した）。検証: `npm run check`（**24 段**）exit 0、日英とも検査 O 違反 0 件、`build:pdf` 日 **50 頁**・英 64 頁、`verify:localization` 違反 0 件。**限界**: **追跡するのは台帳の 9 語だけ**で、本論文が定義しない標準的な語彙（素点・Newton 多角形・Lehmer 問題）は対象外。どこまでを標準とみなすかは人の判断であり、**台帳の網羅性がこの検査の強さの上限**（この検査自身は検証できない）。 |
| 5 | 運用 | back_lean_tactic_ledger | done | 2026-08-03 | `outputs/reports/cycle27_ops_back_lean_tactic_ledger.md` / `structured-latex/tools/lean-tactic-allowances.ts`（根拠の文言のみ。**`lean/` の中身は 1 バイトも変えていない**）。**10 件を 1 つずつ、その `ring` だけを外してビルドした。10/10 件が落ちた**（対象モジュールだけを `lake build` し、毎回 `git checkout` で復元。測定後の `git status` で `lean/` に差分が無いことを確認した）。**落ち方は 10 件とも `unsolved goals`** で、`field_simp` のあとに目標が残り `ring` がそれを閉じていることを直接示している——cycle 26 の根拠は「不要なら `No goals to be solved` で落ちるはず」という**逆向きの推論**だったので、実測はその反対側から裏を取ったことになる。台帳の根拠の文言を推論から実測へ書き換えた。検証: `lake build` 8681 jobs exit 0、`check-no-sorry.sh` 356 定理すべて sorryAx 非依存、`verify:lean-tactics` 違反 0 件、`npm run check`（24 段）exit 0。**限界**: 測ったのは「消すと落ちる」ことだけで、その位置に `ring` があるのが最良かは測っていない／**1 回きりの測定**であり、台帳は「対が実在すること」は毎回確かめるが「今も必要であること」は測り直さない（mathlib が更新されれば根拠は静かに古くなる）。 |
| 7 | ユーザー方針の反映 | formalization_coverage_metric | done | 2026-08-03 | `outputs/reports/cycle27_ops_formalization_coverage.md` / `structured-latex/tools/{formalization-coverage,verify-formalization-coverage}.ts`（新設）＋ 本文（形式検証の到達点。日英）＋ `lean/README.md` ＋ `MEMORY.md` ＋ 本ファイル。`npm run check` は 24 → **25 段**。**ユーザー方針「論文の主張を全数 Lean 形式化することを目標とする」を正本へ記録し、現在の被覆を実測して毎サイクルの指標にした。** 実測: 主張（`theorem`/`claim`）**24 件**のうち **完了 5・部分的 14・未着手 5**、**全数まで残り 19 件**。**未着手 5 件のうち mathlib の欠落が理由なのは 3 件だけ**（命題 LSW と双対命題 D は多変数の Mahler 測度、命題 G は matrix-tree 定理）で、**残る 2 件（命題 W*・命題 F）はこちらの未着手**なので着手できる。**当初の判断を実測で訂正した**——台帳に「mathlib には Mahler 測度そのものが無い」と書きかけたが、3 段の引き方で実際に引いたら**在った**（連結語 3 件・語幹 5 件・ファイル名 3 件／8264 ファイル走査）。**欠けているのは多変数版**で、1 変数 $\mathbb{C}[X]$ と $\mathbb{Z}[X]$ の Mahler 測度は在り、**どちらも `MvPolynomial` を 1 度も使っていない**。「難しそう」を理由にしない規律は「無さそう」を理由にしないことも含む。**検査 F** は未形式化の件数と一件ずつの残り／理由を毎回印字し、(1) 主張が 1 つ残らず台帳にあること (2) 宣言が本文に実在すること (3) 完了・部分的は Lean の定理名を持つこと (4) 未着手は持たないこと (5) **宣言された定理名が `lean/` に実在すること**を確かめる。(5) を入れる過程で**紐づけが無いのに実際は形式化されていた主張を 3 件検出**（周期点数の終結式・命題 C′・命題 Q）し、紐づけを足した（16 → **19 件**、宣言 97 件すべて実在）。**本文は現在の被覆を数で述べ、全数形式化が目標である旨を書いた**（日英）。全数が達成されるまで「全主張を形式化した」とは書かない。検証: `npm run check`（**25 段**）exit 0、`build:pdf` 日 50 頁・英 64 頁。**限界**: 「完了」が本当に完了かは機械で確かめられない（人の判断）／**本文に書いた数と台帳の数が一致することは検査していない**（形式化が進めば本文が古くなる。cycle 28 へ送った）／命題 W* の「まだ調べていない」は調べれば変わりうる判定である。 |
| 6 | — | rank:cycle27 | done | 2026-08-03 | 下記「cycle 27 総括」。掲げた 5 点はすべて潰れ、さらに**サイクルの途中でユーザーから 2 つの判断・指摘が入り、同じサイクル内で反映した**（step 4b・4c）。cycle 28 の焦点は 5 点。 |

## cycle 29 step 列（2026-08-04 起こし。cycle 28 総括の「cycle 29 の焦点（案）」6 点をそのまま step にした）

**着手時に前提を一次情報で実測した（cycle 26・27・28 に続き 4 サイクル目）。実測の結果、6 点すべてが
一次情報と一致した（前提の食い違いは 0 件）。** 実測値（すべて本サイクル着手時の実行出力）:

- 焦点 0（全数形式化）: 検査 F の実出力で **主張 24 件 / 完了 5・部分的 16・未着手 3 / 残り 19 件**、
  `lean/` の宣言 **409 件**。**未着手 3 件は命題 LSW・双対命題 D・命題 G で、3 件とも理由は mathlib の欠落**
  （前 2 者は多変数の Mahler 測度、命題 G は matrix-tree 定理）。こちら側の未着手は無い。
  **仕分けが未実施であることも実測した**——`outputs/reports/` の全 report を走査して
  「素材が無い」の語を含むものが 0 件であり、部分的 16 件を素材／配線で分けた記録はどこにも無い。
- 焦点 1（双対命題 D の $p$ 素点側）: 台帳の理由欄が
  「$p$ 素点側だけを切り出して形式化する形にできるかは未検討」と明記している（実出力で確認）。
- 焦点 2（同じ壁に帰着する 2 件）: 台帳の命題 W* の理由欄が残りを「双対の段」と名指しし、
  検査 M の実出力で**裏が取れていない 4 件がすべて `paper_046_theorem_wstar_different`** であることを確認
  （裏取り 13/17）。**両者が同じ配線の欠落に帰着するという読みは一次情報と一致する。**
- 焦点 3（検査 O の台帳）: 実出力で **日 21 語・英 20 語**、違反 0 件、走査対象は ja 49 ブロック・en 56 ブロック。
- 焦点 4（検査 L）: 実出力で 走査 ja 段落 473・en 段落 497、違反 0 件。
  判定は「箇条書きの直前・46 文字以下・文末が句読点でない」の積であり、**形が 1 つに限られている。**
- 焦点 5（本文の被覆の数値の照合）: `verify-formalization-coverage.ts` を読み、
  照合が**地の文だけを連結してから `includes` で部分文字列を見る**実装であることを確認した
  （数式ノードは連結前に落としている）。実出力は「本文が書いている被覆の数値: 2 箇所 / 4 文」。

**担当を分ける（衝突回避）。step は上から順に進め、各 step で 点検 → 状態更新 → main push を回す**:
- `lean/` を触ってよいのは **step 1・2・3 だけ**。この 3 つは同じ入口ファイルと定理数の検査に触るので
  **並行させず順に流す**。
- **本文**（`content/` と `locales/en/content/`）を触ってよいのは **step 1・2・3・4 だけ**
  （形式化の紐づけと被覆の数値、および定義の欠落の補い）。
- `structured-latex/tools/` の**検査道具**は、step 4 が `definition-order-terms.ts`、
  step 5 が `runin-label` 周り、step 6 が `verify-formalization-coverage.ts` と分ける。
  **台帳 `formalization-coverage.ts` を触るのは step 1・2・3 だけ**（step 6 は検査側だけを触る）。

**申し送り（cycle 28 総括より。読むだけでなく設計に反映する）**:
- **実在を確かめずに mathlib の import と補題名を書かない**（cycle 26 step 6 の記録から**3 サイクル連続で再発**）。
- **一次情報を見る前に設計を決めない**（通算 5 件目まで再発）。
- **既存の形式化を探してから書き始める**（cycle 27 step 2・cycle 28 step 5 が同じ形で踏んだ。
  **cycle 28 step 5 では「欠けている」とされたものが実測すると 1 点を除いて main に在った**）。
- **英訳を日本語版と同じ語順で書く**（数式ノードの並びまで骨格照合が見る）。
- **「プロセスが止まっている」はプロセス表と生成物の増加を見てから言う。** `pkill`/`killall` を使わない。
- **一時ファイルはセッションの作業領域へ置く**（cycle 28 で他エージェントと `/tmp` の名前が衝突した）。

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | ユーザー方針の反映 | sort_and_wire_partial | todo | | 部分的 16 件を「素材が無い」と「配線をしていないだけ」へ仕分けし、後者から形式化して**残り 19 件を実際に減らす**。 |
| 2 | ユーザー方針の反映 | carve_out_duality_p_side | todo | | 双対命題 D の $p$ 素点側だけを切り出して形式化できるかを一次情報で確かめる。 |
| 3 | ユーザー方針の反映 | dedekind_wiring | todo | | $A=\mathbb{Z}[x]/(\rho)$ を Dedekind 環として mathlib へ渡す配線。通れば命題 W* の双対の段と検査 M の 4 件が同時に動く。 |
| 4 | 運用 | definition_order_symbol_sweep | todo | | 記号の初出の全数走査で、検査 O の台帳の拾い方の漏れを測る。 |
| 5 | 運用 | runin_label_other_shapes | done | 2026-08-04 | `outputs/reports/cycle29_ops_runin_label_other_shapes.md` / `structured-latex/tools/{runin-label-model,verify-runin-label,verify-runin-label-detection-test}.ts`（**本文は 1 文字も変えていない**）。**判定 1 を許可リストから除外リストへ反転させた**——「直後が箇条書きであること」から「直後が別行立て数式ではないこと」へ。**検査の対象は 54 段落 → 713 段落**（段落の直前 551・ブロックの末尾 108・箇条書きの直前 54）。**設計の前に本文の実データを走査した**: 段落 970 件（日 473・英 497）の直後に実際に現れる種別は 4 つだけで、**表・引用は 0 件なのではなく書けない**（入力言語のノード語彙が閉じており該当種別が存在しない）。**46 文字以下で文末が句読点でない段落は 67 件あり、その全件が別行立て数式の直前だった**（広げた先には 1 件も無い＝偽陽性は増えていない。余裕も実測し、段落の直前の最短は 11 字・末尾の最短は 20 字でどちらも句点で終わる）。**別行立て数式の直前を除外した理由を実測で残した**——切り分け規則の候補 4 つがすべて本文に反例を持つ（体言止めなら見出し→反例 2／ラテン文字終わりなら見出し→8／数式を含まなければ見出し→14／閉じ括弧終わりなら見出し→1）。**検出の実証は本文で 6 件**（日英 × 箇条書きの直前・段落の直前・ブロックの末尾）。cycle 28 step 3 が実際に直した断片（「限界」「各量の帰属」「Limitations」「Countable versus uncountable」）を 1 件ずつ置き、**置くと違反 1 件で終了コード 1・戻すと違反 0 件・本文の未コミット差分が空**であることを 6 件すべてで確認した。**うち 4 件は従来の判定では拾えなかった形である。** **拾えない側も実証した**——同じ断片を別行立て数式の直前へ置くと違反 0 件のまま通る（除外範囲を主張ではなく実測で残すため）。検出テストの再現データを 8 → **14 件**、通ってほしい形を 8 → **17 件**へ増やし、**上の反例をテスト側に置いた**（あとから「体言止めなら見出し」等の規則を足すと赤くなり、なぜ除外しているかが読める）。**毎回の出力に対象・対象外の内訳を印字**する行を足した（判定の対象が黙って痩せたことに気づけるようにするため）。検証: `npm run check`（28 段）exit 0、`build:pdf` 日 **50 頁**・英 **64 頁**（不変）。**自分の誤りを 1 件記録**（出力の文言を直す置換で参照名を 1 箇所だけ差し替え忘れ、未定義の関数を呼んで実行時に落ちた。検査を走らせて気づいた）。**環境の所見**: この worktree には mathlib が無く、検査 R の免除が mathlib のファイル実在に依っているため、`lake exe cache get` を通すまで検査 R と検出テスト G が落ちる（本 step の変更とは無関係）。**限界**: 判定しているのは形であって意図ではない／別行立て数式の直前と箇条書きの項目の中は見ない（**形で切り分けられないことは実測したが、切り分ける道が無いことを示したわけではない**）／46 文字の境目に根拠は無い（直した 8 件が 12 字以下だったことから取った余裕）。 |
| 6 | 運用 | coverage_match_liveness | done | 2026-08-04 | `outputs/reports/cycle29_ops_coverage_match_liveness.md` / `structured-latex/tools/verify-formalization-coverage.ts` ＋ `package.json`（**本文と台帳は 1 文字も変えていない**。検査側だけを直した）。**空振りの道は 1 つではなく 3 つあった**——(a) 照合する箇所・文が 0 件でも静かに緑になる道、(b) **照合する文字列が台帳の数に依っていなくても緑になる道**、(c) 数が数式ノードへ移る道。cycle 28 が限界として書いたのは (c) だけである。**一番危ないのは (b)**——数式化で照合が一致しなくなったときに「数を含まない断片」へ書き換えれば、件数だけ増えて何も固定しない状態が静かに成立する。3 つとも違反にした。**固定されていることの確かめ方**: 台帳の 4 つの数（全数・完了・部分的・未着手）を 1 ずつ動かし、本文に在った文が本文から外れることを数ごとに確認する（外れなければその数は照合で固定されていない）。**現状の出力は日英とも 4/4**。期待件数（ロケールごとに 1 箇所以上・各箇所 1 文以上）を下回れば赤くなり、期待の根拠と実績を毎回印字する。**(c) の設計判断**: 地の文だけを照合する実装は変えず、**その箇所の数式ノードに被覆の数が現れたら赤くする**道を採った（数式の TeX を照合対象へ混ぜると `$24$` のような書き方が通って何を固定しているか曖昧になるため。照合できない形になったことを異常として一箇所で扱う）。**検出の実証は二段**——合成データの検出テスト 8/8（`npm run check` に 1 段追加）と、本文の一時的な書き換え（数を数式ノードにすると違反 3 件・**うち 2 件は従来の実装では出なかった指摘**、照合対象の文を消すと違反 6 件、どちらも戻すと緑、`content/`・`locales/` の diff と `git status` が空）。検証: `npm run check`（**29 段**）exit 0、`build:pdf` 日 **50 頁**・英 **64 頁**（不変）。**自分の誤りを 2 件記録**（固定の判定を最初は「増やした文字列が本文に無いこと」だけで書き、照合すべき文が本文から消えていても「固定されている」と印字した／一時ファイルを `/tmp` へ置いた＝申し送りを読んでいて 1 回踏んだ）。**限界**: **台帳が実態とずれる道は塞いでいない**（形式化が進んだのに台帳を直さなければ、本文と台帳は一致したまま両方が古くなり緑のままである。この文は検査の出力にも印字した）／数式ノードの判定は数字の一致しか見ないので同じ整数が別の理由で出れば誤検出する（誤検出は静かではなく赤い、という判断で採用）。 |
| 7 | — | rank:cycle29 | todo | | 総括。 |

## cycle 28 step 列（2026-08-04 起こし。cycle 27 総括の「cycle 28 の焦点（案）」7 点をそのまま step にした）

**着手時に前提を一次情報で実測した（cycle 26・27 に続き 3 サイクル目）。実測の結果、7 点すべてが
一次情報と一致した（前提の食い違いは 0 件）。** 実測値:

- 焦点 0（全数形式化）: 検査 F の実出力で **主張 24 件 / 完了 5・部分的 14・未着手 5 / 残り 19 件**、
  `lean/` の宣言 383 件。**未着手 5 件のうち mathlib の欠落が理由なのは 3 件**
  （命題 LSW・双対命題 D が多変数の Mahler 測度、命題 G が matrix-tree 定理）。
  **残る 2 件は命題 W*（$w^*$ の代数的閉形式）と命題 F（有限台なら $\lambda$ が計算できる）。**
  ただし台帳が W* に書いている理由は「mathlib に different は在るが本文の経路へ配線されておらず、
  **どの段で詰まるかをまだ一次情報で特定していない。まず調査から要る**」であり、
  「すぐ着手できる」とは着手の前に調査が要らないという意味ではない。
- 焦点 1（検査 O の台帳）: `verify:definition-order` の実出力で **日 9 語・英 9 語**、
  走査対象は ja 48 ブロック・en 55 ブロック、違反 0 件。台帳は `tools/definition-order-terms.ts`。
- 焦点 2（強調を外した箇所の読み直し）: cycle 27 step 4b が落とした強調は 1267 対。
  全対を読み直した記録は無い。
- 焦点 3（検査 M の機械検証できない 17 件）: `verify:extremum` の実出力で
  **判断が要る出現 44 件 / 指紋 42 件 / 台帳 42 件**、根拠の内訳は
  **構成から空でない 17・本文が論じている 8・別ブロックが論じている 1・読み方を書いた 16**。件数が一致。
- 焦点 4（命題の中核が未形式化）: 検査 F の理由欄が命題ごとに残りを名指ししている（実出力で確認）。
- 焦点 5（救済 PR #69）: `gh pr view 69` で **open**、ブランチ `worktree-piped-brewing-kahan`、
  base は `main`。管理役のコメントが「中身は生きている（`eventualPeriod`／`pisanoPeriod` を含む
  ファイルが main に 1 つも無い）」「分岐点が古く 772 ファイル・11 万行超の削除になるので
  **そのままマージしてはいけない。1 コミット分の差分だけを現在の main の上へ移植する**」と記録済み。
- 焦点 6（本文の被覆の数値と台帳）: 本文の数値は `content/007_asymmetry_scope.ts` の
  「形式検証の到達点」1 箇所（「主張 24 件のうち…5 件…14 件…5 件」）。検査は無い。

**担当を分ける（衝突回避）。step は上から順に 1 つずつ実行し、各 step で 点検 → 状態更新 → main push を回す**:
- `lean/` を触ってよいのは **step 1（W*・F の形式化）と step 5（PR #69 の移植）だけ**。
  触るファイルは重ならない（step 1 は新規モジュール、step 5 は `PropCPeriod.lean`）。
- `structured-latex/tools/` の**検査道具**は、step 2 が `definition-order-terms.ts`、
  step 4 が `extremum-allowances.ts`、step 6 が `formalization-coverage` 周りと分ける。
- **本文**（`content/` と `locales/en/content/`）を触ってよいのは **step 2・step 3・step 6 だけ**。

**申し送り（cycle 27 総括より。読むだけでなく設計に反映する）**:
- **一次情報を見る前に設計を決めない**（cycle 25 step 2 の記録から通算 5 件目まで再発している）。
- **実在を確かめずに mathlib の import と補題名を書かない**（cycle 26 step 6 の記録の再発が cycle 27 でも起きた）。
- **`omega` が非線形を閉じると決めつけない**（同上・2 回目）。
- **既存の形式化を探してから書き始める**（cycle 27 step 2 が `PropC.lean` の重複で踏んだ）。
- **「プロセスが止まっている」はプロセス表と生成物の増加を見てから言う。** `pkill`/`killall` を使わない。
- **パイプの後ろで `$?` を取らない**（`${PIPESTATUS[0]}`）。

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | ユーザー方針の反映 | formalize_wstar_and_F | done | 2026-08-04 | `outputs/reports/cycle28_ops_formalize_wstar_and_F.md` / `lean/IntegrableLattice/{PropWStarDifferent,PropFFiniteSupport}.lean`（新設・**14 宣言**）＋ `lean/IntegrableLattice.lean` ＋ `lean/scripts/check-no-sorry.sh`（357 → **371 定理**）＋ `lean/README.md` ＋ `structured-latex/tools/formalization-coverage.ts` ＋ 本文 3 ファイルと英語ロケール同名 3 ファイル（`lean` の紐づけと被覆の数値のみ。**数学の文言は 1 文字も変えていない**）。**未着手 5 件のうち mathlib の欠落が理由でない 2 件に着手し、どちらも 未着手 → 部分的 へ動かした。** **命題 W* は 3 段のうち 2 段が入った**——微分の段（$\chi'=h\cdot\sum_i a_i f_i'(\rho/f_i)$）と付値の段（$\min\{j:\forall\mathfrak p,\ j\,e_\mathfrak p\ge v_\mathfrak p\}=\max_\mathfrak p\lceil v_\mathfrak p/e_\mathfrak p\rceil$、従順分岐・不分岐の系つき）。**本文の「この切り上げは実数の切り上げではない。整数の除算ひとつで決まる」が型でそのまま出た**（$w^*$ は $\mathbb{N}$ の元、`Real` の使用 0 件）。**過剰仮定 1 件**: 微分の段に $f_i$ の既約性も相異性も要らない（効くのは $a_i\ge1$ だけで、任意の可換環の任意の族で成り立つ）。**cycle 27 step 2 が `PropC.lean` で見たのと同じ形が 2 サイクル連続で出た。** **命題 F は (F1) の心臓部が入った**——「すべてのファイバーの係数和が消えるなら分類写像は台の上で単射でない」という数え上げの一点と、そこから出る「割りうる方向は有限集合 $V(E)=\{\mathrm{prim}(e-e'):e\ne e'\in E\}$ に入る」という包含（**非可算な $\mathbb{P}^{d-1}(\mathbb{Z}_p)$ を走らなくてよいことの中身**）。**過剰仮定 1 件**: この段に体であることも標数 $p$ であることも要らない（係数は任意の可換群でよい）。**残る理由を「素材が無い」と「こちらの未設計」で区別した**——命題 F の割り切れ判定の同値は $d$ 変数の完備群環が要り mathlib に素材が無い／(F2) の停止問題への帰着は `Nat.Partrec` が在るのに入力の与え方を型にする設計をこちらが持っていない。**被覆の変化**: 完了 5（不変）・部分的 14 → **16**・未着手 5 → **3**。**全数まで残りは 19 件のまま変わっていない**（残りは「完了でないもの」の数で、2 件はまだ完了ではないため）。本文の数（24 件中 5・14・5）が古くなったので日英とも更新した。検証: `lake build` 8683 jobs exit 0、`check-no-sorry.sh` **371 定理**すべて sorryAx 非依存、新規 2 ファイルに `Real` 0 件、`npm run check`（**26 段**）exit 0、`build:pdf` 日 **50 頁**・英 **64 頁**（どちらも不変）。**自分の誤りを 4 件記録**（最重は**実在を確かめずに mathlib の補題名 `Finset.sup_eq_bot_iff` を書いた**＝cycle 26 step 6 の記録が cycle 27 に続いて**3 サイクル連続で再発**した／`R[X]` を `open Polynomial` 無しで書いて配列の添字と解釈された／補題の引数の向きを宣言を読まずに推測した／`congr 1` が何を残すか確かめずに `omega` を置いた）。**限界**: 入ったのは 2 命題とも「一部」であり、命題 W* の双対の段と命題 F の割り切れ判定の同値という**両命題の中核は入っていない**。 |
| 2 | 運用 | expand_definition_order_ledger | done | 2026-08-04 | `outputs/reports/cycle28_ops_definition_order_ledger.md` / `structured-latex/tools/{definition-order-terms,source-links}.ts` ＋ 本文 3 ファイルと英語ロケール同名 3 ファイル。**台帳を 日 9 → 21 語・英 9 → 20 語 へ広げた。走査の結果、定義より前に使われていた語が 6 件見つかった**——$\kappa_n$（命題 G で使用・命題 W で定義、7 ブロック差）／voltage（同 5 差）／塔が非退化（同 7 差）／型 II（命題 G で使用・命題 J で定義、15 差）／型 III（13 差）／bouquet（1 差）。**さらに $L(z,w)$ は本論文のどこにも定義が無かった**（命題 W が定義せずに使っていた。順序の問題ではなく欠落である）。**定義ブロックを 1 つ起こして使用箇所より前に置いた**（ユーザーが示した 3 通りのうち「定義を前へ移す」）。内容は cycle 14 の report §1.1–1.4 から転記——voltage 割り当て・導来グラフ・$\mathbb{Z}_\ell^2$ 塔・$\kappa(G)$ と $\kappa_n$・voltage ラプラシアン $L(z,w)$（成分で定義）・bouquet・非退化・型 II／型 III。**型 II／III は条件つきの定義にした**（漸近形が書けるときの $b$ で分ける形。こう書けば「その形が存在する」という命題を前方参照しない。5 つの関数が一次独立なので係数は一意）。命題 W と命題 G は設定を自分で述べる代わりにこの定義を参照する形にし、**数学の内容は変えていない**。**命題 A の記号の注意も書き直した**——「命題 B の $\pi_{\mathrm{tr}}(p,k)$ とは別の量である」は正しいが、まだ定義していない記号を使っていた。記号を使わずに同じことを言う形へ直した（日英とも）。**台帳に載せる／載せないの判断を決めて記録した**: 基準は「本論文の中に定義の位置があるか」。**「全域木数」という語は載せない**（概念は標準の語彙で、本論文が定義しているのは記号のほう）。**「非退化」は単独の語では追跡できない**——命題 C が「非退化な companion 行列」と別の意味で使っており字面が同じなので、塔についての句だけを登録した（**この判断は機械では検証できない**）。検証: 検査 O 日 21 語・英 20 語で違反 0 件、`npm run check`（26 段）exit 0、`build:pdf` 日 **50 頁**・英 **64 頁**（どちらも不変）。**設計どおり赤くなった副作用 1 件**: 命題 W の一文を書き換えたことで転写検査の免除が失効し、根拠を更新した。**自分の誤りを 2 件記録**（英訳を日本語版と同じ語順で書かず骨格照合に 2 回落ちた／ブロック挿入時に後続の `origin.ordinal` を繰り下げ忘れた）。**限界**: 走査したのは候補 18 件であって本文の全語彙ではない。**台帳の網羅性が上限であることは変わらず、上限が上がっただけである。** |
| 3 | 運用 | reread_emphasis_removed | done | 2026-08-04 | `outputs/reports/cycle28_ops_reread_emphasis_removed.md` / 本文 6 ファイルと英語ロケール同名 6 ファイル（**日英 8 件ずつ、計 16 箇所**）＋ `structured-latex/tools/{runin-label-model,verify-runin-label,verify-runin-label-detection-test}.ts`（新設）＋ `package.json`（26 → **28 段**）。**探す対象を先に絞った**——cycle 27 の除去は `**` 以外の文字を 1 つも変えていないので**語は何も失われておらず**、失われうるのは強調が担っていた**構造**（区切り）だけである。**段落の先頭に置かれていた強調 243 件を取り出し、自分で区切りを持つか（コロン・句点・括弧）で分けた。** 持つものは強調が無くても区切りが残ることを PDF で読んで確かめた。**本命は現在の本文の側からの走査だった**——述語のない短い段落が箇条書きの直前に置かれていないか。**16 件見つかった**: 7 命題の「限界」（`Limitations`）と命題 Q の「可算と非可算の分別」（`Countable versus uncountable`）。いずれも直後の箇条書きを導く見出しとして書かれていたのに、**述語のない体言止めの段落が落ちているだけ**になっていた。命題 Q のものは同じ命題の別の箇所が**名前で参照している**のに参照先が見出しに見えない状態だった。「限界」の 7 件は cycle 27 step 4b が**同じコミットで**執筆指示「（主張の一部として述べる）」も削ったことが重なり、残ったのが 2 文字だけになっていた。**強調は戻さず、述語のある文にした**（「本命題に残る限界は次のとおりである。」）。**検査 L を新設した**——箇条書きの直前・46 文字以下・文末が句読点でない、の 3 つの積。**検出の実証 16/16**（直した当の 8 件とその同型 4 件を検出し、**通ってほしい 8 件**——直した後の形・数式を導く「したがって」「すなわち」・コロンで終わる導入——が誤検出にならないことも確かめた）。検証: `npm run check`（**28 段**）exit 0、`build:pdf` 日 50 頁・英 64 頁（不変）。**限界**: 判定したのは**構造**であって「この語を目立たせたかった」という意図の復元ではない／検査 L が見るのは長さと文末の字だけ／**箇条書きの直前という形に限っている**（走査では他の形は 0 件だったが、0 件だったことと拾えることは別である）。 |
| 4 | 運用 | back_extremum_nonempty | done | 2026-08-04 | `outputs/reports/cycle28_ops_extremum_nonempty_backing.md` / `lean/IntegrableLattice/ExtremumNonempty.lean`（新設・**9 定理**）＋ `lean/IntegrableLattice.lean` ＋ `lean/scripts/check-no-sorry.sh`（371 → **380 定理**）＋ `structured-latex/tools/{extremum-model,extremum-allowances,verify-extremum}.ts`。**「構成から空でない」17 件のうち 13 件を Lean の定理で裏取りした。** 台帳の根拠に `leanTheorem` を足し、検査 M が (1) 指した定理が `lean/` に実在すること (2) **17 件のうち何件の裏が取れているか** (3) 取れていないものはどれか、を毎回印字する。**内容のある 3 件**: $g\neq0$ から $\varepsilon_d<\infty$ なる $d$ の存在（多変数多項式の台が空でない）／$c_1$ の $\ell^c$ の非有界性／命題 N の固有値（代数閉体上、次数 $\ge1$ の多項式は根をもつ）。残り 6 定理は自明だが、**自明であることと機械が確かめたことは別**なので通した。**裏を取れなかった 4 件はすべて命題 W\* のもの**（$\mathfrak p\mid p$ の添字族と $\min\{j:p^j\eta^{-1}\in A_{(p)}\}$ の 3 件）で、**理由は本サイクル step 1 が命題 W\* の双対の段で当たった壁と同じ**——mathlib に `traceDual`・`differentIdeal` は在るが $A=\mathbb{Z}[x]/(\rho)$ を Dedekind 環として与えて局所化・付値へつなぐ配線が無い。検証: `lake build` 8684 jobs exit 0、`check-no-sorry.sh` **380 定理**すべて sorryAx 非依存、`npm run check`（28 段）exit 0、検査 M 違反 0 件（裏取り **13/17**）。**限界**: 裏が取れたのは「台帳が書いた理由が正しいこと」であって「その理由が当の $\min$ の添字族に当てはまること」ではない（**定理と本文の対応づけは人が読んで決めており、指し先が間違っていれば検査は静かなまま通る**）。 |
| 5 | 運用 | port_pr69_pisano | done | 2026-08-04 | `outputs/reports/cycle28_ops_port_pr69.md` / `lean/IntegrableLattice/PropCPeriod.lean`（**3 定理を追記**）＋ `lean/scripts/check-no-sorry.sh`（380 → **383 定理**）。**コードを持ってこず、主張だけを現在の main の上へ書き直した。** 実測で分かったこと 2 点: (1) **main には既に大部分が在った**——`orderOf_reduction_dvd`（$\pi(p,k)\mid\pi(p,1)p^{k-1}$ そのもの）・`isUnit_pow_add_eq_iff`（純周期性）・`isUnit_map_of_not_dvd_det`（可逆性）はすべて証明済み。両者は同じファイル名で別々に発展していた。**本当に欠けていたのは「最終周期の最小値が `orderOf` に一致する」という `IsLeast` の橋 1 点だけ**で、これが無いと main が計算に使う `orderOf` が人手証明の $\pi(p,k)$ と同じものだと言えていない。(2) **救済側の実装は未証明の穴を含んでいた**（$p\nmid\det T$ からの可逆性の補題が証明されていない）。**この点は PR のコメントに記録されていなかった。** そのまま取り込めば検査で落ちる。移植したのは `isLeast_eventualPeriod`・`isOfFinOrder_of_isUnit_of_finite`（**行列環は簡約モノイドではないので `isOfFinOrder_of_finite` を直接使えず、単元の群へ移して `orderOf_units` で戻す**。救済側はこの一歩を書いておらず現在の mathlib では型が合わない）・`isLeast_eventualPeriod_reduction`。**持ってこなかったもの**: `pisanoPeriod` 等の定義は main の `orderOf_reduction_dvd` と同じ主張の別名で内容が増えない／`refs.bib` の変更は現在の main と系統が違う／ログの削除は成果ではない。検証: `lake build` 8684 jobs exit 0、`check-no-sorry.sh` **383 定理**すべて sorryAx 非依存。**自分の誤りを 1 件記録**（doc コメントに経緯として `sorry` の語を書き、`check-no-sorry.sh` の第 1 段に自分で引っかかった。**検査が正しく働いた例**でもある）。 |
| 6 | 運用 | coverage_number_consistency | done | 2026-08-04 | `outputs/reports/cycle28_ops_coverage_number_check.md` / `structured-latex/tools/{formalization-coverage,verify-formalization-coverage}.ts`（**本文は 1 文字も変えていない**）。**2 択のうち「検査にする」を採った**（本文から数を落とす案は採らなかった。全数形式化が目標だと書いている以上、いまどこかを数で示すのは読者に対する誠実さの一部であり、落とすと `lean/README.md` を開かないと分からなくなる）。**数の出どころを台帳ひとつにした**——台帳から 完了・部分的・未着手 を数え、その実測値を入れた文字列が本文に実在することを日英で確かめる。**数だけ直して検査を通す道は無い**（数が台帳から出ているので、本文を直すには台帳を直すしかない）。本文を**言い換えたときも赤くなる**（そのときは組み立て方を本文へ合わせて直す。言い換えを黙って許すと照合の空振りに気づけない）。**この数は本サイクル step 1 で実際に古くなった**（部分的 14 → 16、未着手 5 → 3）。そのときは step 1 が本文も直したが、**直し忘れても誰も気づかない**状態だった。**検出の実証**: 本文の「16 件」を「14 件」に書き換えて違反 1 件で落ちることと、書き戻して 0 件に戻ることを確かめた。検証: `npm run check`（28 段）exit 0、`build:pdf` 日 50 頁・英 64 頁。**限界**: 照合しているのは**地の文の文字列**なので、本文が数を数式ノードで書くようになれば空振りする（いまは 0 件だが**空振りしても静かなまま**）／塞いだのは「台帳と本文がずれる」道だけで、**「台帳が実態とずれる」道は塞いでいない**（「完了」が本当に完了かは人の判断、という検査 F の限界はそのまま残る）。 |
| 7 | — | rank:cycle28 | done | 2026-08-04 | 下記「cycle 28 総括」。掲げた 7 点はすべて潰れた。cycle 29 の焦点は 6 点。 |

## cycle 28 総括（rank:cycle28, 2026-08-04）

**掲げた 7 点はすべて潰れた。本サイクルの主題は 2 つある——「全数形式化の最優先分に着手したが、
全数までの距離は 1 件も縮まらなかった」ことと、「前サイクルが自分で書いた限界を、
3 つとも検査へ変えた」ことである。**

### 前提の食い違いは 0 件だった（3 サイクル連続で実測してから起こした）

着手時に 7 点すべてを実測し、**全点が一次情報と一致した**。cycle 26（0 件）・cycle 27（1 件）に続く。
ただし 1 点だけ**言葉の含みがずれていた**——焦点 0 は命題 W* を
「mathlib の欠落ではなくこちらの未着手なのですぐ着手できる」と書いていたが、
台帳の理由欄は「どの段で詰まるかをまだ一次情報で特定していない。まず調査から要る」だった。
**「すぐ着手できる」は「調査が要らない」という意味ではない。** 実際、step 1 の作業の半分は
命題 W* を 3 段に分け、どの段が mathlib の欠落に当たるかを分けることだった。

### 全数形式化に着手したが、残りは 19 件のまま動かなかった（step 1）

未着手 5 件のうち mathlib の欠落が理由でない 2 件（命題 W*・命題 F）に着手し、
**どちらも 未着手 → 部分的 へ動いた**（未着手 5 → 3、部分的 14 → 16）。

**しかし全数までの残りは 19 件のまま変わっていない。** 残りとは「完了でないもの」の数であり、
動いた 2 件はまだ完了ではないからである。**動いたのは「未着手か部分的か」であって、
全数への距離ではない。** 本文の数も日英とも更新した。

入ったのは 2 命題とも一部である。**命題 W* は 3 段のうち 2 段**（微分の段と付値の段）で、
中核である双対の段——単因子と差積の同一視——は入っていない。
**命題 F は (F1) の心臓部**（非可算な $\mathbb{P}^{d-1}(\mathbb{Z}_p)$ が有限個の有理方向に落ちること）で、
割り切れ判定の同値そのものは入っていない。

**本文の但し書きが型でそのまま出た例が 1 つあった。** 命題 W* の
「この切り上げは実数の切り上げではない。整数の除算ひとつで決まる」は、
$w^*$ を $\mathbb{N}$ の元として書けばそれ自体が主張になる（ファイルに `Real` が 1 度も現れない）。

### 過剰仮定が 2 件、しかも前サイクルと同じ形で出た（step 1）

- 命題 W* の微分の段に**既約性も相異性も要らない**（効くのは $a_i\ge1$ だけで、
  任意の可換環の任意の族で成り立つ）。
- 命題 F の数え上げの段に**体であることも標数 $p$ であることも要らない**（係数は任意の可換群でよい）。

どちらも**仮定は主張が要求したものではなく文脈が要求したもの**という形であり、
cycle 27 step 2 が `PropC.lean` の持ち上げ補題で見たものと同じである。**2 サイクル連続で出た。**

### 前サイクルが書いた限界を、3 つとも検査へ変えた（step 2・4・6）

cycle 27 は 3 つの限界を自分で記録していた。本サイクルはその 3 つを潰した。

- **「台帳の網羅性が検査 O の強さの上限」**（step 2）→ 台帳を 日 9 → **21 語**・英 9 → **20 語**。
- **「構成から空でない 17 件は機械検証できない」**（step 4）→ **13 件を Lean で裏取り**。
- **「本文に書いた数と台帳の数が一致することは検査していない」**（step 6）→ 検査にした。

**限界を書いておくことが次サイクルの入力として実際に機能している。**

### 台帳を広げたら、定義が無い語が出てきた（step 2）

検査 O の台帳を広げるために本文の用語を走査したところ、**定義より前に使われていた語が 6 件**
見つかった（$\kappa_n$・voltage・塔の非退化・型 II・型 III・bouquet。隔たりは 1〜15 ブロック）。
さらに **$L(z,w)$（voltage ラプラシアン）は本論文のどこにも定義が無かった**。
命題 W が定義せずに使っており、命題 G が括弧で $\kappa_n$ だけを補っていた。

**これは順序の問題ではなく欠落である。** 定義ブロックを 1 つ起こして使用箇所より前に置き、
命題 W と命題 G はそれを参照する形にした（数学の内容は変えていない）。

**台帳に載せる／載せないの判断も決めて記録した。** 基準は「本論文の中に定義の位置があるか」。
「全域木数」という**語**は載せない（概念は標準で、本論文が定義しているのは記号のほう）。
**「非退化」は単独の語では追跡できない**——命題 C が「非退化な companion 行列」と別の意味で
使っており字面が同じである。**この判断は機械では検証できない。**

### 強調除去で失われたのは語ではなく構造だった（step 3）

cycle 27 の除去は `**` 以外の文字を 1 つも変えていないので、**語は何も失われていない。**
失われうるのは強調が担っていた区切りだけである、と絞ってから探した。

段落の先頭にあった強調 243 件を、自分で区切りを持つか（コロン・句点・括弧）で分けた。
持つものは強調が無くても読める（PDF で確かめた）。**本命は現在の本文の側からの走査で、
述語のない短い段落が箇条書きの直前に落ちていないかを見たところ 16 件見つかった**
（7 命題の「限界」と命題 Q の「可算と非可算の分別」、日英それぞれ）。
命題 Q のものは**同じ命題の別の箇所が名前で参照している**のに、参照先が見出しに見えなかった。

強調は戻さず、述語のある文にした。**検査 L** を新設した。

### 救済 PR #69 は、実測すると欠けていたのは 1 点だけだった（step 5）

管理役の記録「命題 C の周期の段が救済ブランチにだけ在る」は正しかったが、
実測すると **main には既に大部分が在った**（整除の結論も純周期性も可逆性も証明済み）。
**本当に欠けていたのは「最終周期の最小値が `orderOf` に一致する」という `IsLeast` の橋 1 点。**

**さらに、救済側の実装は未証明の穴を含んでいた**（可逆性の補題が証明されていない）。
**この点は PR のコメントに記録されていなかった。** そのまま取り込めば検査で落ちる。
コードは持ってこず、主張だけを現在の main の上へ書き直して PR を閉じた。

### 運用

- **`npm run check` は 26 段 → 28 段になった**（検査 L の本体と検出テスト）。
  検査 M・F・O は段数を増やさずに中身が強くなった。
- **`lean/` の定理は 357 → 383 になった**（step 1 で 14・step 4 で 9・step 5 で 3）。
- **各 step が自分の誤りを記録した。** 記録済み誤りの再発が今回もあった——
  **実在を確かめずに mathlib の補題名を書く**（cycle 26 step 6 の記録から数えて**3 サイクル連続**）。
  新しい形も出た: **英訳を日本語版と同じ語順で書かず骨格照合に 2 回落ちた**（数式ノードの
  並びまで見る検査なので、英語として自然な語順にすると落ちる）、
  **doc コメントに経緯として `sorry` の語を書いて自分で検査を赤くした**（検査が正しく働いた例でもある）。
- **設計どおり赤くなった副作用が 1 件**（命題 W の一文を書き換えたことで転記検査の免除が失効）。
  cycle 25・26・27 と同じ「直したのに宣言が残る状態を作れない」形である。
- **他のエージェントと `/tmp` のファイル名が衝突した。** 別 worktree のセッションが同じ名前の
  ログへ書いており、一時ファイルをセッションの作業領域へ移した。

### cycle 29 の焦点（案）

**最優先は全数形式化である**（2026-08-03 ユーザー方針）。**残り 19 件は本サイクルで動いていない。**

0. **全数形式化を進める。** 完了でない 19 件の内訳は本サイクル後の実測で
   **完了 5・部分的 16・未着手 3**。
   - **未着手 3 件**: 命題 LSW／双対命題 D（どちらも多変数の Mahler 測度が mathlib に無い）、
     命題 G（matrix-tree 定理が無い）。**3 件とも mathlib の欠落が理由**であり、
     こちら側の未着手はもう無い。
   - **したがって次に動かせるのは「部分的 16 件のうち、残りが配線だけのもの」である。**
     台帳の理由欄を読み直し、「素材が無い」ものと「配線をしていないだけ」のものへ分けること。
     後者から着手する。**この仕分け自体がまだ行われていない。**
1. **双対命題 D の $p$ 素点側だけを切り出せるか。** 台帳は「アルキメデス側を含むので
   片側が形式化できない」と書き、$p$ 側だけの切り出しを**未検討**としている。
   中心命題なので、片側だけでも入れば被覆の意味が変わる。
2. **命題 W* の双対の段と、検査 M の裏が取れなかった 4 件は同じ壁である。**
   どちらも $A=\mathbb{Z}[x]/(\rho)$ を Dedekind 環として mathlib へ渡す配線が無いことに帰着する。
   **1 つ通せば 2 つ動く。** 配線を通せるかを一次情報で確かめる価値がある。
3. **検査 O の台帳は広がったが、走査したのは候補 18 件であって全語彙ではない。**
   拾い方（定義の言い回しの機械抽出）に漏れがあれば候補に上がらない。
   別の拾い方（記号の初出の全数走査）で漏れを測ること。
4. **検査 L は箇条書きの直前という形に限っている。** 走査では他の形は 0 件だったが、
   **0 件だったことと拾えることは別**である。
5. **本文の被覆の数値の照合は地の文の文字列に依っている。** 数を数式ノードで書くと空振りする。
   空振りしても静かなままなので、照合が実際に効いていることを毎回示す形にできるか。

### 方針判断点（ユーザー価値判断・未決。cycle 21 から持ち越し）

論文 001 の「新規性を主張しない」宣言を維持するか。既出性の判定は cycle 23 で出そろっている。
**自動ループでは決めない。** 本サイクルでも変更していない。

## ユーザー方針（2026-08-03・現行。解除されるまで厳守）: 論文の主張を全数 Lean 形式化することを目標にする

**一部の形式化で足れりとしない。論文の全主張の形式化を目標に据える。** 以降のサイクルが引き継ぐ。

- 現在の被覆（2026-08-03 実測）: 主張 **24 件**のうち **完了 5・部分的 14・未着手 5**。**残り 19 件。**
- **未形式化の件数は毎サイクル出る**（`npm run check` の検査 F `verify:formalization`）。
  台帳は `structured-latex/tools/formalization-coverage.ts`。
- **達成していないことを達成したように書かない。** 全数が達成されるまで本文に
  「全主張を形式化した」と書いてはならない。
- **形式化できない主張は黙って落とさず、何がなぜできないかを一次情報で示す**
  （先例: mathlib 欠落調査の 3 段の引き方）。

## cycle 27 総括（rank:cycle27, 2026-08-03）

**掲げた 5 点はすべて潰れた。本サイクルの主題は 2 つある——「同じ形の事故を全数で洗ったら、
既知の 2 例が実は 6 例だった」ことと、「読者が読む本文そのものにユーザーの手が入り、
それを同じサイクルの中で反映して検査にした」ことである。**

### 前提の食い違いは 5 点中 1 点。数え方の違いだった

着手時に 5 点すべてを実測した（cycle 26 に続き 2 サイクル目）。4 点は一次情報と一致し、
1 点だけ食い違った——**日本語版 PDF のアスタリスク「410 箇所」は行数だった**
（`**` の出現は 1246 個＝強調 623 対、413 行にわたる）。
**現象そのものは報告どおり実在した**ので、食い違いは数え方の粒度だけである。

### 空集合の規約の欠落は、2 例目ではなく 6 例目だった（step 1）

本文の `\min` / `\max` **129 件を 1 つずつ読んだ**。判断が要るのは 42 件で、
そのうち **4 件で規約または「空でない理由」が落ちていた**。

**最も射程が広いのは命題 G の (G1′) のずれ指数である。** 原本は
「$d<k$ の項が無ければ $\delta:=+\infty$」と規約を明記していたのに、本文へ運ぶときに落ちていた。
**空になるのは例外ではなく一般の場合**で、実質の範囲 $k_{\min}\le d<k$ が空になるのは
$k=k_{\min}$、すなわち最低次部分が $\ell$ で割れない一般の塔である。
**原本が挙げる検証例はすべてこの場合に入る。** $\min\emptyset=0$ と読むと $\delta=-k<0$ になり、
十分条件が成り立つべき当の場合で成り立たなくなる。

**2 件目は消滅深度 $\theta$ の $\infty$ 規約**で、本文は $S_\infty=\{P:\theta(P)=\infty\}$ で
その読みを実際に使っているのに規約が無かった。$\min\emptyset=0$ と読むと
**(G6) の仮定が偽から真へ反転する**——仮定を満たさない塔へ結論を適用してしまう向きの誤りである。

**3 件目は $S_\infty$ 上の $\max$**（命題 K・M・U）。$S_\infty=\emptyset$ は命題 K 自身が
(K6) で $b=0$（型 II）として名指ししている場合そのものである。

**既知の 2 件（定理 G2・命題 G′）はどちらも $\ell=3$ だけが落ちる形だった。
今回の 3 件はいずれもそれより射程が広い。** 「1 つの素数だけが落ちるから見つからない」という
cycle 26 の見立ては正しかったが、**全数で洗ったら、見つかっていなかったのはもっと大きい穴だった。**

### Lean の 12 サイクル目は、既存の形式化の側に発見があった（step 2）

未検算だった 6 命題（G″・J・K・R・M・U）の証明ステップを形式化した。
**6 命題とも、形式化した範囲では本文と食い違わなかった。**

発見は別のところにあった——step 1 が命題 W へ入れた持ち上げ
（$p\mid x-1\Rightarrow p^{m+1}\mid x^{p^m}-1$）と**同じ主張が `PropC.lean` に既にあり、
しかも $p$ が素数という仮定つきだった**。向こうは二項展開を取り $p\mid\binom pm$ を使うので
素数性が要るが、**等比の因数分解を取れば素数性は 1 度も要らない**。
**仮定は主張が要求したものではなく、道具立てが要求したものである。**

### ユーザーの判断と指摘が、サイクルの途中で 2 回入った（step 4b・4c）

step 3 は「日本語版 PDF が強調をアスタリスクのまま印字している」を計測して管理役へ上げた
（**自動ループでは決めない**と判断した唯一の点）。**回答は「太字にするのではなく、
強調指定そのものを本文から削除する。今後も使わない。再発は検査で止める」**だった。
続けてユーザーが PDF を読み、**執筆指示の混入**と**定義の登場順序**を指摘した。

3 つとも同じサイクルの中で反映した。

- **強調指定 2534 個を除去**した（強調 1267 対）。日本語版 PDF から印字されるアスタリスクが消えた
  （51 頁 → **50 頁**）。検査 E の意味を「ノードをまたぐ強調を落とす」から
  **「本文に強調指定を書かない」**へ変えた。
- **執筆指示を除去**した（題の中の書き手への指示、読者が開けないリポジトリ内部への参照、
  作業ツリーのサイクル番号）。**検査 W** を新設した。
- **定義の登場順序をトポロジカル順序へ直した**。見出しからその章で定義する語を落とし、
  位置づけのブロックを定義済みの語だけで書き直し、英語版だけの読者案内を第 3 章の後へ移した。
  **検査 O** を新設した。

**`npm run check` は 18 段 → 24 段になった。** 増えた 6 段はすべて
「ユーザーが指摘した形」または「同型の事故が繰り返された形」を止めるためのものである。

### 台帳の根拠が、推論から実測になった（step 5）

`field_simp` 直後の `ring` の台帳 10 件を、**実際に 1 つずつ外してビルドした。10/10 件が落ちた。**
落ち方は 10 件とも `unsolved goals` で、`ring` が実際に仕事をしていることを直接示している。
cycle 26 の根拠は「不要なら `No goals to be solved` で落ちるはず」という逆向きの推論だった。

### 転記検査の `covers` を両端で固定した（step 4）

cycle 26 が `covers` を照合対象へ回したことで「何も照合しない passage」は 0 件になったが、
`covers` は**台帳の書き手が書いた文**なので report 側が固定されていなかった。
**`covers` の数式アトムが report にも現れることを要求**し、**範囲の不備を 3 件見つけて直した**。

### 運用

- **各 step が自分の誤りを 3〜4 件記録した。** 記録済み誤りの再発が今回も複数あった——
  **一次情報を見る前に設計を決める**（cycle 25 step 2 の記録から通算 5 件目）、
  **実在を確かめずに mathlib の import と補題名を書く**（cycle 26 step 6 の記録の再発）、
  **`omega` が非線形を閉じると決めつける**（同）。
- **プロセスをパターンで探して自分自身にマッチさせた**（`pgrep -f "npm run check"` が
  このエージェント自身のプロンプトに当たった）。kill はしていないが、
  規約が「使うな」と書いている当の形である。以後は背景ジョブの識別子で状態を見た。
- **設計どおり赤くなった副作用が 5 種類あった**——転記検査の免除 2 件の失効（step 1）、
  同 38 件の `bodyQuote` の失効（step 4b）、再現データ 2 件の腐り、
  日英対応の免除 4 件の「登録が古い」、用語集の参照 2 件の腐り。
  **すべて「直したのに宣言が残る状態を作れない」という既存の設計が働いた結果である。**

### cycle 28 の焦点（案）

**最優先は全数形式化である**（2026-08-03 ユーザー方針。上の「ユーザー方針」節）。
残り 19 件の内訳を名前で書く。件数だけにしない。

0. **全数形式化を進める。** 完了でない 19 件は次のとおり。着手順は「mathlib の欠落が無いもの」から。
   - **未着手 5 件**: 命題 LSW（エントロピー＝Mahler 測度）／命題 W*（$w^*$ の代数的閉形式）／
     双対命題 D／命題 F（有限台なら $\lambda$ が計算できる）／命題 G（$d=2$ 塔の低位項ほか 4 部）。
     このうち **mathlib の欠落が理由なのは 3 件**——命題 LSW と双対命題 D は
     **多変数の Mahler 測度が無い**（1 変数は在る。2026-08-03 実測）、
     命題 G は **matrix-tree 定理が無い**。
     **残る 2 件（命題 W* と命題 F）は mathlib の欠落ではなくこちらの未着手**なので、
     まずここから着手できる。
   - **部分的 14 件**: 周期点数の終結式（一般の $d$）／命題 C′（上界の組み立て）／
     命題 N（上界方向・鋭い下界・Newton 多角形と固有値の接続）／命題 C″（閉形式の不存在）／
     命題 G′（Newton 多面体・$\pi$ 進評価・例外直線）／命題 G″（4 通りの閉形式の導出）／
     命題 T（matrix-tree の段・Hensel の配線）／命題 W（閉形式本体）／
     命題 J（(J2)(J3)(J5)(J6)）／命題 K（(K1)(K4)）／命題 R（終結式による付値）／
     命題 Q（(Q4) の粗上界）／命題 M（閉形式の導出）／命題 U（(U1) の導出・(U3)(U5)）。
1. **検査 O の台帳を広げる。** いま追跡しているのは 9 語だけで、
   **台帳の網羅性がこの検査の強さの上限**である。本文の用語・記号を全数で洗い、
   どこまでを「本論文が定義する語」とみなすかを決めて台帳へ入れる。
2. **強調を外したときに意味が落ちた箇所が無いかを人が読んで確かめる。**
   1267 対すべてを読み直したわけではない。見出し語として使われていた箇所を中心に見たが、
   装飾に意味を持たせていた箇所が残っている可能性は否定できない。
3. **検査 M の「構成から空でない」17 件は機械検証できない。** この 17 件の判断が誤っていれば
   検査は静かなまま通る。SageMath か Lean で裏を取れるものがあるか検討する。
4. **命題 K・M・U の中核（(U1) の導出そのもの、Newton 多面体、例外直線の決定）は未形式化である。**
   step 2 が形式化したのは計算に還元できるステップだけで、「6 命題を検算した」は
   「6 命題の証明の一部を検算した」の意味である。
5. **救済 PR #69 の移植**（`lean/` に関わるので本サイクルでは着手しなかった）。
6. **本文の被覆の数値（24 件中 完了 5・部分的 14・未着手 5）は、形式化が進めば古くなる。**
   検査 F は件数を毎回出すが、**本文に書いた数と台帳の数が一致することは検査していない**。
   ずれたら気づけないので、次サイクルでそこを検査にするか、本文から数を落として台帳を指すかを決める。

### 方針判断点（ユーザー価値判断・未決。cycle 21 から持ち越し）

論文 001 の「新規性を主張しない」宣言を維持するか。既出性の判定は cycle 23 で出そろっている。
**自動ループでは決めない。** 本サイクルでも変更していない。

## cycle 26 総括（rank:cycle26, 2026-08-02）

**掲げた 6 点はすべて潰れた。本サイクルの主題は「検査にした誤りが、同じサイクルの中で実際に働いたこと」である。**

### 前提の食い違いが、2 サイクルぶりに 0 件だった

cycle 25 の教訓 (a)「step 列の前提が一次情報と食い違う事故が 2 サイクル連続」への対処として、
**着手時に 6 点すべてを実測してから step 列を起こした**。結果、**6 点とも一次情報と一致した**
（腐った参照 17 件・照合対象 0 件のブロック 5 件・機械検証できない免除 14 件・
持ち越し 2 件の記述・命題 G′ の仮定が proof にだけあること・`check` が 15 段であること）。
**実測は「食い違いを見つけるため」だけでなく「食い違いが無いことを確かめるため」にも要る。**

### 3 サイクル持ち越しの未検証 2 件が閉じた（step 1）

- **cycle22 注 3.1**: $T_\mathrm{def}=0$ の 108 本で $(1.1)$ が $n=0$ で成り立つことを確認
  （191 組で同値の破れ 0 件）。**実際にはもっと強く、108 本すべてで $\delta_M$ が全て $0$
  ＝全ての $n\ge0$ で成り立っていた。**
- **定理 D2 のレベルごとの判定を Matrix–Tree の塔の値と 860 件突き合わせ、食い違い 0。**
  内訳が重要で、**「判定も実測も不一致」が 139 件（16%）**ある——**判定が空振りでない証拠**である。
  従来の照合は $n\ge n_0$ に限っており、**$n=0$ と $n<n_0$ はこれが初めての突き合わせ**だった。
- **証明の但し書き「実在の塔で $\delta_M$ の符号が混ざる例は確認していない」は半分解消**——
  **混ざる塔は 47 本実在した**が、**$T_\mathrm{def}=0$ のものは 0 本**。
  証明が構成した反例の配置は、この母集団では実現していない。
- **cycle21 §6.3**: $\ell=2$ トーラスは $T_\mathrm{def}=3\ne0$・$\delta=(3,0,0)$ で、
  **$(1.1)$ の成立開始レベルはちょうど $n=1$**。「$n=1$ から完全に一致する」は正しく、
  **定理 D2 がその開始レベルをちょうど言い当てている**。
  cycle 22 step 4 の「保証範囲外」という指摘は**当時は妥当**で、
  **説明を与えたのが cycle 22 定理 D2、それを実測したのが本サイクルである。**

### 「本当に腐っている」参照が 0 件になった（step 2）

実在しない参照 41 → **24 件**、免除 40 → **25 件**、**`outOfScope` 17 → 0 件**。
改名・移設で腐った 11 件は実ファイルへ向け直し、**作られなかった設計上のファイル 6 件は
過去形の記述へ書き換えて `historical` 型へ判定ごと変えた**（黙らせたのではない）。

**設計どおりに働いた仕掛けが 2 つある。** (1) `outOfScope` は「直れば宣言が余って赤くなる」型として
作られており、実際 17 件を直した時点で登録を消さねばならなくなった。
(2) **検出テストが生きた表から免除を拾っていたため、表が空になった瞬間に例外で落ちた**——
**cycle 25 step 4b が `PROOF_DEBTS` で踏んだのと同じ形**で、同じ直し方で直した。

### 3 サイクル連続の再発 2 型を検査にした。そして同じサイクルの中で働いた（step 3 → step 6）

`npm run check` は **15 段 → 18 段**。

- **検査 E（ノードをまたぐ強調）**: 原因を一次情報で確定させた——`editions.ts` が日本語版を
  `bold: false`、英語版を `bold: true` と宣言し、`applyBold` が**日本語版では何もしない**。
  **同じ書き方が日本語で静かに通り英語でだけ落ちる**という非対称が再発の正体である。
  **落とす条件は生成器と同じにし**、変えたのは「落ちる段を早めたこと」と
  「**原文側の在庫 298 件を毎回印字すること**」の 2 点だけ。
- **検査 T（`field_simp` の直後の `ring`）**: 一律禁止にはできない（既存 10 件は
  `lake build` が通る以上 `ring` が必要）ので**宣言制**にし、**未宣言の対は即座に赤**にした。
- **検出の実証 16/16。再現データは実際に再発した形そのもの。**

**そして step 6 で、私が英語版の訂正を書いた瞬間に検査 E が落ちた。**
3 サイクル連続の再発の 4 回目だが、**今回は `validate` の直後で止まった**
（従来は PDF 生成まで進んで初めて分かった）。
**「記録を読んでも止まらない」と「検査にすれば止まる」が、同じサイクルの中で同時に実証された。**

### 転記検査の弱点 2 つを、件数として実際に減らした（step 4）

| 弱点 | 着手時 | 完了時 |
|---|---|---|
| 照合対象が 0 件だったブロック | 5 件 | **0 件** |
| 型として機械検証できない免除 | 14 件 | **8 件** |
| 照合したアトム / 語 | 181 / 186 | **201 / 254** |

- **`covers`（cycle 25 まで「検査には使わない」と型の doc に書いてあった）を、
  条件文が 1 文も取れなかった passage に限り照合対象へ回した。** 黙って回さず件数（28 件）を毎回出す。
  新たに挙がった **21 件はすべて本文を読んで判定**し、機械検証できる根拠つきの免除にした。
- **`positioning` に閉じた語彙の目印を必須にした。** 導入直後に
  **既存 14 件のうち 6 件が目印を持たず赤くなり、読んだところ 6 件とも分類が誤っていた。**
  本文を読んで機械検証できる型へ付け替えた。

### Lean が 11 サイクル連続で仕事をした。今回は「証明そのもの」の側で（step 6）

- **検出**: 命題 G′ の**証明**は $m_1=+\infty$ の読み方の規約を明記しているのに、
  **主張の側に無い**。主張は $m_1$ を引き算に 2 回使う。
  **$\min\emptyset=0$ で読むと (G′3) の族で $\ell\ge5$ を要求し、
  「任意の奇素数で成り立つ」という主張から $\ell=3$ だけが落ちる。**
- **これは cycle 25 step 1 が定理 G2 $(3.2)$ で見つけたのとまったく同じ形の 2 例目**であり、
  **どちらも落ちるのは $\ell=3$ だけ**である。**1 つの素数だけが落ちるから長く見過ごされる。**
- 証明の主要 6 ステップ（$\varphi(\ell^M)\ge\ell-1$、step 5 が移した 1 条件が全レベルの条件を含意すること、
  総和の恒等式、**直線の寄与の総和計算そのもの**、割合 $\ell^{1-M}$、
  **(G′3) の閉形式と 5 係数の一致**）は**食い違いなし**。
- **本 step の 9 定理は `Real` を 1 つも使わない**＝命題 G′ の証明は非可算側を一切通らない。
- `lake build` **8680 jobs**、`check-no-sorry.sh` **336 定理**（cycle 25 は 327）すべて sorryAx 非依存。

### 命題 G′ の主張に、原本の仮定が入った（step 5）

**証明が「この仮定なしにはこの等式は述べられない」と自分で書いている等式を、
主張は無条件に述べていた。** 仮定 $\theta^*-m_1<\ell-1$ を主張へ入れ（日英同時）、
証明は「主張が置いた仮定を使う」形へ改めた。
論文は日 **50 頁**・英 **64 頁**（未解決参照 0・ノート混入 0・TODO 0）で変わらない。

### 本サイクルが見つけた未修正の別件

**日本語版の PDF は `**` を素のアスタリスクとして印字している**（`build/document.tex` に **410 箇所**。
「（\*\*対数順序群\*\*）」がそのまま組まれる）。**50 頁の日本語正本の全体にわたる。**
`bold: false` は「変換しない」であって「落とす」ではないため。
直すには日本語版も `bold: true` にする必要があり、**本文 298 箇所の書き換えを伴う**
（正本 PDF の見た目を変える判断でもある）。**記録に留め、cycle 27 の焦点へ送った。**

### 運用

- **各 step が自分の誤りを 3〜4 件記録した。** 記録済み誤りの再発は今回も複数あった
  （ノードをまたぐ強調 4 回目・mathlib に在ると確認せず書く・**一次情報を見る前に設計を決める**）。
  **ただし「ノードをまたぐ強調」は今回はじめて機械が止めた。**
- **「一次情報を見る前に設計を決める」が、cycle 25 step 2 の記録から 1 サイクルで 3 件再発した**
  （step 1 の検証の期待値・step 3 の検査 E の設計・step 4 の `bodyQuote`）。
  **うち 2 件は本サイクルで作った／既にあった検査が捕まえた。**
- **mathlib は worktree に無かった**（gitignore された依存なので正常）。同一リビジョン `520045a` を
  別 worktree から複製して復旧した。**プロセスの停止は 1 件も行っていない。**

### cycle 27 の焦点（案）

1. **`\min\emptyset` の規約の欠落を全数で走査する。** 同じ形の事故が 2 例目である
   （定理 G2 $(3.2)$・命題 G′）。**どちらも $\ell=3$ だけが落ちるので目視では見つからない。**
   本文の全 $\min$ / $\max$ について、空集合になりうるか・規約が書かれているかを機械で洗う。
2. **cycle 25 が運んだ 7 件の証明のうち、まだ検算していない 6 件**（命題 G″・J・K・R・M・U）を
   Lean で検算する。cycle 26 は命題 G′ だけを見た。
3. **日本語版 PDF の素のアスタリスク 410 箇所**（上記）。日本語版を `bold: true` にし、
   本文 298 箇所の強調を数式の前後で分ける。**正本 PDF の見た目が変わる**ので、
   やるかどうかの判断を含む。
4. **転記検査に残る弱点**——機械検証できない免除は 14 → 8 件になったが 0 ではない。
   `covers` へ回した 28 件の passage は、report 本文より弱い出所と照合している。
5. **`field_simp` の直後の `ring` の台帳（10 件）を、実際に `ring` を外して落ちることで裏取りする。**
   いまの根拠は「`lake build` が通っているから必要なはず」という論理であって、実測ではない。

### 方針判断点（ユーザー価値判断・未決。cycle 21 から持ち越し）

論文 001 の「新規性を主張しない」宣言を維持するか。既出性の判定は cycle 23 で出そろっている。
**自動ループでは決めない。** 本サイクルでも変更していない。

## cycle 25 step 列（2026-08-01 起こし。cycle 24 総括の「cycle 25 の焦点（案）」4 点をそのまま step にした）

**前提**: cycle 24 で 4 点すべてが潰れ、命題 M・U が本文に入った。残る負債は
(a) **その章は主張と限界だけで `proof` が空**＝原本の証明を運んでいない。しかも
**転記検査は主張しか見ないので、この未了は赤にならない**（検査の穴）、
(b) **cycle 24 step 5（Lean）が新たに検出した 2 件が未訂正**——補題 Q5 の定数 $c_1$ が $b=0$ で
未定義（$\log_\ell 0$。同じ report の系 G6 がまさにその場合）、定理 G2 $(3.2)$ の $\infty$ の引き算の読み方、
(c) **Q 系は本文に 1 ブロックも無い**（cycle 24 step 4 が $c_1$ を入れなかった理由）、
(d) **本文・コメント中のツールへの参照は「本文の文言を変えない」を守ると腐る**
（cycle 24 step 2 で呼び出し元が手で 12 ファイル分を発見した種類の腐り）、
(e) **Lean 検算 10 サイクル目**（本文へ入った命題 M・U と未検算の定理群）。

**担当を分ける（衝突回避）**:
- `outputs/reports/` の訂正を行うのは **step 1 だけ**。
- `structured-latex/tools/`（検査道具）と `package.json` の検査段を触ってよいのは **step 2 だけ**。
  ただし **step 4 は `tools/source-links.ts` への登録追加だけ**行ってよい（cycle 24 step 3→4 と同じ引き渡し）。
- 本文（`structured-latex/content/` と `structured-latex/locales/en/content/`）を触ってよいのは
  **step 4 だけ**（step 1・2・3 の main 反映後に起こす）。
- `lean/` を触ってよいのは **step 3 だけ**（step 1 の main 反映後に起こす）。

**申し送り（cycle 24 総括より）**:
- **前サイクルの誤り記録を必ず読んでから着手する**（cycle 24 step 5 は「記録を読んだうえで再発させた」。
  記録を読むだけでは足りず、**機械で落ちる形にする**こと）。
- **パイプの後ろで `$?` を取らない**（`${PIPESTATUS[0]}` を使う）。cycle 24 step 4 は
  **ENOENT で失敗した PDF 生成を `exit=0` と読み違えた**。
  より一般に **「ツールがエラーを出さなかったこと」を成功の根拠にしない**。
- **訂正（step 1）→ Lean 検算（step 3）→ 本文（step 4）の順序を守る。**
  cycle 24 はこの順序のおかげで偽の主張を本文に一度も入れずに済んだ。
- 1 本のスクリプトの壁時計上限は 20 分以内。負荷判断は `uptime` でなく `top` の CPU idle。
- **step の前提そのものが一次情報と食い違うことがある。着手時に根拠 report を読んで前提を裏取りし、
  違っていたらそう報告すること**（cycle 22 step 3 で実際に起きた）。

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | 運用 | fix_q5_c1_and_g2_cond32 | done | 2026-08-01 | `outputs/reports/cycle25_ops_fix_q5_c1_and_g2_cond32.md`。**cycle 24 step 5 の新規検出 2 件を、いずれも定義・規約の側で塞いだ。** (1) **補題 Q5 の $c_1$ を定義ごと差し替えた**——「$2b<(\ell-1)\ell^{c}$ を満たす**最小の自然数**」＝$\mathbb{N}$ 上の決定可能な述語の最小元にしたので、**実対数（＝ℝ 脱出）と $b=0$ の縮退が同時に消えた**。証明も $b=0$（このとき $r=0$・$\mathcal{B}_M=\emptyset$）と $b\ge1$ に分け、**狭義不等式だけから** $\rho_{\max}\ge M-c_1$ を出す形に書き直した。**$b=0$ は仮想の場合ではない**——母集団 461 組の（塔, $\ell$）のうち **317 組（68.8%）が $b=0$**（$\ell=11$ では 96 組中 95 組）で、**初稿の定数は測定対象の 7 割で定義されていなかった**。新旧の関係も証明（$b\ge1$ で $c_1^{新}\le c_1^{旧}$ ⇒ 上界 $r\ell^{c_1}$ も定理 Q1 の $C$ も悪化しない）。**最小性は必要**（上界が等号で達成される塔が実在: `FAM p=5 q=6`, $\ell=3$ で $|\mathcal{B}_M|=3=r\ell^{c_1}$）。$c_1$ を使う全 10 箇所を洗い出して新定義で成り立つことを確認（定理 Q1 は $b=0$ で $C=\theta_G^{\max}\frac{\ell+1}{\ell}$ に退化し**自明な数え上げと一致**、系 G6 とも整合）。**cycle 24 step 1 が書いた「$+1$ の役割」と反例（$\ell=2,b=1$）は「その $c$ が候補集合に入らない」という形へ読み替わる**（新旧とも $c_1=2$）。(2) **定理 G2 $(3.2)$ に $\infty$ の引き算の規約を明記**（$m^\sharp_k=\infty$ なら差を $-\infty$ と読み条件は自動成立）。**規約が無いと何が壊れるかを計算で示した**——$\min\emptyset=0$ で読むと $(3.2)$ は $\ell\ge4$ を要求し、**§6.1 が機械照合している $\ell=3$ が落ちて $M^*=1$ が正当化できなくなる**。両読みの一致は cycle 24 の `G2_cond32_sum_form_top` / `_finite` による。**副産物: 定理 G3 の実対数 $\lceil\log_\ell(e_{j^*}+1)\rceil$ を「$\ell^\lambda\ge e_{j^*}+1$ なる最小の自然数」へ書き換えた**（本文は cycle 24 step 4 が書き換え済みで、**根拠 report だけが古い形で残っていた**）。訂正後、両 report の ℝ 脱出は補題 Q0 の 1 箇所だけ（**初稿の §7.3 の「ただ 1 箇所」は当時は事実と食い違っていた**旨も明記）。**自分の誤りを 4 件記録**（うち 2 件は記録済み誤りの再発——訂正文を台帳の照合範囲の内側に書いて転記検査を赤くした／シェルの cwd 持ち越しで同じ失敗を 2 回）。**呼び出し元の検証**: $c_1$ の新定義について**素数 6 個 $\times\ b\le200$ の全 1200 組で独立に計算**し、狭義不等式・最小性・$b=0\Rightarrow c_1=0$・$b\ge1$ で $c_1^{新}\le c_1^{旧}$ を**違反 0** で確認（一致 23 組、新が真に小さい 1177 組）。$\ell=2,b=1$ で新旧とも $2$ になることも一致。**$\min\emptyset=0$ の読みで $\varphi(3)=2\not>2$ ＝ $\ell=3$ が落ちること**も独立に計算。引用された Lean 定理名 5 件（`Q5_logb_junk_at_b_zero` 等）が**実在すること**も確認。そのうえで**自分の作業ツリーで** `npm run check`（12 段・exit 0。転記検査 違反 0・失効した免除 0・照合したアトム 158 件/語 183 件・検出テスト **12/12**）と `verify-check-linkage.ts`（exit 0）を再実行。本文・`lean/`・検査道具に差分が無いことも確認。 |
| 2 | 運用 | guard_missing_proof_and_rotten_refs | done | 2026-08-01 | `outputs/reports/cycle25_ops_guard_missing_proof_and_rotten_refs.md` / `structured-latex/tools/{proof-debt,verify-proof-completeness,reference-rot-model,reference-rot-allowances,verify-reference-rot,verify-guards-detection-test}.ts`。**cycle 24 総括が「検査で守られていない負債」と名指しした 2 つの穴を塞いだ。** **検査 C（証明の欠落）**: 「`kind` が `theorem` か `claim` なら証明を持たなければならない」を規則にした。**根拠は 3 つとも一次情報**——システムの種別が 5 つしかなくそのうち証明されるべき事柄を述べるのは 2 つだけ／**現在の本文が既にその境界どおりに書かれている**（`proof` を持つ 16 ブロックは全部 `theorem`/`claim`、`definition`/`remark` の 18 は 1 つも持たない）／CLAUDE.md の命名規則。**実測は「証明なし 7 件」**（命題 M・U だけでなく命題 G′・G″・J・K・R も）で、**step の前提だった「2 件」は誤りだった**（サブエージェント自身が最重の誤りとして記録）。既知の未了は cycle 24 step 3 の免除と同じ思想で**宣言**にし、**宣言 1 件につき 6 つを機械検証**する——ブロックの実在／**いまも証明が無いこと**（証明が入ったら「宣言が余っている」で赤）／引用がちょうど 1 文に当たること／**その文が実際に未了を述べていること**／**原本の在処が転記検査の台帳と一致すること**（宣言だけ別の出所を名乗れない）／**原本の report に証明が実際にあること**（消えたら赤）。**検査 R（腐ったツール参照）**: 69 ファイル・参照 438 件を走査し、**実在しない参照 54 件**を検出。**うち 29 件は本当に腐っている**（`outOfScope` 型で「直すべきものとして記録」。直れば宣言が余って赤になる）。**cycle 24 step 2 で呼び出し元が手で見つけた腐り（撤去済み `ja-en-exceptions.ts` を現在形で指す記述、相対パスの深さの誤り）が実データとして挙がる**＝検出を実証。走査から外した場所（`outputs/reports/`・`MEMORY.md`・`auto-loop-state.md`・`_old/`）と**その理由・件数を毎回出力**する（`MEMORY.md` だけで実測 20 件を対象外にしている）。**自分の誤りを 5 件記録**（最重は**一次情報を見る前に設計を決めたこと**——「id とラベルを列挙してから設計に入れ」と指示されていたのに「2 件」の前提で型を書き始め、実測 7 件で書き直した）。**呼び出し元の検証**: `package.json` の変更が**検査段の追加だけで既存段の削除・緩和を含まない**こと、`source-links.ts` の変更が**撤去済みツールを指すコメントの訂正だけ**（＝本 step の検査 R が拾う種類の腐りを直したもの）であることを差分で確認。**検出テストに頼らず自分で 2 通り壊して赤を実測**した——(a) 免除を 1 件消す → 「説明のつかない腐り 1 件」で exit 1、(b) 宣言済みブロックに証明を入れる → 「宣言が余っている（証明が入った）」で exit 1、いずれも復元で exit 0 に戻る。証明なし 7 件が**自分の独立集計（定理型 23 − 証明あり 16）と一致**することも確認。そのうえで `npm run check`（**15 段に増えて exit 0**。転記検査 違反 0・検出テスト 12/12／検査 C 未宣言 0・失効した宣言 0／検査 R 説明のつかない腐り 0）を自分で再実行した。**限界（report §8 に明示）: 検査 R は実在するかしか見ない／検査 C は証明が空でないことしか見ない／いま緑なのは検査が強い証拠ではない。** **申し送り: 本文担当の step 4 が (a) 命題 M・U に証明を入れたら宣言を消すこと、(b) `outOfScope` に記録された本文側の腐りを直すこと。残り 5 件（命題 G′・G″・J・K・R）の証明は別 step の負債。** |
| 3 | 運用 | lean_cycle25 | done | 2026-08-01 | `outputs/reports/cycle25_ops_lean_cycle25.md` / `lean/IntegrableLattice/Cycle25Corrections.lean`。**10 サイクル目。今回は本文と根拠 report の数学的な食い違いを検出しなかった**——本文 1174 行を全読し、**本文にしか無い言い回し 6 箇所**（(U1) の係数の式が (M3)+(M4) から出るか、(M4) の角括弧と (U2) の $T_\mathrm{def}$ の一致、(U4) の数値 2 組、(M2) の「値は $\lceil\log\rceil$ に等しい」という括弧書き、(U6) の切り捨て付値列）を型で照合し、**すべて根拠から従った**。「何を見て無いと言えるのか」を report §3.0 に書いてある。**代わりに申し送り 2 件**: (1) **この step の指示の前提が事実と違った**——呼び出し元は「既存の `lemma_Q5_rho_max` は旧定義向けの仮定になっているはず」と書いたが、**同定理は狭義不等式そのものを仮定に取っており $c_1$ の定義の仕方に依存していなかった**（新定義版は既存補題へ渡すだけ・本体 1 行）。(2) 軽微——本文 (U6) の条件「$N>\max\Lambda_k$」の $\Lambda_k$ は一般に非整数（本文 (M2) 自身が $j^*/\varphi(\ell^k)$ と書いている）のに、命題 U 冒頭が「$\varphi(\ell^k)\Lambda_k$ は非負整数」としか書かないので誤読しうる。**通したのは 33 宣言**: 訂正後の $c_1$ の存在・一意性・$b=0$・訂正 report §3.1 の表の独立再計算・**旧定義のジャンク値 1 が最小でないこと**・$b=0$ での定理 Q1 の退化形が既存の層分解定理から出る自明な数え上げと一致すること。**$\min\emptyset=0$ の読みでは §6.1 の $\ell=3$「だけ」が落ちる（$\ell=5,7$ は落ちない）ことも型に出した**——**1 つだけ落ちるから 9 サイクル通り抜けた**、というのが規約明記が必要であることの形式的な証拠になる。新規に通したのは $A_\mathrm{gen}$ のレベル非依存性（README が「配線」として未形式化に挙げていたもの）と (M2) の括弧書き。**射程は正直に限定**（$\beta_P=\infty$ の枝は $M-c_1\le M$ という帳簿上の不等式にすぎない、(U6) は整数値付値＝$k=0$ の場合のみ）。**自分の誤りを 3 件記録**（最重は **`field_simp` の後の不要な `ring` を 2 箇所——cycle 23 が記録し cycle 24 が「記録を読んだうえで再発させた」と書いた誤りの 3 サイクル連続の再発**。着手前に該当箇所を全読したうえで再発しており、「読んだら守れるという前提が間違っている」と構文レベルの禁止として書いた。逆側の誤り（`norm_num` が閉じきると決めつけて足りない）が 2 箇所あり、**両者が同じ手順の表と裏である**ことも記録）。**呼び出し元の検証**: `check-no-sorry.sh` の差分が **37 行追加・0 行削除**（削除行 0 を実測）で検査を緩めていないこと、新規モジュールに `sorry` が 0 件であることを確認。$\min\emptyset=0$ の読みで **$\ell=3$ のみ落ち $\ell=5,7$ は落ちない**ことを独立に手計算して Lean の主張と一致を確認。そのうえで**自分の作業ツリーで**（gitignore された依存が無いので、`lake-manifest.json` と**同一リビジョン** `520045a` の mathlib を別 worktree から複製して復旧し）**`lake build` を再実行して `Build completed successfully (8679 jobs)`・exit 0**、**`check-no-sorry.sh` で 327 定理（公理を出力する 322 ＋ 公理なし 5）すべて sorryAx 非依存・exit 0** を再現した（報告値と一致）。 |
| 4a | 運用 | reflect_five_proofs | done | 2026-08-01 | `outputs/reports/cycle25_ops_reflect_five_proofs.md` / `structured-latex/content/{005b,005c,008,009_s_infinity_decision,009_theta_recursion}.ts` ＋ 英語ロケール同名 5 ファイル。**命題 G′・G″・J・K・R の 5 ブロックへ原本の証明を日英同時に運んだ。検査 C の宣言は 7 件 → 2 件**（残るのは命題 M・U で step 4b の担当）。**本文に無い補題への依存は 5 ブロックとも「使う前に補題の主張を述べる」で処理し、射程を限定して逃げた箇所は 0 件**（総和公式のように本文に無いものは、本文にある命題 W の証明の積の公式から導出する形で書いた）。**作業中に本文の既存の不備を 2 件検出**（主張の文言を触らない方針なので証明の中で明示するに留めた）: (a) 命題 G′ (G′2) の「直線上の点の寄与」は**原本が置く仮定 $\theta^*-m_1<\ell-1$ を本文が書いていない**、(b) **命題 K (K5) の主張に実対数の床関数 $\lfloor\log_\ell e_{m_u}\rfloor$ が残っている**（cycle 24 step 4 由来）。**担当範囲の外へ 1 件出た**——転記検査の再現データ 1 件が古くなって赤になった（**証明が入って $A_1$ が statement だけでなく proof にも現れるようになったため、「statement から落とす」だけでは事故を再現できなくなった**）ので、落とす対象を `A_1\equiv0` ちょうどから `A_1` を含む数式すべてへ広げて 12/12 に戻した。**自分の誤りを 5 件記録**（うち 2 件は記録済み誤りの再発——英語版で数式をまたぐ強調を書いて PDF 生成を落とした／既存の書き方を読む前に書いた）。**呼び出し元の検証**: **`source-links.ts` の 20 行削除が「台帳の削除」ではなく免除（`acknowledged`）2 件の削除＝検査を厳しくする変更**であることを差分で確認（証明が入って本文に $e_m$・$\psi_u$ が実在するようになったため免除が不要になった）。`proof-debt.ts` の削除がちょうど 5 件の宣言であること、再現データの変更が**検出を弱めず適応させたもの**であることも確認。**原本と本文の突き合わせを自分で実施**——定理 J2 の証明の骨格（$(a,b)\mapsto(a+\ell^Lu,b+\ell^Lv)$ ／ Lucas の定理による $m<\ell^L$ での不変性／$m=\ell^L$ での $N_L\mapsto N_L+(pu+qv)$ ／最後の等号が $A_1\equiv0$）が**一段ずつ本文へ運ばれていること**を原本と読み合わせて確認した。そのうえで `npm run check`（15 段・exit 0。転記検査 違反 0・失効した免除 0／検査 C **証明あり 21 件・証明なし 2 件**・未宣言 0／検査 R 説明のつかない腐り 0／検出テスト **12/12** と **24/24**）、**`build:pdf`（日本語 40 頁）と `build:pdf:en`（英語 52 頁）**（いずれも未解決参照 0・組めない文字 0・ノート混入 0。**ブロック 46 件・証明 21・TODO 0**）、`verify-check-linkage.ts`（exit 0）を**自分で再実行**した。**(b) の実対数は方針（ℝ 脱出の隔離）に反するので次サイクルへ送らず step 4b の担当に加えた。** |
| 4b | 運用 | reflect_proofs_and_q_series | done | 2026-08-01 | `outputs/reports/cycle25_ops_reflect_mu_and_q_series.md` / `structured-latex/content/{009_s_infinity_decision,009c_drop_assumption_b_star,010_general_closed_form}.ts` ＋ 英語ロケール。**6 項目すべてを完了し、本文の証明の欠落が 0 件になった。** (A) **命題 M・U の証明**を原本（cycle 21 定理 G1–G4・系 G5/G6、cycle 22 定理 D1–D6・命題 D1a）から対応表つきで運んだ。**訂正前の形は機械走査で 0 件**（旧 $c_1$ の実対数・$M^*$ 条件 2 の余分な `+1` など 4 パターンを grep）。外部依存は証明冒頭に (a)–(e) の 5 項目として主張の形で全部書き、**射程を限定して逃げた箇所 0 件**（step 4a と同じ水準）。(B) **Q 系を新章として日英同時に新設**（命題 K と命題 M の間）。$c_1$ は cycle 25 step 1 の訂正後の定義、$b=0$ の場合分けあり、**ℝ 脱出は (Q4)＝補題 Q0 の 1 箇所に隔離して `realEscape` に宣言**。(C) **命題 K (K5) の実対数を除去**——$r_0$ の $\lfloor\log_\ell e_{m_u}\rfloor$ を「$\ell^{\lambda}>e_{m_u}$ なる最小の自然数」へ。**$+1$ の置き場所で値が変わる**ので $\lambda_u=\lfloor\log_\ell e_{m_u}\rfloor+1$ を経由して一致を証明し本文にも書いた（$1$ を加える操作が $\max$ と可換であることを使う）。**新しい書き方は $e_{m_u}=0$ でも意味を持つ**（床関数の形は $\log_\ell 0$ で定義されない）。本文全体を走査（数式ノード 3879 件）し、**真の ℝ 脱出は命題 Q の 1 ブロックだけ**であることを確認。(D) 本文側の腐った参照 12 件を修正（免除 52→**40** 件、「本当に腐っている」29→**17** 件）。(E) 命題 U 冒頭に「整数なのは $\varphi(\ell^k)\Lambda_k$ であって $\Lambda_k$ ではない」を明記（step 3 の申し送り）。(F) `PROOF_DEBTS` **0 件**。**担当範囲外に 1 ファイル触った**（`verify-guards-detection-test.ts`）——**`PROOF_DEBTS` が空になるとテストが基準の宣言を失って例外で落ちる**ため、基準を固定値へ移した。腐らせ方 9 通りは 1 つも減らしていない。**自分の誤りを 5 件記録**（最重は**英語版で数式ノードをまたぐ強調を書いて PDF 生成が落ちた 3 サイクル連続の再発**。日本語版では同じ形が通るため「原文で通っている形をそのまま訳す」手順を取ると必ず踏む、と構造として記録し、早い段で落とす検査を申し送りにした）。**呼び出し元の検証**: 検出テストの変更が**基準の固定化だけで腐らせ方を減らしていない**ことを差分で確認。**本文の実対数を自分で全走査**し、残る 22 件がすべて (i) 宣言済み ℝ 脱出の $\log_\ell C_0$（補題 Q0）、(ii) 新旧の書き方の一致を示す証明中の記述、(iii) 「値は $\lceil\log_\ell(e_{j^*}+1)\rceil$ に等しい」という括弧書きの注記、のいずれかであって**定義には実対数が使われていない**ことを文脈ごと確認。訂正前の形が 0 件であることも独立に grep。そのうえで `npm run check`（15 段・exit 0。**検査 C 証明あり 24 件・証明なし 0 件・宣言 0 件**／転記検査 違反 0・失効した免除 0／検査 R 説明のつかない腐り 0・免除 40／検出テスト **12/12** と **24/24**）、**`build:pdf`（日本語 **50 頁**）と `build:pdf:en`（英語 **64 頁**）**（**ブロック 48/55 件・証明 24・TODO 0**・未解決参照 0・組めない文字 0・ノート混入 0）、`verify-check-linkage.ts`（exit 0）を**自分で再実行**した。 |
| 5 | — | rank:cycle25 | done | 2026-08-01 | 下記「cycle 25 総括」。**掲げた 4 点はすべて潰れ、さらに前提の誤りが実測で 1 件見つかったのでサイクル内で埋めきった**（証明の欠落は 2 件ではなく 7 件だった）。**本文の証明の欠落が初めて 0 件になった。** cycle 26 の焦点は 4 点。 |

**step 4 を 4a・4b に分けた理由（2026-08-01 追記）**: step 2 の検査 C が実測したところ、
**証明を持たない定理型ブロックは cycle 24 総括が想定した 2 件（命題 M・U）ではなく 7 件だった**
（命題 G′・G″・J・K・R も主張だけで本文に入っていた）。
**step 列を起こした時点の前提が一次情報と食い違っていた**（cycle 22 step 3 と同型の事象）。
残り 5 件を次サイクルへ送らず本サイクルで埋めるため、step 4 を 2 つに分けた。
4a（5 件）は step 3 の Lean 検算の結果に依存しないので並行して走らせ、
4b（命題 M・U と Q 系）は訂正 → Lean 検算 → 本文の順序を守って step 3 の後に起こす。
**担当ファイルは重ならない**（4a は `010_general_closed_form.ts` を触らない）。

## cycle 25 総括（rank:cycle25, 2026-08-01）

**掲げた 4 点はすべて潰れた。本サイクルの主題は「検査を作ったら、その検査が前提の誤りを暴いたので、
サイクルの中で埋めきったこと」である。**

### 論文本体から証明の欠落が消えた（step 2 → 4a → 4b）

- cycle 24 総括は「本文に証明が入っていないのは命題 M・U の 2 件」と書いていた。
  **step 2 が検査 C を作って実測したら 7 件だった**（命題 G′・G″・J・K・R も主張だけで入っていた）。
  **step 列を書いた時点の私（呼び出し元）の前提が一次情報と食い違っていた。**
- **次サイクルへ送らず、step 4 を 4a（5 件）と 4b（命題 M・U ＋ Q 系）へ分けて本サイクルで埋めた。**
  結果、**証明を持つべき 24 ブロックすべてが証明を持ち、既知の未了の宣言は 0 件になった**
  （`PROOF_DEBTS` が空。以後、証明のない `theorem`/`claim` は宣言を足さない限り赤になる）。
- 論文は日本語 30 → **50 頁**、英語 41 → **64 頁**（未解決参照 0・ノート混入 0）。
- **証明を運ぶ作業が、主張だけでは見えなかった穴を 2 つ出した**——
  step 4a は**原本が置いているのに本文が書いていなかった仮定**を 1 件見つけて明示し
  （命題 G′ の「例外直線 1 本の寄与」に $\theta^*-m_1<\ell-1$ が要る）、
  step 4b は (U6) の $\Lambda_k$ が整数と誤読されうる書き方を塞いだ。
  **「主張は運べていても証明は運べていない」状態が、実際に誤りを隠していた。**

### ℝ 脱出が、本文全体でただ 1 箇所に隔離され、そう明示された（step 1 → 4a → 4b）

- **step 1 が補題 Q5 の $c_1$ を定義ごと差し替えた**——「$2b<(\ell-1)\ell^{c}$ を満たす最小の自然数」。
  **実対数（ℝ 脱出）と $b=0$ の縮退が同時に消えた。** $b=0$ は仮想ではなく**母集団 461 組の 68.8%**で、
  **初稿の定数は測定対象の 7 割で定義されていなかった。**
- **同 step は、初稿が「ℝ 脱出は補題 Q0 ただ 1 箇所」と書いていたこと自体が当時は事実と違ったと訂正した。**
  記録が自分について誤っている場合があるという実例である。
- step 4b が**命題 K の $r_0$ に残っていた実対数を除去**した（$\lfloor\log_\ell e\rfloor$ →
  「$\ell^{\lambda}>e$ なる最小の自然数」）。**値が変わらないことを計算して証明の中に書いている**
  （呼び出し元も独立に確認: $\max(1+V,\lfloor\log\rfloor+1)=1+\max(V,\lfloor\log\rfloor)$ で恒等）。
- 結果、**本文で非可算側へ出るのは Q 系の (Q4)（粗上界。複素絶対値）ただ 1 箇所**であり、
  本文がそう宣言している（`realEscape`）。**プロジェクトの方針が、書き換えとして完了した状態になった。**

### 検査の穴を 2 つ塞いだ（step 2）

- **検査 C（証明の欠落）**: 「`theorem`/`claim` は証明を持たねばならない」。
  規則の根拠は**新しい約束事ではなく、既に守られていた区別を機械が読める形にしたもの**
  （`proof` を持つ 16 ブロックは全部 `theorem`/`claim`、`definition`/`remark` は 1 つも持たない）。
- **検査 R（腐ったツール参照）**: 参照 438 件を走査し、**実在しない参照 54 件**を検出。
  **cycle 24 step 2 で呼び出し元が手で見つけた腐り（撤去済みツールを現在形で指す記述）が実データとして挙がった**
  ＝検出の実証。step 4b が本文側 12 件を直し、**「本当に腐っている」は 29 → 17 件**になった。
- 両検査とも**免除・宣言が腐ったら赤くなる**（cycle 24 step 3 の思想を踏襲）。
  **走査から外した場所と件数を毎回出力する**（`MEMORY.md` だけで 20 件を対象外にしている）。

### Lean が 10 サイクル連続で仕事をした（step 3）

- 訂正 6 件はすべて塞がり、**新しい $c_1$ の定理群（`C1Set` / `Q5_c1_isLeast` / `Q5_c1_zero_of_b_zero` /
  `Q5_rho_max_of_isLeast`）がすべて $\mathbb{N}$ 上で閉じ、`Real` を 1 つも使わない**ことで
  ℝ 脱出の除去が型の上で確認された（`Real` が現れるのは**旧定義との比較**と
  $\lceil\log\rceil$ との値の一致を述べる定理だけである。呼び出し元が出現箇所を 1 つずつ確認した）。
- **ジャンク値を排除しているのは狭義不等式ではなく最小性**だと特定した（旧定義は $b=0$ で $1$ を返し、
  それは候補ではあるが最小ではない）。
- **$(3.2)$ の規約の必要性を形式的に確認**——$\min\emptyset=0$ の読みでは $\ell=3$ だけが落ちる。
- **cycle 24 step 4 が書いた「実対数へ書き換えても値は変わらない」という括弧書きを、誰も確かめていなかった。**
  step 3 が型に出して確定させた。
- **step 3 は、私が書いた step の前提の誤りを 1 件検出した**（既存 Lean の仮定は $c_1$ の定義に依存していなかった）。
  **前提の誤りは 2 サイクル連続で起きている**（cycle 22 step 3、本サイクル step 2・step 3）。

### 運用

- 各 step が**自分の誤りを 3〜5 件記録**した。**記録済み誤りの再発が今回も複数あった**
  （転記検査の range の内側に訂正文を書く／シェルの cwd 持ち越し）。
  **cycle 24 の結論「記録を読むだけでは足りず、機械で落ちる形にしないと再発する」が今回も裏付けられた。**
- **「止まっている」という判断が、一次情報で覆った事例が 1 件あった。** step 3 の Lean 検算が
  「存在しないログの `EXIT=` を待つ `until` に入り、実際のビルドが無いまま停滞している」と見えたが、
  **一次情報を取ると `lake build` は動いていた**（PID が存在し、`lean` ワーカー 17 本、
  45 秒で `.olean` が 8660 → 8673 に増加、ログも 0 → 12.8 KB）。
  古い待機ループが空ログを見ていたのは事実だが、その後**同じファイルに対してビルドが起動し直されていた**ので、
  両ループは `EXIT=` の追記で同時に解放される状態だった。
  **ここで待機を強制解除していれば、稼働中の mathlib ビルドを壊すか、検算していない結果を完了と偽ることになった。**
  → **教訓: 「プロセスが無い」は、プロセス表と生成物の増加を見てから言う。** 生存確認と進捗確認を分ける。
- **呼び出し元の作業ツリーに gitignore された依存（mathlib）が無く、`lake exe cache get` の初回クローンが
  2 回とも途中で壊れた。** ディスクは 116 GiB 空いており容量問題ではない。
  **`lake-manifest.json` と同一リビジョン（`520045a`）の mathlib を別 worktree から複製して復旧**し、
  そのうえで `lake build`（8679 jobs）と `check-no-sorry.sh`（327 定理）を独立に再現した。
  **プロセスの停止は 1 件も行っていない**（`pkill` は使っていない）。

### cycle 26 の焦点（案）

1. **Lean 11 サイクル目——今度は「証明そのもの」を検算する。** これまでの 10 サイクルは
   根拠 report と本文の**主張**を検算してきた。本サイクルで**証明が本文に入った**ので、
   検算の対象が変わる。とくに Q 系（(Q4) の ℝ 脱出の隔離が本当に 1 箇所か）と、
   step 4a・4b が運んだ 7 件の証明。
2. **残る「本当に腐っている」参照 17 件を直す**（本文外＝`tools/`・`docs/`・runbook 側）。
   検出はできているので、直して免除を消す作業である。
3. **3 サイクル連続で持ち越されている未検証項目 2 件を閉じる**——
   `cycle22_T3_coefficients_d_e.md` §3 注 3.1（$T_\mathrm{def}=0$ の 108 本で $(1.1)$ が $n=0$ から成り立つか）、
   `cycle21_T3_general_closed_form.md` §6.3（「$n=1$ から完全に一致する」が定理の保証範囲外）。
   **持ち越し回数を数えているのは、記録が読まれずに沈むのを防ぐためである。**
4. **転記検査の残る弱点**——「照合対象が 0 件だったブロック 5 件」と
   「機械検証できない免除 14 件（report の位置づけの言葉）」。件数は毎回出しているが、減らせていない。
5. **3 サイクル連続で再発している誤りを、記録ではなく検査にする。** 対象は少なくとも
   (a) **英語ロケールで数式ノードをまたぐ強調**（cycle 24 step 4 → 25 step 4a → 25 step 4b。
   **日本語版では同じ形が通るので「原文で通っている形をそのまま訳す」手順を取ると必ず踏む**）、
   (b) **`field_simp` の後の不要な `ring`**（cycle 23 が記録 → 24 が「記録を読んだうえで再発」→ 25 で 3 回目）。
   **「記録を読む」を手順に入れても止まらないことが 3 サイクルで確定している。**
   `npm run check` の早い段で落とすこと（step 4b の申し送り）。
6. **命題 G′ (G′2) が原本の仮定 $\theta^*-m_1<\ell-1$ を主張に書いていない**（step 4a が証明を運ぶ過程で検出。
   証明の中では明示したが、主張には入っていない）。主張へ入れる。

### 方針判断点（ユーザー価値判断・未決。cycle 21 から持ち越し）

論文 001 の「新規性を主張しない」宣言を維持するか。既出性の判定は cycle 23 で出そろっている
（$b$ の式・判定手続きの中核は既出、$l_0$ の局所構造に関する部分は文献に無い）。**自動ループでは決めない。**
本サイクルでも変更していない。

## cycle 24 step 列（2026-08-01 起こし。cycle 23 総括の「cycle 24 の焦点（案）」4 点をそのまま step にした）

**前提**: cycle 23 で 4 点のうち 3 点が潰れ、本文反映だけがユーザー方針変更で保留になった。
その方針の前提だった「`structured-latex` にローカライズ概念を実装する別ゴール」は
**2026-08-01 に `530dfcb` として main に入った**（`structured-latex/README.md` の「ローカライズ」節、
`codegen/structured-text-index/locales.ts`、`domain-model/resolved/resolve-localized.ts`）。
したがって本サイクルは**本文反映を再開できる**。ただし再開の条件として、
**旧来の日英二重管理（`structured-latex-en/` が独立プロジェクトとして schema・tools・生成物を複製している状態）を
増やしてはならない**——先に英語版をローカライズモデルへ移す（step 2）。

**担当を分ける（衝突回避）**:
- `outputs/reports/` の訂正を行うのは **step 1 だけ**。
- `structured-latex-en/` と `structured-latex/locales.config.ts` を触ってよいのは **step 2 だけ**。
- `structured-latex/tools/verify-transcription*.ts`・`source-links.ts` を触ってよいのは **step 3 だけ**。
- 本文（`structured-latex/content/`）を触ってよいのは **step 4 だけ**（step 1・2 の main 反映後に起こす）。
- `lean/` を触ってよいのは **step 5 だけ**（step 1 の main 反映後に起こす）。

**申し送り（cycle 23 総括より）**:
- **前サイクルの誤り記録を必ず読んでから着手する**（cycle 23 step 2 は cycle 22 report が既に記録していた
  誤りをそのまま繰り返した。記録は読まれなければ効かない）。
- 1 本のスクリプトの壁時計上限は 20 分以内。負荷判断は `uptime` でなく `top` の CPU idle。
- **step の前提そのものが一次情報と食い違うことがある。着手時に根拠 report を読んで前提を裏取りし、
  違っていたらそう報告すること。**

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | 運用 | fix_grounding_reports | done | 2026-08-01 | `outputs/reports/cycle24_ops_fix_grounding_reports.md`。**8 件すべて訂正し、特定できなかったものは無い**。(1) **定理 D2 の最後の一文（偽）**を、レベル $n$ での成立 $\iff S(n)=T_\mathrm{def}$／$n=0$ での成立 $\iff T_\mathrm{def}=0$／全 $n\ge0$ $\iff\delta_M=0$（真に強い）へ差し替え、証明も残差計算へ直し、**反例を明記**（射程の限定＝実在の塔で符号が混ざる例は未確認、も踏襲）。(2) 定理 D3 の 2・定理 D5 の $\min$ に **$A_m\ne0$ の $m$ に限る規約（$v_2(0)=+\infty$）**を明記し、$p=1$（$\ell=2$ トーラス）で $\Lambda_1=2,\theta^\sharp_1=0$ を書いた。(3) **定理 G4 §5.3 の条件 2 の $+1$ を落とした**（$\sum_{r=r^\sharp}^{M-K-1}\varphi(\ell^{M-r})=\ell^{M-r^\sharp}-\ell^K$ は $M=r^\sharp+K$（層が空）でも両辺 $0$ で成立。**初稿は §6.1 で自分の条件 2 を破っていた＝内部の食い違い**で、正しいのは §6.1 の側）。(4) 定理 Q1 の $C$ が $|\mathcal{B}_M|$ を含み **$M$ 依存だった**のを補題 Q5 の上界 $r\ell^{c_1}$ 代入形へ（$\log_\ell C_0\ge0$ を確認）。(5) 補題 Q5 の $c_1$ の $+1$ が**狭義不等式 $2b<(\ell-1)\ell^{c_1}$ のため**であることと、$+1$ 無しの反例（$\ell=2,b=1,c_1=1,M=3$）を追記。(6) 注 4.2 に $K\to K+1$ の**打ち消し計算**を追記（$\varphi(\ell^{K+1})-\ell^{K+1}+\ell^K=0$）。(7) 補題 Q0 の適用に要る $\tilde E(\omega_P)\ne0$ が **(H) から従う**ことを証明に明示。(8) `cycle22_T3_cuoco_monsky_attribution.md` の **p.248 → p.252**（「詳細」の参照先は学位論文でなく [2,5]、$m_0\leftrightarrow[1]$・$l_0\leftrightarrow[5]$ の対応も明記）。**訂正は初稿の記述を消さず、いつ・どの Lean 検算が何を検出したかを各所に併記**した。**自分の誤り 3 件を記録**（最重は置換対象を行の途中で切って文を壊したこと。逸脱ログ 2026-07-26 の教訓どおり編集後に読み直して検出・是正）。**呼び出し元の検証**: 4 本の report の差分を全読し、(3) の $\sum\varphi$ 恒等式・(6) の打ち消し・(5) の反例（$2b\ell^{\rho_{\max}}=4=(\ell-1)\ell^{M-1}$ かつ $M-c_1=2>1$）・(2) の $p=1$ で $c=2\mathcal{L}-2=4$ を独立に計算して一致を確認。**本文・`lean/`・検査道具・英語版に差分が無いことを確認**した。 |
| 2 | 運用 | localize_english_edition | done | 2026-08-01 | `outputs/reports/cycle24_ops_localize_english_edition.md`。**`structured-latex-en/` の独立プロジェクト複製（schema・生成物・package.json・tsconfig・生成器・検査ツール 17 ファイル）を撤去**し、`structured-latex/locales.config.ts` ＋ `locales/en/` の翻訳ロケールへ寄せた。日英対応検査は自前の比較器（331 行）をやめ、システムの `validateLocalizedRevision` へ載せ替え。**そのためにシステム側へ allowance（差を 1 件ずつ理由つきで説明する仕組み。免除の単位は差分 1 つ）を実装**した（不変条件 I8a–I8d）。自前検査の 8 不変条件は 1 つも失わず、参照先・引用キー・ノード位置・行内/別行立ての別が**新たに検査対象**になった。載せ替えで初めて見えた差 1 件（`paper_101_theorem_digit_branch` の数式が英語版で別行立てに変わっていた）を検出。弱くなった点（22 ブロックで位置の一致を免除。旧検査と同じ強さ）を report §5 に明示。検出テストは 1325/1325 件で違反を実測。**日本語本文の差分 0、英語本文の文言差分 0**（`git diff -M` で実証）。中断前の report にあった検証出力 2 件が実測と食い違っていたのを自分で検出し実測へ訂正（転記検出テスト 3/3→**12/12**、孤立検証ディレクトリ 2→**10 件**）。**呼び出し元の検証**: (a) 日本語本文の差分 0 と、英語本文 14 ファイルが **`import` 行と `origin.path` 以外 1 行も変わっていない**ことを 1 ファイルずつ diff して確認。(b) **移動した英語本文 12 ファイルの先頭コメントが、撤去済みの `verify-ja-en-correspondence.ts`・存在しない `npm run verify:correspondence`・誤った相対パスを指したまま腐っていた**のを検出し、**呼び出し元が修正**（`001_intro.ts` の「現状は 2 ブロックだけ」という古い記述も実態＝全ブロック揃いへ直した）。**移行で「本文の文言を変えない」を守ると、本文中のツールへの参照は自動では直らない**——これは次サイクルで機械検出の対象にすべき腐りである。(c) 修正後に**システム側 `npm run check`（exit 0・負テスト 16 ケース）／プロジェクト側 `npm run check`（12 段すべて緑）／`verify-localization`（違反 0）／`verify-localization-detection-test`（**1325/1325**・cycle 21 型の脱落 11/11）／`verify-transcription`（違反 0・失効した免除 0）／`verify-transcription-detection-test`（**12/12**。step 3 の成果を壊していない）／`verify-check-linkage`（OK）**を自分で再実行した。 |
| 3 | 運用 | exemption_rot_guard | done | 2026-08-01 | `outputs/reports/cycle24_ops_exemption_rot_guard.md` / `structured-latex/tools/{transcription-model,source-links,transcription-fixtures,verify-transcription*}.ts`。**免除 91 件すべてに機械検証できる根拠（`grounds`）を必須フィールドとして持たせ、根拠が動いたら赤くなる検査 A′ を新設した。** 根拠は「根拠 report のこの文」「本文のこの記述」「分担先のこのブロック」「参照先のこの記録」を指す。共通検査は 2 つ——引用が report の**ちょうど 1 文**に当たること、**その文が実際にその項目を生むこと**（抽出は検査 A と同じ関数を使うので、根拠が根拠になっていない状態は緑で通らない）。**`grounds` を 1 件消すと型検査が落ちる**ことを実際に確認（`TS2741`）＝「91 件を一括で根拠なしにして緑を維持する」は書けない。**型ごとの検出可否を正直に出した**: 分担 11 件 ◎（分担先が項目を失う／消えることまで確かめられる唯一の型）／記法 17・report 陳腐化 1・本文の不備 1 は ○／弱い主張 19・言い換え 23・例示の省略 5 は △（両側の実在は見るが**含意関係・同一性は検証できない**）／**位置づけの言葉 14 件は ✕＝機械検証できない**。この 14 件を**毎回件数として出力**する（cycle 23 の「照合力 0 のブロック 5 件」と同じ思想）。**移行で実際に赤が 1 件出た**（引用が 10 文字で pin になっていなかった）。**「全件通るのは根拠を現在の状態から起こした以上当然で、免除が健全な証拠ではない」と report に明記**し、実証を 2 本立てにした——過去版（2026-07-30）の report での実測（A′ の追加検出 0 件。既存の目印機構が先に止める）と、**腐った免除を 9 通り作る検出テスト（12/12 検出）**。step 1 の main 反映後に取り込んで再実行し、失効 0 件（**理由は「訂正が転記に影響しなかった」からではなく、D 系列がまだ本文に無く台帳が訂正済み report を参照していないから**——露出は step 4 から始まる）。**自分の誤りを 4 件記録**（最重は**検出テストで、通したい検査経路と違う経路で赤くなっているのに実証したつもりになりかけた**こと。同じ誤りをサイクル内で 2 回）。**呼び出し元の検証**: 差分を全読し、`violations` に A′ の検出が実際に加算されていること・`grounds` が型で必須であることを確認したうえで、`verify-transcription.ts`（**違反 0・未確認 0・免除 91・失効 0・機械検証できない 14・照合力 0 のブロック 5**）、`verify-transcription-detection-test.ts`（**12/12**）、`npm run check`（exit 0。負テスト込み）、`validate-content.ts`（43 ブロック・89 参照解決）を**自分で再実行**した。本文・英語版・`lean/`・既存 report に差分が無いことも確認。 |
| 4 | 運用 | reflect_g4_and_d_series | done | 2026-08-01 | `outputs/reports/cycle24_ops_reflect_g4_and_d_series.md` / `structured-latex/content/010_general_closed_form.ts` ＋ `structured-latex/locales/en/content/010_general_closed_form.ts`（新規）/ `structured-latex/tools/source-links.ts`（**登録追加のみ**。step 3 report §10 が step 4 へ明示的に引き渡した仕事で、step 3 は done なので衝突しない）。**第 11 章として 2 ブロックを日英同時に入れた**——命題 M（一般の塔の閉形式。cycle 21 定理 G2・G3・G4・系 G5・G6 ＋ §5.3 の $M^*$ 明示形）と命題 U（cycle 22 定理 D1–D6・命題 D1a ＋ §4 の 3 層階層）。**step 1 の訂正 3 件はすべて訂正後の形で入っており、訂正前の形は本文に残っていない**——(a) 定理 D2 は **3 分岐**（レベル $n$ ⟺ $S(n)=T_\mathrm{def}$／$n=0$ ⟺ $T_\mathrm{def}=0$／全 $n\ge0$ ⟺ $\delta_M=0$ で真に強い）＋反例＋反例の射程の限定まで、(b) $\min$ を $A_m\ne0$ の $m$ に限る規約（$v_\ell(0)=+\infty$）を **(M1)・(U4)・(U5) の 3 か所**へ、しかも**なぜ書き落とせないか**（$v_\ell(0)=0$ で読むと $p=1$ の塔で $c$ が壊れる）まで、(c) $M^*$ の条件 2 は **$+1$ 無し**で、かつ「層が空でも閉形式は成り立つ」を和の等式ごと明示。**step 5 の新規検出 2 件のうち 1 件を穴を塞いだ形で入れ、1 件は入れなかった**——定理 G2 $(3.2)$ の $m^\sharp_k=\infty$ は差を $-\infty$ と読んで条件が自動成立することを理由つきで (M1)・(M5) へ書いた（step 5 の別解＝和の形は採らず、両読みが一致することは `G2_cond32_sum_form_top` が確認済み）。補題 Q5 の $c_1$ は**塞げないからではなく、Q 系が論文本体に 1 ブロックも無く入れる場所が無いから**入れていない（申し送りは report §9）。**台帳へ 2 ブロックを 13 passage（12 個は主張の引用だけ `quotedOnly`）で登録し、免除 0 件・未確認 0 件**（アトム 34・語 16 を照合）。**訂正ブロックは range の外で切った**（訂正の記録は主張ではない＝step 3 の申し送り (a) と同じ方針）。被覆 31/32 → **33/34（97%）**。**ℝ 脱出は無い。そのことを本文に明示**し、定理 G3 の $\lceil\log_\ell(e_{j^*}+1)\rceil$（実対数）を「$\ell^\lambda\ge e_{j^*}+1$ なる最小の自然数」へ**書き換えて除去**した（step 5 が $c_1$ について示した除去と同型）。**呼び出し元の検証**: 台帳への追記が **`quotedOnly`（main に既存の機能。主張だけを見る）と range の絞り込みだけで、検査を緩める変更を含まない**ことを差分で確認し、本文の定理 D2 の 3 分岐・反例・射程の限定が**訂正後の report と一字一句の対応で運ばれている**ことを読み合わせた。そのうえで**自分の作業ツリーで**システム側 `npm run check`（exit 0）／プロジェクト側 `npm run check`（**12 段すべて exit 0**。転記検査 違反 0・**新規 2 ブロックは免除 0・未確認 0**・照合したアトム 124→**158**・語 163→**179**・検出テスト 12/12）／`verify-check-linkage.ts`（exit 0）／**`build:pdf`（30 頁・未解決参照 0・ノート混入 0）と `build:pdf:en`（41 頁・未解決参照 0・ノート混入 0）を、終了コードを `${PIPESTATUS}` で取り違えない形で両方実行**した。**ℝ 脱出が無いことも本文で確認**（(M2) の $\lambda$ は「$\ell^\lambda\ge e_{j^*}+1$ なる最小の自然数」として定義され、実対数の形は「値が等しい」という注記としてしか現れない）。**自分の誤りを 3 件記録**（最重は §8.3——パイプ後の `$?` が `tail` の終了コードを拾い、**ENOENT で失敗した PDF 生成が `exit=0` に見えていた**。`${PIPESTATUS[0]}` へ是正）。**限界: 本章は主張と限界だけで `proof` が空。原本の証明はまだ運んでいない**（転記検査は主張しか見ないので赤にならない。report §9 に申し送り）。 |
| 5 | 運用 | lean_cycle24 | done | 2026-08-01 | `outputs/reports/cycle24_ops_lean_cycle23_corrections.md` / `lean/IntegrableLattice/Cycle24Corrections.lean`。**9 サイクル目。今回は「前サイクルの指摘を訂正が本当に塞いだか」を検算する回で、6 件すべて塞がった**。(a) **定理 D2**: 訂正後の 3 分岐（レベル $n$ ⟺ 部分和 $=T_\mathrm{def}$／$n=0$ ⟺ $T_\mathrm{def}=0$／全 $n\ge0$ ⟺ 過渡が一切無い）が全部通り、**訂正のほうが cycle 23 の Lean 版より精密**（「$T_\mathrm{def}=0$」を連言の片方でなく帰結として置くのが正しい）。(b) **D3/D5 の規約**: 型に出すと $p=1$ で $c=4$ が復旧し、**旧規約では復旧しない**（`D3_old_conv_c_broken`）＝規約の明記は必要かつ十分。(c) **G4 条件 2**: 訂正後の条件だけでなく、照合先 §6.1 の $M^*=1$ が**条件 1〜5 すべてを満たす**ことまで確認＝内部矛盾は完全に消えた。(d) 注 4.2 の打ち消しは**初稿にも前サイクルの Lean にも無かった側を含めて両側**、補題 Q5 の狭義性、定理 Q1 の明示定数（前サイクルが $\theta_G^{\max}$ の係数を 2 に緩めていたのを report 記載のまま組み直し）、補題 Q0 の非零性——いずれも塞がった。**新たに検出した問題 2 件（本文も既存 report も直していない＝次サイクル step 1 の対象）**: (1) **実質的**——補題 Q5 の定数 $c_1$ が **$b=0$ で定義されない**（$\log_\ell 0$）。$b=0$ は仮想でなく**同じ report の系 G6（$S_\infty$ が空）がまさにその場合**。**副産物として、$c_1$ を「$2b<(\ell-1)\ell^c$ を満たす最小の自然数」と定義し直せば実対数（ℝ 脱出）と $b=0$ の縮退が同時に消える**——決定可能な述語なので最小元が取れる＝**プロジェクトの方針（ℝ 脱出の隔離）と直接合致する改善**。(2) 軽微——定理 G2 の条件 $(3.2)$ が $\infty$ になりうる量の引き算を含み読み方が本文に無い（**今回訂正した D3/D5 と同型の穴が同じ report に残っている**。両方の読みが一致するので実害なし）。**新たに通した定理**: 系 G6（$S_\infty$ が空の 5 係数）と系 Q7（$\ell=2$ トーラスの標数 2 因数分解）。**射程は正直に限定**——Q7 は**因数分解の恒等式だけ**を型に出しており、$r=2$（2 因子が既約・非同伴）は未形式化（2 変数 Laurent 環が mathlib に無いことを 3 段検索で確認）。したがって `Q7_b_eq_two` は $1+1=2$ という**帳簿上の恒等式にすぎない**（report §3.2 が自分でそう書いている）。**自分の誤りを 3 件記録**（最重は `field_simp` の後の不要な `ring` ＝ **cycle 23 が記録済みの誤りの再発**。記録を着手前に読んでおきながら再発させたので「記録は読まれなければ効かない」の一段先の問題として書いた）。**呼び出し元の検証**: `check-no-sorry.sh` の変更が**明示ターゲット表への 27 件追加のみで検査を緩めていない**ことを差分で確認したうえで、**自分の作業ツリーで mathlib を取得し直して `lake build`（8678 jobs = 前サイクル 8677 ＋ 新規 1 モジュール）と `check-no-sorry.sh`（exit 0、列挙した定理はすべて sorryAx 非依存）を再実行**した。`lake-manifest.json` に差分なし＝依存 revision 不変。 |
| 6 | — | rank:cycle24 | done | 2026-08-01 | 下記「cycle 24 総括」。**掲げた 4 点すべてが潰れ、cycle 23 で保留になった本文反映が完了した**。cycle 25 の焦点は 4 点。 |

## cycle 24 総括（rank:cycle24, 2026-08-01）

**掲げた 4 点はすべて潰れ、さらに cycle 23 が方針変更で保留した本文反映まで完了した。
本サイクルの主題は「前サイクルまでに溜まっていた負債を、順序を守って一気に落としたこと」である。**

### 偽と判定された主張が、本文に入る前に直り、Lean で塞がったことを確認できた（step 1 → step 5）

- cycle 23 の Lean 検算が「**定理 D2 の最後の一文は偽**」と判定していた。step 1 がこれを
  **レベル $n$ ⟺ 部分和 $=T_\mathrm{def}$／$n=0$ ⟺ $T_\mathrm{def}=0$／全 $n\ge0$ ⟺ 過渡が一切無い**
  の 3 分岐へ直し（証明も残差計算へ差し替え、反例と**その反例の射程の限定**まで書いた）、
  **step 5 がその訂正後の主張をそのまま形式化して通した**。
- 同じ流れで 6 件（D2・D3/D5 の規約・G4 の条件 2・Q1 の明示定数・Q5 の狭義性・注 4.2 の打ち消し）が塞がった。
  G4 の条件 2 は**同じ report の §6.1 が自分の条件を破っていた内部矛盾**で、step 5 は
  「§6.1 の $M^*=1$ が訂正後の条件 1〜5 をすべて満たす」ところまで確認した。
- **「Lean 化を本文反映より先に回す」という cycle 23 の教訓が、そのまま step の順序として機能した。**
  訂正（step 1）→ 検算（step 5）→ 本文（step 4）の順で回したので、**偽の主張は本文に一度も入っていない。**

### 日英二重管理を撤去した（step 2）。cycle 23 の停止理由そのものを消した

- cycle 23 の本文反映は「日本語正本を変えると英語版への反映と日英対応検証が必須＝本文反映は翻訳と不可分」
  という理由で止まっていた。**その構造自体を解消した。**
  `structured-latex-en/` という独立プロジェクト（schema・生成物・生成器・検査ツールの複製 17 ファイル）を撤去し、
  英語版を**同じ文書の別ロケール**（`structured-latex/locales/en/`）にした。
- 自前の日英比較器 331 行は、システム側の構造照合＋**差を 1 件ずつ理由つきで宣言する allowance** へ分解した。
  **旧検査の 8 不変条件は 1 つも失わず**、参照先・引用キー・ノード位置・行内/別行立ての別が新たに検査対象になった。
- **弱くなった点 1 件（22 ブロックで骨格ノードの位置一致を免除）を隠さず記録**している。
- **呼び出し元が、移動した英語本文 12 ファイルのコメントが撤去済みツールを指したまま腐っているのを検出して直した。**
  → **「本文の文言を変えない」を守ると本文中のツール参照は自動では直らない。**次サイクルの機械検出の対象。

### 免除が腐ったら赤くなるようになった（step 3）

- 転記検査の**免除 91 件すべてに機械検証できる根拠を必須フィールドとして持たせた**（消すと型検査が落ちる）。
  根拠が動けば違反になる。**型ごとの検出可否を正直に出し、位置づけの言葉 14 件は「機械検証できない」と
  毎回件数で出す**（cycle 23 の「照合力 0 のブロック 5 件」と同じ思想）。
- **「全件通るのは根拠を現在の状態から起こした以上当然で、免除が健全な証拠ではない」と自分で書き**、
  過去版での実測と**腐った免除を 9 通り作る検出テスト（12/12）**に分けて実証した。

### 主結果がついに論文本体に入った（step 4）

- 第 11 章＝**命題 M（一般の塔の閉形式。5 係数すべて）＋命題 U（係数の情報階層）**を日英同時に入れた。
  cycle 21・22 の主結果が、cycle 23 の保留以来はじめて本文に入った。
- **step 1 の訂正 3 件はすべて訂正後の形で入り、訂正前の形は本文に残っていない。**
  $\min$ の規約は**なぜ書き落とせないか**（標準規約で読むと $\ell=2$ トーラスで係数が壊れる）まで本文にある。
- **step 5 の新規検出 2 件のうち 1 件は穴を塞いだ形で入れ、1 件（補題 Q5 の $c_1$）は入れなかった**——
  塞げないからではなく、**Q 系が本文に 1 ブロックも無く入れる場所が無いから**。次 step への申し送り。
- **ℝ 脱出は無い。** 定理 G3 に残っていた実対数を「$\ell$ の冪の比較」へ書き換えて除去した
  （step 5 が $c_1$ について示した除去と同型＝**プロジェクト方針が実際の書き換えとして働いた**）。
- **正直な限界: 本章は主張と限界だけで `proof` が空。原本の証明はまだ運んでいない。**
  **転記検査は主張しか見ないので、この未了は赤にならない**（＝検査で守られていない負債である）。

### 運用

- **9 サイクル連続で Lean が根拠 report の問題を検出した**（今回は「訂正が塞いだことの確認」＋新規 2 件）。
- 各 step が**自分の誤りを 3〜4 件記録**した。最重は step 4 の
  「パイプ後の `$?` を取ったため、**ENOENT で失敗した PDF 生成が成功に見えていた**」。
  **cycle 15 の「ツールがエラーを出さなかったことを成功の根拠にしない」と同型の誤りが再発している。**
- 一方で step 5 は「前サイクルが記録済みの誤りを、記録を読んだうえで再発させた」と書いた。
  **記録を読むだけでは足りず、機械で落ちる形にしないと再発する**——step 3 が免除について実装したのと同じ話が、
  作業手順そのものにも当てはまる。
- **レートリミットによる中断が 2 回起きた**（step 2・step 4）。いずれも worktree に未コミットの作業が
  残った状態で止まったが、**同じ worktree で続きを引き継いで完遂できた**。中断は成果を失わせていない。

### cycle 25 の焦点（案）

1. **命題 M・U の証明を本文へ運ぶ**（step 4 の未了）。**主張だけを入れた章が転記検査で赤くならないこと自体が
   検査の穴**なので、証明の欠落を検出する仕組みも併せて考える。
2. **step 5 が検出した 2 件の訂正**（補題 Q5 の $c_1$ を「$2b<(\ell-1)\ell^c$ なる最小の自然数」へ、
   定理 G2 $(3.2)$ の読み方）と、**Q 系を本文へ入れる**こと。1 と同じ章に入る。
3. **本文・ツール間の腐った参照の機械検出**（step 2 で呼び出し元が手で見つけた種類の腐り。
   存在しないファイル・スクリプトを指す記述を検査で落とす）。
4. **Lean 化の継続（10 サイクル目）**——本文へ入った命題 M・U と、まだ通していない定理群。

### 方針判断点（ユーザー価値判断・未決。cycle 21 から持ち越し）

論文 001 の「新規性を主張しない」宣言を維持するか。既出性の判定は cycle 23 で出そろっている
（$b$ の式・判定手続きの中核は既出、$l_0$ の局所構造に関する部分は文献に無い）。**自動ループでは決めない。**

## cycle 23 step 列（2026-08-01 起こし。cycle 22 総括の「cycle 23 の焦点（案）」4 点をそのまま step にした）

**前提**: cycle 22 で掲げた 4 点はすべて潰れたが、**本文への反映 step を持たなかった**ため
未反映の結果が溜まっている。残るのは
(a) **cycle 21 定理 G4 と cycle 22 定理 D1–D6 が本文に入っていない**。しかも
**その前に定理 G4 §5.3 の $M^*$ 条件 2 を訂正する必要がある**（cycle 22 step 4 が内部矛盾を検出。
正しいのは同 report §6.1 の側）、
(b) **転記検査の台帳被覆が定理型 32 ブロック中 8（25%）**で、残り 24 は検査 A の対象外、
(c) **定理 W4 と (K3) の既出性は Cuoco の学位論文（Brandeis, 1979）が未読**のまま、
(d) **cycle 22 の新定理群（定理 D1–D6）が Lean に通っていない**（8 サイクル目の検算）。

**担当を分ける（衝突回避）**:
- `structured-latex/content/` と `structured-latex-en/content/`（本文）を触ってよいのは **step 1 だけ**。
  **根拠 report の訂正（定理 G4 §5.3）も step 1 が行う。**
- `structured-latex/tools/`・`structured-latex-en/tools/`（検査道具と台帳）を触ってよいのは **step 2 だけ**。
  ただし **step 1 が新設したブロックの台帳登録は step 1 が行う**ため、**step 2 は step 1 の main 反映後に起こす**。
- step 3・4 は本文もツールも触らない（report・lean だけ）。

**運用上の申し送り（cycle 22 で判明した指標の読み違いを反映）**:
- **1 本のスクリプトの壁時計上限は 20 分以内**（3 サイクル連続で有効）。
- **負荷の判断に `uptime` の負荷平均を使わない。`top` の CPU idle を使う**（cycle 22 step 4）。
- **打ち切りは「その回の実行の限界」でありうる**（cycle 22 step 3 の打ち切りは再実行で塞がった）。
  打ち切ったら、原理的な限界なのか実行時間の問題なのかを区別して書く。
- **step の前提そのものが一次情報と食い違うことがある**（cycle 22 step 3）。
  **着手時に根拠 report を読んで前提を裏取りし、違っていたらそう報告すること。**

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | 運用 | reflect_g4_and_d_series | blocked(policy) | | **2026-08-01 のユーザー方針変更により中断した。** 英語版（`structured-latex-en/`）への変更を全面停止し、**`structured-latex` にローカライズ概念を実装する別ゴールが main に入るまで翻訳を再開しない**という方針が出たため。**現在の仕組みでは日本語正本を変更すると英語版への反映と日英対応検証が必須**で、英語版に触れずに進めると検証が赤になる＝**本文反映は翻訳と不可分**である。したがって cycle 23 では実施しない。**作業内容は失っていない**——中断時点の成果（根拠 report の訂正と、本文への新ブロック `010_general_closed_form.ts` の日英両方、台帳登録）は worktree `cached-discovering-moore` のブランチ `worktree-cached-discovering-moore` に **WIP コミット `12d15bd` として保全**した（**push していない。main へ反映していない**）。**中断は SIGTERM による停止で、リポジトリ配下にスコープした安全な kill（名前パターン一括ではなく cwd で対象を限定し自己と祖先を除外）で行った。** **再開時の注意**: (a) cycle 22 step 4 が挙げた定理 G4 §5.3 の条件 2 の訂正が未完了、(b) **cycle 23 step 4 が定理 D2 の最後の一文を偽と判定した**ので、**D 系列を本文へ移す前にその訂正が必要**、(c) cycle 23 step 3 が `cycle22_T3_cuoco_monsky_attribution.md` §4 の頁番号の誤り（p.248 → **p.252**）を検出しており、これも未訂正。 |
| 2 | 運用 | ledger_coverage | done | 2026-08-01 | `outputs/reports/cycle23_ops_ledger_coverage.md` / `structured-latex/tools/source-links.ts`。**被覆を 8/32（25%）から 31/32（97%）へ上げた**（23 ブロックを新規登録）。**前提は自分でツールを回して裏取り**してから着手している。**登録できなかったのは 1 件だけ**（序論の位置づけ）で、理由は根拠 report が存在しないこと——全 49 本の report を検索し、該当しそうな 1 本は**本文を読んで書き写した表＝向きが本文→report** なので転記事故の検出に使えない、と確認したうえで見送った（**確認せずに「無い」と書いていない**）。検査 A が挙げた 120 件を、range を「定理の主張だけ」に絞って 54 件に落として**全件 1 件ずつ判定**し、**免除 69 件を型つきで記録**（記法の選択／本文のほうが弱い主張／ブロック間の分担／report が自分の作業を位置づける言葉／例示の省略／言い換え／report のほうが古い 1 件）。**本文の不備 1 件を検出**（既知結果の注記で「本文未読」の明示が同じ論文の別注記と揃っていない）——**方針変更で本文は保留中なので触らず**、直し方を report に書き、免除理由にも「本文が直すべきものとして記録済み」と書いた。**黙って緑にしない工夫**: 台帳に載っても range に条件文が無く**照合力 0 のブロックが 5 件**あることを発見し、**毎回その件数と id を出力する集計行を追加**した。**自分の誤りを 5 件記録**（最大は **cycle 22 report §10.1 が既に記録していた誤り（range を広く取ると使い物にならない）をそのまま繰り返した**こと）。**ユーザー方針（英語版の変更全面停止）を守り、`structured-latex-en/` と本文の diff は空**。**呼び出し元の検証**: `verify-transcription.ts` を再実行し **違反 0・未確認 0・照合したアトム 124 件／語 163 件・免除 91 件・照合力 0 のブロック 5 件**、台帳が**定理型の 97%（31 ブロック）**であることを出力で確認。`npm run check`（検出テスト 3/3 を含む）・`validate-content.ts`・`verify-check-linkage.ts` も再実行し、**英語版・本文に差分が無いことを diff で確認**した。 |
| 3 | T3 Pure | cuoco_thesis_acquisition | done | 2026-08-01 | `outputs/reports/cycle23_T3_cuoco_thesis_acquisition.md`。**既出性は決着した。しかも学位論文を読まずに済んだ。** 決め手は **Monsky *Some invariants of $\mathbb{Z}_p^d$-extensions* (1981) の p.229 と p.233 の直読**——p.229 は「Cuoco, **[2]**, introduced an invariant $m_0$」「**To tackle this we introduce an invariant $l_0(L/k)$**」と書き、**[2] は Cuoco 1980（Compositio Math.）であって学位論文ではない**。p.233 の References は**全 5 件で学位論文を 1 件も含まない**。すなわち **$l_0$ は Monsky が 1981 年に導入した不変量**であり、**(K3) も定理 W4 も $l_0$ の局所構造の主張だから 1979 年の学位論文にはありえない**。推論の残り穴 2 点も明示（帰属記述からの演繹であって読了ではない）。**Cuoco 1980 は全文 pp.415–437 を通読**し、精密に記述される不変量は $m_0$ だけで $n$ の係数 $m_1$ は定義されるだけ＝(K3)・W4 に当たるものは無いことを確認。**学位論文そのものは入手できず**、試した経路（ProQuest・Brandeis 機関リポジトリ・HathiTrust・WorldCat・著者本人）と失敗理由を一次情報で具体化し、**課金は不可逆なので進めていない**（ユーザーが取れる手段 4 つを URL・識別子つきで report §2.1 に用意）。**step の前提の誤りを 2 件検出**: 指示と cycle 22 report が言う「CM は **p.248** で詳細について学位論文を指す」は誤りで、**当該文は p.252、しかも学位論文は「originally introduced」の側にしか挙がらず、詳細の参照先は [2,5]（どちらも読める）**。**自分の誤りを 5 件記録**（最重は **OCR 出力をそのまま引用文として書いた**こと。3 ページを画像で直読して照合し直した）。**呼び出し元の検証**: **Monsky p.229 と p.233 のページ画像を自分で取得して直読し、$l_0$ の導入文と References 5 件（学位論文なし）を独立に確認**した。指示どおり本文・検査道具・MEMORY・state を触っていない。 |
| 4 | 運用 | lean_cycle22_theorems | done | 2026-08-01 | `outputs/reports/cycle23_ops_lean_cycle22_theorems.md` / `lean/IntegrableLattice/CoefficientsDE.lean`。**8 サイクル連続で根拠 report の問題を検出した。** **最重要は「主張が偽」1 件——定理 D2 の最後の一文**「$T_\mathrm{def}=0\iff$ 閉形式が $n\ge0$ から成り立つ」の $\Rightarrow$ が成り立たない。**$T_\mathrm{def}$ は過渡欠損の総和なので、$0$ でも部分和が $0$ とは限らず、report の証明は総和から部分和へ飛んでいる。** Lean で残差を計算すると、レベル $n$ での成立は「部分和 $=T_\mathrm{def}$」と同値で、全 $n\ge0$ と同値なのは「過渡が一切無い」という真に強い条件、$T_\mathrm{def}=0$ 単独と同値なのは「$n=0$ の一点で成り立つこと」。反例も型に出した（**射程は正直に限定**——任意の $\Theta$ について偽であることは示したが、実在の塔で符号が混ざる例は未確認）。次に **「主張が一意に読めない」1 件**: 定理 D3 の 2（と定理 D5）の $\Lambda_1=\min(2,v_2(p-1))$ は、**$p=1$（＝主役の片方である $\ell=2$ トーラス）で $A_2=0$** になり、$v_2(0)=+\infty$ と読めば証明と整合するが **mathlib を含む標準の規約 $v_2(0)=0$ では $c=4$ が壊れる**。「$\min$ は $A_m\ne0$ の $m$ についてのみ」という規約が本文に無い。**境界の確認 1 件（食い違い無し）**: 定理 D6 の $N>\max\Lambda_k$ は**狭義であることが必要**で、$N=\max\Lambda$ に弱めると偽になる具体例を構成した＝report の書き方は正しい。**検証**: `lake build` **8677 jobs**（新規 1 モジュールを除く 8676 が cycle 22 と一致）、`check-no-sorry.sh` は **267 定理すべて sorryAx 非依存**（$267-36=231$ で cycle 22 の 231 個も再確認）。**mathlib は一発で取得でき `lake-manifest.json` に差分なし＝依存 revision 不変。** 負荷判断は指示どおり `top` の CPU idle（着手時 58.5%）で行った。「mathlib に無い」と書いた 4 件は 3 段検索を済ませ、0 でないヒットは中身を読んで別物と確認（**2 サイクル連続で再発していた誤りが本サイクルでは出ていない**）。**自分の誤りを 3 件記録**（最重は**未完成の主張を doc コメントに完成した体で書いた**こと。`sorry` を残したままでビルドが露見させた）。**この検出は結果的に決定的だった**——**step 1 が本文へ移そうとしていた対象そのもの**であり、方針変更で step 1 が中断されたため、**偽の主張が本文へ入る事故は起きていない**。 |
| 5 | — | rank:cycle23 | done | 2026-08-01 | 下記「cycle 23 総括」。**4 点のうち 3 点は潰れ、1 点（本文への反映）はユーザー方針変更で保留**。**最大の成果は、本文へ移す寸前の主張が偽だと Lean が検出したこと。** cycle 24 の焦点は 4 点。 |

## cycle 23 総括（rank:cycle23, 2026-08-01）

**掲げた 4 点のうち 3 点は潰れ、1 点（本文への反映）はユーザー方針変更で保留になった。
そして本サイクル最大の出来事は、その保留が結果として事故を防いだことである。**

### Lean が「本文へ移す寸前の主張」を偽と判定した（step 4）。8 サイクル連続

- **定理 D2 の最後の一文が偽である。** 「$T_\mathrm{def}=0\iff$ 閉形式が $n\ge0$ から成り立つ」の $\Rightarrow$ が
  成り立たない。**$T_\mathrm{def}$ は過渡欠損の総和なので、$0$ でも部分和が $0$ とは限らず、
  report の証明は総和から部分和へ飛んでいた。** 正しくは、レベル $n$ での成立は「部分和 $=T_\mathrm{def}$」と同値、
  全 $n\ge0$ と同値なのは「過渡が一切無い」という真に強い条件、$T_\mathrm{def}=0$ 単独と同値なのは
  「$n=0$ の一点で成り立つこと」。反例も型に出した。
- **定理 D3 の 2（と定理 D5）は一意に読めない。** $\Lambda_1=\min(2,v_2(p-1))$ は、
  **主役の片方である $\ell=2$ トーラス（$p=1$）で $A_2=0$** になり、$v_2(0)=+\infty$ と読めば証明と整合するが、
  **mathlib を含む標準の規約 $v_2(0)=0$ では $c=4$ が壊れる。**「$\min$ は $A_m\ne0$ の $m$ についてのみ」という規約が本文に無い。
- 定理 D6 の境界（$N>\max\Lambda_k$ が**狭義**であること）は正しいと確認した（弱めると偽になる例を構成）。
- **この 2 件は step 1 が本文へ移そうとしていた対象そのものである。** 方針変更で step 1 が中断されたため、
  **偽の主張が本文へ入る事故は起きていない。**

### 既出性の残りが決着した。しかも学位論文を読まずに（step 3）

- **Monsky (1981) p.229 と p.233 の直読が決め手。** p.229 は「Cuoco, **[2]**, introduced an invariant $m_0$」
  「**To tackle this we introduce an invariant $l_0(L/k)$**」と書き、**[2] は Cuoco 1980（Compositio Math.）**である。
  p.233 の References は**全 5 件で学位論文を含まない**。
- したがって **$l_0$ は Monsky が 1981 年に導入した不変量**であり、**(K3) も定理 W4 も $l_0$ の局所構造の主張だから
  1979 年の学位論文にはありえない。** 学位論文そのものは入手できていない（試した経路と失敗理由は report に一次情報で記録）。
- **step の前提の誤りを 2 件検出**（CM が学位論文を指すのは p.248 ではなく **p.252**、
  しかも「詳細」の参照先は学位論文ではない）。cycle 22 の report にも同じ誤記が残っている（未訂正）。

### 転記検査の被覆が 25% → 97% になった（step 2）

- 台帳を 8/32 から **31/32** へ。**登録できなかった 1 件も、根拠 report が存在しないことを
  全 49 本の検索で確認**してから見送っている（向きが本文→report の表しか無い＝検出に使えない）。
- 検査 A が挙げた 54 件を**全件 1 件ずつ判定**し、免除 69 件を型つきで記録。
- **黙って緑にしない工夫**: 台帳に載っても **range に条件文が無く照合力 0 のブロックが 5 件**あることを見つけ、
  **毎回その件数と id を出力する集計行を追加**した。
- **正直な限界**: 全体で**免除が 91 件**あり、検査の強さは免除の妥当性に依存している。
  免除の型は記録してあるが、**免除そのものを機械検証する手段は無い。**

### 本文への反映は保留（step 1）

- **2026-08-01 のユーザー方針変更**（英語版への変更を全面停止し、`structured-latex` に
  ローカライズ概念を実装する別ゴールが main に入るまで翻訳を再開しない）を受けて中断した。
- **現在の仕組みでは日本語正本を変更すると英語版への反映と日英対応検証が必須**であり、
  英語版に触れずに進めると検証が赤になる。**本文反映は翻訳と不可分**なので cycle 23 では実施しない。
- **中断時点の成果は失っていない**。worktree `cached-discovering-moore` のブランチに
  **WIP コミット `12d15bd` として保全**した（**push していない。main へ反映していない**）。
- 中断は、リポジトリ配下にスコープした安全な kill（名前パターン一括ではなく cwd で限定し自己と祖先を除外）で行った。

### 運用

- **8 サイクル連続で Lean が根拠 report の問題を検出している。** 本サイクルは**初めて「主張が偽」**を出した
  （これまでは仮定の過不足・曖昧さ・内部矛盾）。**Lean 化を本文反映より先に回す順序が正しい**ことの実例である。
- 前サイクルで導入した「負荷判断は `top` の CPU idle」は 2 本の step で守られた（着手時 58.5%・48.8%）。
- **step 2 は cycle 22 report が既に記録していた誤りをそのまま繰り返した**（range を広く取ると使い物にならない）。
  **記録は読まれなければ効かない。** 次サイクルは指示文へ「前サイクルの誤り記録を読む」を明示する。

### cycle 24 の焦点（案）

1. **未訂正の根拠 report をまとめて直す**（本文を触らずにできる）。対象は
   **定理 D2 の最後の一文（偽）**・**定理 D3/D5 の $v_\ell(0)$ 規約**・定理 G4 §5.3 の条件 2・
   定理 Q1 の「明示定数」・補題 Q5 の狭義不等式・注 4.2 の理由・補題 Q0 の非零性・
   `cycle22_T3_cuoco_monsky_attribution.md` の頁番号（p.248 → p.252）。
2. **ローカライズ概念の実装ゴールの進捗を確認し、入っていれば本文反映（step 1 の WIP `12d15bd`）を再開する。**
   入っていなければ本文には触らない。
3. **免除の妥当性を落とす仕組み**。転記検査の免除 91 件は検査の強さを直接左右するが、機械検証できていない。
   免除に有効期限や根拠行の指定を持たせる等、**免除が腐ったら赤くなる**設計を検討する。
4. **Lean 化の継続**（9 サイクル目）。訂正後の D 系列と、まだ通していない定理群。

### 方針判断点（ユーザー価値判断・未決。cycle 21 から持ち越し）

論文 001 の「新規性を主張しない」宣言を維持するか。**本サイクルで既出性の判定は出そろった**
（$b$ の式・判定手続きの中核はいずれも既出、$l_0$ の局所構造に関する部分は文献に無い）。**自動ループでは決めない。**

## cycle 22 総括（rank:cycle22, 2026-08-01）

**掲げた 4 点はすべて潰れた。ただし本サイクル最大の教訓は、そのうち 1 点が「前提そのものの誤り」
だったこと——step 列を書いた呼び出し元（私）が根拠 report を読み違えていた**（下記）。

### 既出性がさらに 1 つ決着した（step 1）

- 命題 K (K6)（$b$＝原始二項式部分の次数）へ **Cuoco–Monsky (1981) Definition 1.2 ＋ Theorem 1.7 の
  帰属を本文（日英）へ書き足した。**
- **未判定だった定理 W3 は「半分が既出」で決着**した。中核の同値は **Monsky, *Some invariants of
  $\mathbb{Z}_p^d$-extensions*, Math. Ann. 255 (1981) Lemma 2.3（$d=2$）と同じ内容**である
  （特殊化 $z\mapsto(1+T)^a,\ w\mapsto(1+T)^b$ の下で本文の $\theta$ と Monsky の $\lambda(G_a)$ が
  対応することを導出して同定）。一方 **(K3) の有限手続きと定理 W4（$j^*$＝重複度）は読んだ範囲に無い**
  （Lemma 2.3 の逆向きは $\lambda(G_a)\le r$ という**上界**しか与えない）。
- **読んだ範囲を本文に明示した**（CM 1981 全 24 ページ／Monsky *Some invariants* 全 5 ページ／
  Cuoco 1980 の一部）。**未読は Cuoco の学位論文（Brandeis, 1979）で「そこに無いとは言えない」**と書いた。
- 呼び出し元は **Monsky 1981 p.231 の原ページ画像を自分で取得して直読**し、引用の一致を独立に確認した。

### 転記事故がついに機械検出できるようになった（step 2）

- 事故 3 件（cycle 18・20・21）を形で分類し、**検査 A**（本文↔根拠 report の台帳照合。
  $\mu_\gamma$ と $\mu$ を別物として区別）と **検査 B**（添字族の裸使用）に分けた。
  **3 件を再現データに起こして 3/3 で検出**することを実証した（「エラーが出なかった」を根拠にしていない）。
- **例外表の穴を塞いだ**。免除の単位を**ブロックから差分 1 つへ**落とし、許す差の種類を宣言させる形にした。
  登録済み 11 ブロックの英語版の数式を 1 個ずつ落とす試験で **765/765 が違反**になる
  （**旧実装では 765 件すべてが黙って通っていた**）。
- **限界も明示された**: cycle 21 の命題 G″ の場合分け（未定義の記号を含む条件）は挙がらない。
  **転記検査は Lean 化の代わりにならない。** 台帳の被覆は定理型 32 ブロック中 8（25%）。

### 係数の構造が 3 層に確定した（step 3）。ただし step の前提は誤っていた

- **$d,e$ は cycle 21 定理 G4 で既に決まっていた。** step 列の「残るのが $d,e$」は
  **呼び出し元の読み違い**である（cycle 21 の検証コードは 5 係数すべてを返し 371 件照合していた）。
  残っていたのは値ではなく**構造の理解**だった。
- **定理 D1（分業）**: 捻り段データの付値側 $\Lambda_k$ は $c$ にだけ、位置側 $\theta^\sharp_k$ は $d$ にだけ入る。
  **$d$ は常に整数で、5 係数のうち最も局所的**（$c,e$ は非整数になりうる）。
  「次数が低いほど難しい」という直感は成り立たない。
- **定理 D2**: $e=v_\ell(\kappa(X))-a-c+T_\mathrm{def}$。**情報階層が 3 層に確定**した——
  $(a,b)$＝$\bmod\ \ell$ 層、$(c,d)$＝捻り段データ層、**$e$ だけがさらに過渡層を要する**。
  これが「どの追加情報が要るか」への答えである。
- **切れ目は $b$ と $(c,d,e)$ の間**（定理 D3）。**cycle 21 §9.1 の強化**——同 §9.1 の反例は
  $\tilde E$ への摂動だったが、ここは**実在の voltage グラフ 2 本**である。
- **さらに「どんな固定精度でも足りない」**（定理 D4・D5。$\bmod\ \ell$ どころか $\ell$ 進の任意有限桁で不足。
  位置側の障害は付値側の系ではない）。**逆向きの十分条件も取れている**（定理 D6）。

### Lean が根拠 report の内部矛盾を見つけた（step 4）。7 サイクル連続

- **定理 G4 §5.3 の $M^*$ 条件 2 が 1 つ強すぎ、同じ report の §6.1 が自分でその条件を破っている。**
  Lean で層の総和公式の成立条件を型に出したところ**正しいのは §6.1 の側**だった。
- ほかに「明示定数」が $M$ 依存だった件、根拠が書かれていない 2 件、暗黙の仮定 1 件、
  検証範囲の逸脱 1 件。**cycle 17 から 7 サイクル連続で問題を検出している。**
- **cycle 21 で確認できていなかった `lake build` を呼び出し元が独立に再現した**
  （8676 jobs、231 定理が sorryAx 非依存＝cycle 21 の 8674／196 を含む）。

### 運用: 指標の読み違いが 2 つ見つかった

- **負荷平均は CPU の空き容量を表さない。** step 4 の着手時 `uptime` は 582 だったが `top` の idle は 42.8% で、
  負荷平均は 9400 スレッドに引きずられていた。**cycle 21 の「負荷平均 432 で完走を確認できなかった」は
  指標の読み違いだった可能性が高い。以後この判断には `top` の idle を使う。**
- **報告された打ち切りが呼び出し元の再実行で塞がった。** step 3 の唯一の打ち切り（塔の値との照合が
  $\ell=5$ 未実施）は壁時計依存で、呼び出し元の再実行では **505 件・不一致 0 で $\ell=5$ まで完走**した。
  **打ち切りは「原理的な限界」ではなく「その回の実行の限界」でありうる。**
- 「1 スクリプト 20 分以内」の設計要件は本サイクルでも守られ、掃引起動直後のセッション終了事故は 0 件。

### cycle 23 の焦点（案）

1. **本文への反映**。**cycle 22 は本文反映 step を持たなかった**ので、cycle 21 step 2（定理 G4）と
   cycle 22 step 3（定理 D1–D6）が本文に入っていない。**その前に step 4 が見つけた
   定理 G4 §5.3 の条件 2 を直す**こと（report 側の訂正が先）。**step 2 が作った転記検査を
   実戦投入する初回**でもある。
2. **転記検査の台帳被覆を上げる**。現在は定理型 32 ブロック中 8（25%）で、残り 24 は検査 A の対象外。
3. **既出性の残り**。定理 W4 と (K3) は **Cuoco の学位論文（Brandeis, 1979）が未読**。入手できるか。
4. **cycle 22 の新定理群（定理 D1–D6）の Lean 化**。8 サイクル目の検算。

### 方針判断点（ユーザー価値判断）: 論文 001 をどうするか（cycle 21 から持ち越し・未決）

**残る判断は「新規性を主張しない宣言を維持するか」**である。本サイクルで位置づけはさらに鮮明になった:
**$b$ の式は既出（CM 1981）、判定手続きの中核も既出（Monsky 1981 Lemma 2.3）、
$c$ の式は Monsky が「no easy description」と書いた量の明示化、$(c,d,e)$ の情報階層は本プロジェクト独自。**
**ここは自動ループでは決めない。**

## cycle 21 総括（rank:cycle21, 2026-08-01）

**掲げた 4 点はすべて潰れた。本サイクルは「新しく証明する」より「自分たちの結果が文献のどこに
位置するかを確定させる」ことに最大の価値があった。**

### 既知性の確定（本サイクル最大の成果）

- **$n\ell^n$ の係数 $b=\sum j^*$ は Cuoco–Monsky (1981) Theorem 1.7 ＋ Definition 1.2 そのもの**で、
  $b$ は彼らの $l_0(F)$ と定義から一致する（step 1 が原文と対応表で照合）。
- 呼び出し元の確認: 引用された Definition 1.2（$l_0(F)=\sum\mathrm{ord}_P(\bar F_0)$、$P$ は $(\bar\sigma-1)$ の形）は、
  **cycle 20 step 2 の系 W6（$b$＝原始二項式部分の次数）と同じ内容**である。**系 W6 も既出。**
- 一方 **$\ell^n$ の係数 $c$ は、Monsky 1989 が存在と $d=2$ での有理性しか示さず
  「no easy description」と明記した量**であり、step 2 がそれを（voltage グラフの $\det L$ 型・$d=2$・(H)
  という限定の中で）明示式にした。**それでも新規性は主張していない**（文献調査が網羅的でないため）。
- **本文は全体として新規性を主張しておらず、第 5 章で既に Cuoco–Monsky Thm 1.7 を引用しているので
  偽の新規性主張は存在しない。** ただし命題 K への帰属の書き足しが要る（cycle 22 の焦点 1）。

### 潰れた 4 点

1. **仮定 (B\*)**（step 1）: $b$ については落ちた（定理 Q1）。**(B\*) が本当に効く場所も切り分けた**——
   $S_\infty$ の各点の最内側 $O(1)$ 個での付値の正確さで、$b$ には効かないが $c,d,e$ には効く。
   実測でも破れ 143 点は**すべて**その側で、等号が主張される 17781 点では 0 件。
   cycle 20 が「破れ率 23% までしか除外できない」と隔離した予想が**定理へ格上げ**された。
2. **一般の塔の閉形式**（step 2）: $c$ を明示式にした（定理 G4）。照合 1140 件＋371 件で不一致 0、
   **当てはめは一切なし（自由度 0）**。**取れないことも原理的に確定**——$(\Lambda_k,\theta^\sharp_k)$ を
   $\bar{\tilde E}$ だけから読む式は存在しない（$\ell=2$ トーラスに $2zw$ を足すと $\bar{\tilde E}$ も
   $S_\infty$ も不変なのに $\Lambda_1$ が変わる）。**$\ell^{2n}$ と $n\ell^n$ の係数だけが
   $\bmod\ \ell$ で決まるという切れ目**を確定させた。
3. **Lean 化**（step 3）: **6 サイクル連続で本文の問題を検出**。本文の不備 2 件・証明の根拠不足 1 件・
   過剰仮定 2 件・読み取りにくい箇所 1 件。ビルド 8674 jobs、**196 定理**が sorryAx 非依存（cycle 20 は 156）。
4. **本文への反映**（step 4）: 定理 Y′ を命題 G″ として新設し、残り 3 件は既に入っていることを
   根拠 report と 1 対 1 で突き合わせて確認。**記述の不備 1 件を検出・修正**（命題 R (R3) が
   report の但し書きを落として空集合上の max になっていた）。

### 「本文へ移す段で壊れる」型の事故が 3 回目

cycle 18（命題 N の例外集合）・cycle 20（桁定理の暗黙の仮定）に続き、本サイクルでも
**命題 R (R1) の係数の添字が落ちていた**（日英とも）。加えて **step 4 が移した命題 G″ の場合分けの
条件が、$\lambda_1$ が定義されない場合を含む形になっていた**（同一サイクル内で step 3 が検出）。
**いずれも根拠 report 側は正しい。** 呼び出し元が日英とも訂正し対応検証の違反 0 を確認した。

**対策として本サイクルで導入した「本文を触るのは 1 step だけ」は衝突回避には効いたが、
転記事故は防げていない。** 次は**移した直後に根拠 report と機械的に差分を取る**手順が要る。

### 検査の穴（本サイクルで実地に露見）

step 4 が英語版の整形中に**インライン数式ノードを 11 個落とし**、当該ブロックが
**数式差の例外表に登録済みだったため日英対応検証をすり抜けた**。step 4 自身が多重集合照合を書いて
検出・復元し、呼び出し元も独立に照合して 174 対 174 の一致を確認した。
**例外表への登録は検査に穴を開ける操作である**——この認識を運用に組み込む必要がある。

### 運用の改善と、残る課題

- **「1 スクリプト 20 分以内」という設計要件は効いた。** step 1 は 3 本とも 20 秒以内、
  step 2 は 3 本とも上限内で前景完走。**cycle 19・20 で 3 回再発した「掃引起動直後にセッションが
  終了する」事故は、本サイクルでは 0 件**。注意喚起ではなく設計要件にしたのが効いた。
- 呼び出し元の検証: sage を 6 本再実行（step 2 は**壁時計依存の打ち切り位置だけが揺れ**、
  実行できた範囲は不一致 0）、`lake build` と `check-no-sorry.sh` を再実行、
  日英の検査一式と対応検証を再実行し、さらに**日英の数式を独立に多重集合照合**（例外表が
  穴を開けていないことの独立チェック）。既知性の同定も**引用された原典の定義文**を読んで確認した。

### cycle 22 の焦点（案）

1. **Cuoco–Monsky への帰属を本文へ書き足す**。命題 K（$b$＝原始二項式部分の次数）は
   CM Definition 1.2 そのもの。**さらに cycle 20 の定理 W3・W4（判定手続き）が CM で既出かは
   CM §2 以降が未読で判定していない**（step 1 §13）。**読んで決着させる。**
2. **移した直後の機械的な突き合わせ手順を作る**。転記事故 3 回目を受けて、
   本文ブロックと根拠 report の対応を機械検証する道具を用意する（例外表の穴も併せて塞ぐ）。
3. **$d,e$ の係数**。$b$ は既出、$c$ は step 2 が出した。残りは Monsky の誤差項の外側で、
   step 2 が「$\bmod\ \ell$ では読めない」という切れ目を確定させているので、**どの追加情報が要るか**は分かる。
4. **cycle 21 の新定理群（定理 Q1・G4）の Lean 化**。7 サイクル目の検算。
   なお本サイクルでは `lake build` の再実行に約 2 時間半かかった（他セッションの並行ビルドで
   マシンの負荷平均が 432）。**Lean の検証を含む step は、他の重い作業と同時に走らせない**方がよい。

### 方針判断点（ユーザー価値判断）: 論文 001 をどうするか
英語版は別セッションで完成済み。**残る判断は「新規性を主張しない宣言を維持するか」**である。
本サイクルで位置づけがより鮮明になった: **$b$ の式は既出（CM 1981）、$c$ の式は
Monsky が「no easy description」と書いた量の明示化**。**ここは自動ループでは決めない。**

## cycle 20 総括（rank:cycle20, 2026-08-01）

**掲げた 4 点はすべて潰れた。しかも 3 点は「障害だと思っていたものが、道具の選び方を変えるだけで
消えた」という同じ形の決着をした。** cycle 19 が残した未解決 3 つ（打ち消し／$S_\infty$ の判定手続き／
$\ell=2$）は、いずれも**原理的な壁ではなかった**。

### 3 つの障害が同じ形で消えた

| 障害（cycle 19 の見立て） | 実際 |
|---|---|
| **打ち消し**: Newton 評価の $\mathrm{argmin}$ が同点になると $\theta$ が決まらない | 項を「寄与する位数」でまとめていたのが原因。**「指数の剰余類」でまとめ直すと干渉行列が下三角単位行列になり退化しえない**（定理 L1）。$\theta$ は常に決まる |
| **$S_\infty$ の判定**: 候補は尽くせるが各候補の判定手続きが族にしかない | $D$ の係数だけから $O(|S|^3)$ で決まる（定理 W3）。さらに **$j^*$ は $\bar{\tilde E}$ の二項式因子の重複度**という代数的な正体を持つ（定理 W4） |
| **$\ell=2$**: $S_\infty$ の点が $\bmod\ 2$ で分離されず仮定が破れる | **構造的に射程外ではない**。奇であることの 3 つの使用箇所は 3 つとも修復でき、族については閉形式が出る（定理 Y′）。$\ell$ 奇に無いのは**飽和**と**打ち消し**の 2 枝と、追加不変量 $w$ だけ |

**共通しているのは「$\theta$ をどの構造の上の関数と見るか、どの基底でまとめるか」を変えただけで
障害が消えた**ことである。cycle 19 が $\mathbb{P}^1(\mathbb{F}_\ell)$ から $\mathbb{P}^1(\mathbb{Z}_\ell)$ へ
移して前進したのと同じ型の前進が、本サイクルで 3 回起きた。

### 仮定が次々に落ちた（cycle 19 → cycle 20）

| 定理 | cycle 19 の仮定 | cycle 20 後 |
|---|---|---|
| 定理 B′（点ごとの付値） | 最小点が一意 | **不要**（定理 L4: 終結式で書ける） |
| 定理 K（予言アルゴリズム） | 同上 | **不要**（定理 K′） |
| 系 J3（$\theta$ の有界性） | コンパクト性（非構成的。どのレベルで止まるか言えない） | **係数から計算できる明示的上界**（系 L3′） |
| 定理 J7（$n\ell^n$ の係数） | (F)・(N)・(B\*) | (F) は cycle 19 で不要化、**(N) も不要**（系 W5）。**残るは (B\*) だけ** |

### 相互訂正が 3 件起きた（同一サイクル内・サイクル跨ぎ）

- **step 4 → cycle 19 step 2**: 報告書の例示 2 行が誤り（例外直線の本数を取り違え $\Lambda$ が半分）。定理本体は正しい。呼び出し元が独立計算で確認して訂正した。
- **step 4 → 論文本文**: 桁定理に**暗黙の仮定**（$A_1\equiv0$）があり、それ無しでは閾値ちょうどの段が偽（反例つき）。**根拠 report 側は正しく、本文へ移す段で落ちていた**（cycle 18 と同型の事故）。
- **step 2 → step 1**: 「(B\*) の破れは $\ell=2$ 固有」という読みが誤りで、奇素数の反例がある。
- **step 1 → 自分の課題設定**: cycle 19 が落としていた塔を止めていたのは、指示に書かれた障害とは**別の障害**だった。step 1 が cycle 19 の検証コードを読んで自分で見つけ、結果的に両方を潰した。

### 本サイクルの規律面での所見

- **「障害を反例つきで確定させる」運用が、次サイクルで確実に回収されている。** cycle 19 が §7 に
  「何が妨げているか」を具体化して残した 3 点が、そのまま本サイクルの 3 step になり全部潰れた。
  **「まだ出来ていない」で終わらせず障害を特定して書く**運用は機能している。続けること。
- **形式化は 4 サイクル連続で本文の問題を検出した**（cycle 17: 誤り、18: 誤り 2 件、19: 過剰仮定 2 件、
  20: 誤り 1 件＋暗黙の仮定 1 件＋過剰仮定 2 件）。**とくに「report は正しいのに本文へ移す段で壊れる」
  型が cycle 18 と cycle 20 で 2 回出た**。本文へ移すときは根拠 report と機械的に突き合わせること。
- **自分の誤りの記録が 3 step で計 8 件。** うち複数は「偽の結論を書きかけて検証で止まった」もので、
  **検証を書く前に結論を書かない**運用が効いている。
- **長時間ジョブの扱いは改善したが完全ではない。** cycle 19 の失敗を指示に明記した結果、step 2・3 は
  前景で完走した（step 3 は 7397 秒）。一方 **step 1 は再び掃引起動直後にセッションが終了**し、
  呼び出し元が完走を待って仕上げを別セッションで実行した。**指示だけでは防げていない。**
- 呼び出し元の検証: sage を 3 本再実行（step 1・2 は時間表示を除いて完全一致、いずれも FAIL 0）、
  `lake build`（8671 jobs）と `check-no-sorry.sh`（156 定理）を再実行、そして
  **4 系統の中心的主張を独立な経路で計算**した（定理 L4 の終結式公式を円分体の直接付値と 720/720、
  定理 Y′ の閉形式を全 4 場合分けで 24/24 ＋ 追加不変量 $w$ の必要性、系 W6 の $b$ を塔の値の
  当てはめと因数分解の両方から、step 4 が指摘した誤りを塔の値から）。

### cycle 21 の焦点（案）

1. **仮定 (B\*) を落とす**。定理 J7 に残った最後の仮定で、$\ell=2$ にも奇素数にも反例がある
   （step 2 §9・step 3）。何が妨げているかは step 2 が具体化済み（$\bmod\ \ell$ の因数分解は
   $v_\ell(A_m)$ の列に届かない）。**定理 L4（終結式）が同点でも値を出す**ので、そこから攻める道がある。
2. **一般の塔の閉形式（$c,d,e$ まで）**。$n\ell^n$ の係数 $b$ は族の外でも決まるようになった（定理 W4・W6）が、
   残りの係数は族でしか出ていない。step 3 §9.1 が $\ell=2$ について妨げを具体化している。
3. **cycle 20 の新定理群の Lean 化**（定理 L1・L4・K′・W3・W4・Y′）。5 サイクル連続で効いている検算。
   とくに**定理 K′ と定理 W3 は「有限手続き」の主張**なので、形式化と相性がよい。
4. **論文本文への反映**。cycle 19・20 で本文へ移していない結果が溜まっている
   （step 3 は意図的に見送った。理由は転記事故の回避）。**根拠 report と機械的に突き合わせながら**移す。

### 方針判断点（ユーザー価値判断）: 論文 001 をどうするか
cycle 19 総括のとおり「英訳するか」「新規性を主張しない宣言を維持するか」の 2 判断。
**本サイクル中に別セッションが英語版の作成と専門校閲を進めている**（`goal-expositiones-rewrite`）。
**ここは自動ループでは決めない。**

## cycle 19 総括（rank:cycle19, 2026-08-01）

**掲げた 3 点はすべて潰れ、いずれも肯定的に決着した**（4 点目の「投稿判断」はユーザー価値判断なので
step にしていない）。**cycle 14 以来「型 III（$n\ell^n$ 項が出る塔）」は $\ell=2$ トーラス 1 個だけの
説明のつかない現象だったが、本サイクルでその原因が特定され、任意の奇素数で無限個の実例が構成された。**

### 潰れた 3 点

1. **$\theta\ge\ell+1$ の退化塔**（step 1）。cycle 18 §6.1 の「次に試すべき具体的な手順」を実行し、
   **桁定理**（$m\le\ell^L$ なら $\bar A_m$ は $(a,b)\bmod\ell^L$ の関数。Lucas の第 2・第 3 桁への延長）と
   **閾値の必要十分条件**を得た。決定的だったのは**$\theta$ を $\mathbb{P}^1(\mathbb{F}_\ell)$ の関数と
   見るのをやめ $\mathbb{P}^1(\mathbb{Z}_\ell)$ 上へ延ばした**ことで、これにより $M$ 依存の正体が
   ファイバー Newton 多角形として書け、$\mathrm{ord}_\ell(\kappa_n)$ が $D$ の係数だけからの
   有限計算で決まる（定理 K）。
2. **$\theta=\infty$**（step 2）。cycle 18 §6.2 が「考えられる」とだけ書いた段階的処理は**機能し、
   反復不要で 1 段で閉じる**。$\theta=\infty$ の軌跡は **Newton 多面体の Minkowski 因子**で、
   原点を通る有限本の直線に限る。1 頂点 bouquet 族の閉形式を**全レベル・全点**で決めた。
3. **$\pi_{\mathrm{tr}}$ の閉形式と命題 C′ の Lean 化**（step 3）。**閉形式は存在しない**ことを
   反例つきで確定（障害は Wieferich 型の初期値と Wall 型等式の不成立の 2 つ）。一方
   **$w^*$ の代数的閉形式は得られ**（Euler の双対基底公式。差積・分岐指数で書ける）、
   **予想 A は定理になり主定理も強化された**。

### 本サイクルで分かった構造（3 step を突き合わせた結論）

**退化塔の分類が閉じた**（$\ell$ 奇、母集団に限らず）。

| $\theta$ の様子 | 型 | 閉形式 | 出典 |
|---|---|---|---|
| 至る所有限で、有限レベルで止まる | 型 II（$n\ell^n$ 項なし） | 定理 J6（cycle 18 定理 C はその $L=1$ の場合） | step 1 |
| $\theta=\infty$ の点がある | 型 III（$n\ell^n$ 項あり） | 係数は $b=\sum_{P\in S_\infty}j^*(P)$（定理 J7）。族なら値も全部（定理 X′） | step 1・step 2 |

**$S_\infty$（$\theta=\infty$ の点の集合）は 2 通りの意味で有限である**ことが、2 つの step から
**独立に**示された: step 2 は $\mathbb{Z}^2$ の直線として（Newton 多面体の Minkowski 分解）、
step 1 は $\mathbb{P}^1(\mathbb{Z}_\ell)$ の点として（指数関数の一次独立性）。**両者を合わせて完全になる。**
そして **$n\ell^n$ 項を生むのは $\theta=\infty$ の点そのものではなく、その $\ell$ 進近傍**である
（step 1 定理 J7 の証明 (b) と step 2 命題 7 が独立に同じ結論に達し、機械照合でも一致）。

### 本サイクルの規律面での所見

- **cycle 18 が「数値支持どまり」と正直に隔離した主張が、2 件とも次のサイクルで定理になった。**
  （step 1 が cycle 18 §4.4 の観察を、step 3 が cycle 18 の予想 A を。）
  **「数値支持どまり」と明記して残す運用は、次サイクルの入口として機能している。**
- **0 件の観察の罠は、否定側だけでなく肯定側にもある。** cycle 18 は「反例 0 件を根拠にしない」を
  自分で明示していたが、「$\ell\ge5$ の退化塔は全件型 II」という**肯定側**の観察でも同じ罠が働いた
  （母集団の辺数が 5 以下だと $\ell\ge7$ で例外直線が構造的に作れない）。step 2 がこれを指摘し、
  母集団の制限を外して反例を構成した。**母集団の設計が結論の形を決めていないかを毎回問う。**
- **形式化は 3 サイクル連続で効いた**が、今回は**誤りではなく過剰仮定**を検出した
  （定理 A′ に素数性は不要、周期の最小性も使っていない）。「食い違いなし」で終わっても
  仮定の棚卸しという別の収穫がある。
- **自分の誤りの検出は、3 step とも「うまくいった例」ではなく「合わない例」と
  「検証が吐いた見慣れない出力」から来ている。** step 1 は $\mathrm{argmin}$ 非一意の件数を
  出力させていなければ最大の誤りに気づいていない。**検証は PASS/FAIL だけでなく、
  内訳を吐かせること。**
- サブエージェント 3 本すべてが規約を守った（作業ブランチのみに push。3 サイクル連続で逸脱なし）。
  **ただし step 1 は長時間の数値掃引を起動した直後にセッションが 2 度終了し、
  呼び出し元が同じ worktree で 2 回再開させて完了させた**（1 回目は掃引プロセスごと停止、
  2 回目は掃引が生き残ったので完走を待って仕上げのみ実行）。
  **長時間ジョブの起動とセッションの生存を同一視しない。**
- 呼び出し元の検証: sage 3 本をすべて再実行（step 2・3 は時間表示を除いて完全一致、
  step 1 は**壁時計依存の打ち切り位置だけが揺れ**それ以外一致、いずれも FAIL 0）、
  `lake build`（8668 jobs）と `check-no-sorry.sh` を再実行、そして
  **中心的な主張 3 系統を独立な経路で計算**した（定理 X′／定理 J8 の閉形式を
  ラプラシアン余因子からの全域木数で 12 例、桁定理と閾値の鋭さを実際の $A_m$ で、
  トレース周期の反例 3 件を素の Python で）。

### cycle 20 の焦点（案）

1. **打ち消し（$|J(r)|\ge2$）の再帰**（step 1 §7.1）。定理 J4 が $\theta$ を決めない唯一の場合で、
   奇素数でも起きる実例がある。$\beta$ の次の桁へ降りる再帰を書けば閉じる可能性がある。
2. **$S_\infty$ の判定手続きを一般の塔で実装する**（step 1 §7.2）。候補集合は有限計算で尽きるが、
   各候補で $\theta=\infty$ かを判定する手続きは族についてしか完成していない（step 2 命題 8）。
3. **$\ell=2$**（step 1 §7.3・step 2 §9.3）。$S_\infty$ の点が $\bmod\ 2$ で分離されないため
   両 step の仮定が破れる。cycle 16 が $\ell=2$ トーラスを特別扱いした理由は説明がついたが、
   $\ell=2$ 自体の閉形式は無い。
4. **定理 J6・J7・定理 X′ の Lean 化**。cycle 17・18・19 と 3 サイクル連続で形式化が
   主張の検算として効いており、本サイクルの新しい定理群はまだ通していない。

### 方針判断点（ユーザー価値判断）: 論文 001 をどうするか — **具体化された**
cycle 18 の時点では「投稿するか」という漠然とした問いだったが、
**別セッションの投稿先調査（`outputs/reports/paper001_submission_venue_survey.md`、2026-08-01）により
「英訳するか」「新規性を主張しない宣言を維持するか」の 2 判断へ具体化された。**
`MEMORY.md` 冒頭に要点がある。**ここは自動ループでは決めない。**

## cycle 18 総括（rank:cycle18, 2026-08-01）

**掲げた 4 点はすべて潰れた。うち 3 点は肯定的に決着し、1 点（Monsky）は「入手できたうえで、
既出ではないと確定した」という決着の仕方をした。加えて、論文本文の誤りが 2 件見つかった。**

### 4 点の結果

| cycle 17 が挙げた焦点 | 結果 |
|---|---|
| 一般の退化塔 | **障害を確定させ、その下で閉形式を証明した**（step 1）。cycle 17 §6.1 が「方針にすぎない」と書いた「消え方の深さ」を**消滅深度** $\theta(a,b)=\min\{m:\ell\nmid A_m(a,b)\}$ として定義。**$\theta\le\ell$ である限り $\theta$ は方向の不変量**（$m=\ell+1$ で初めて第 2 $\ell$ 進桁が入る）で、その下で $\mathrm{ord}_\ell(\kappa_n)=\mu(\ell^{2n}-1)+\frac{\Theta}{\ell-1}(\ell^n-1)-2n+v_\ell(\kappa_X)$、$\Theta=\sum_P\theta(P)$。cycle 16 定理 N1 と cycle 17 定理 E は**その特別な場合**。**$\ell=2$ が反例だったのは偶然ではなく構造的必然**（退化⇒$\theta\ge k+1$ なので $\ell=2,3$ は射程外） |
| $\pi_{\mathrm{tr}}(p,k)$ の上界 | **正しい上界を確定させ、証明した**（step 2）。$\pi_{\mathrm{tr}}(p,k)\mid p^{k-1}\pi_{\mathrm{tr}}(p,w^*+1)$、$w^*$ は Gram 行列 $(\mathrm{Tr}\,T^{i+j})$ の最大単因子の $p$ 進付値。**直すべきは指数ではなく基準レベル**だった（$p$ 冪だけの補正はどう取っても偽）。さらに $\det G=\mathrm{disc}(\rho)\prod m_\lambda$ から、**命題 C がトレース列で破れるのは命題 B の帰結**だと説明がついた |
| 命題 N・T・W の Lean 化 | **形式化し、本文の誤りを 2 件見つけた**（step 3）。下記 |
| Monsky 1989 の入手 | **入手して読んだ**（step 4）。cycle 17 の「購読制限」は誤診断で、実際は **Open Access**（ボット遮断ページを購読の壁と読み違えていた）。**$\mu_1$ に対応する定数 $\alpha^*$ の明示式は無く**、存在と $d=2$ での有理性のみ。**命題 W は既出にならない**。投稿前の宿題は 0 件 |

### 見つかった本文の誤り（cycle 16・17 に続き 3 サイクル連続）

1. **命題 N**: 「SML 型の例外は**有限個の $N$**」は誤り。例外集合は算術級数の有限和で一般に**無限**。
   反例 $T=(0\,1;2\,0)$, $p=2$ では**全奇数 $N$** が例外（Lean 化）。根拠 report は正しく書いており、
   **本文へ移す段での取り違え**だった。
2. **命題 W**: 閉形式の $\nu$ の**帰属が未記載**。$\frac{k(\ell+1)}{\ell-1}$ は一般に非整数なので $\nu\in\mathbb{Q}$。
3. 併せて、命題 N の**下界が本文から脱落**していたこと、Newton 多角形の**向きの規約が本文に無い**ことも
   形式化の過程で判明（規約なしでは「最小傾き」が一意に読めない）。

**cycle 17 の命題 B に続き、形式化が「主張の検算」として 2 サイクル連続で効いた。**
今回は「証明が間違っている」のではなく、**根拠 report から本文へ移す段で主張が壊れる**という
別の型の事故が 2 件出た。人手証明側の転記も形式化の対象にする価値がある。

### トラック横断で噛み合った点

- **step 3 と step 4 が独立に同じ場所を指した**。step 3 は Lean で「$\nu$ は一般に非整数なので $\nu\in\mathbb{Q}$」
  を確定させ、step 4 は Monsky から「$d=2$ なら $\alpha^*$ は有理数」を得た。両者は整合し、
  **本論文は Monsky の一般定理（有理数である）に対して、ある族でその値を与えている**という位置づけになった。
- **step 1 と step 2 は方法論が同型**。どちらも「壊れた主張を、正しい不変量（$\theta$ / $w^*$）を
  見つけて修復する」形で決着した。どちらも $\mathbb{R}$ にも $\mathbb{Z}_p$ にも脱出せず、
  判定は $\mathbb{Z}$・$\mathbb{F}_\ell$ 上の有限計算に留まった。

### 残っている未解決

- **$\theta\ge\ell+1$ の退化塔**の閉形式（次の一手は Lucas を第 2 桁へ延長して $\theta_M$ を桁ごとに記述すること）。
- **$\theta=\infty$**（方向上で $\bar E$ が恒等的に消える）の場合。step 1 が第 3 の破れ方として新たに構成した。
- **$\pi_{\mathrm{tr}}(p,k)$ の閉じた公式**（命題 B の $k\ge2$ 版）と、$w^*$ を代数的不変量で書く式。命題 C′ の Lean 化も未着手。
- 一般の $d\ge3$ の低位項。
- **論文 001 は投稿前の宿題が 0 件になった**（既出性調査・Monsky ともに完了）。投稿するか否かは**ユーザーの判断**。

### 運用

- **サブエージェント 4 本すべてが規約を守った**（作業ブランチのみに push。cycle 16 の逸脱は 2 サイクル連続で再発せず）。
- **並列実行の副作用は 0 件**。4 本が触った本文ファイルは重ならず（005 / 004 / 004・006 / 006）、
  `MEMORY.md` の 1 箇所だけがコンフリクトしたので呼び出し元が両方を残して解決した。
  統合後に本文の整合（命題 C の「上界は未確立」が命題 C′ への参照に置き換わっていること、
  命題 N の SML 記述が訂正版だけになっていること）も確認した。
- **作業中に別セッションが入力言語のシステム一本化を main へ入れた**（`sourcePath`→`origin`）。
  各サブエージェントは自分でマージし、呼び出し元も依存を入れ直して検査を通した。
- 呼び出し元の検証: sage 2 本を再実行して**出力が完全一致**、`lake build`（8667 jobs）と
  `check-no-sorry.sh`（85 定理）を再実行、Monsky の PDF を**独立に取得して原文を確認**、
  中心的な反例 2 件（$F\oplus F$ の $\pi_{\mathrm{tr}}$、$(0\,1;2\,0)$ の $\mathrm{Tr}\,T^N$）を独立に計算。

### cycle 19 の焦点（案）

1. **$\theta\ge\ell+1$ の退化塔**（step 1 が「次の一手」まで具体化した。Lucas の第 2 桁への延長）。
2. **$\theta=\infty$ の場合**（step 1 が新たに立てた第 3 の破れ方）。
3. **$\pi_{\mathrm{tr}}(p,k)$ の閉じた公式と、命題 C′ の Lean 化**（step 2 の未解決）。
4. **論文 001 の投稿判断**（宿題が 0 件になったので、次はユーザーの判断事項）。

### 方針判断点（ユーザー価値判断）: 論文 001 を投稿するか
投稿前の宿題（既出性確認・Monsky の入手）は cycle 18 で 0 件になった。
一方 cycle 17 の調査どおり**本論文は「おおむね既出」**であり、差分は
「等号を決定可能な水準まで降ろした」1 点と、命題 T・W の強化に絞られている。
**投稿するか・どこへ出すか・さらに強化してから出すかは研究方針＝ユーザー固有の価値判断**なので、
ここは自動ループでは決めない。

## cycle 18 step 列（2026-07-31 起こし。cycle 17 総括の「cycle 18 の焦点（案）」4 点をそのまま step にした）

**前提**: cycle 17 で 4 点はすべて潰れたが、代わりに (a) 一般の退化塔（トーラス以外）の閉形式、
(b) トレース列の周期 $\pi_{\mathrm{tr}}(p,k)$（$k\ge2$）の上界、が未解決として残り、
(c) 命題 B が偽だった事故を受けて「確定済み命題も Lean で主張を検算する」必要が生じ、
(d) 投稿前の宿題 Monsky (ASPM 17, 1989) の本文が未取得である。cycle 18 はこの 4 点を潰す。

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T3 Pure | general_degenerate_tower | done | 2026-08-01 | cycle 17 step 2 の報告 §6.1 が具体化した障害（$H$ の零点での消え方の深さを $M$ に依らない不変量として取り出す条件。$\ell=2$ が反例）に正面から取り組む。トーラスは全素数で解けたので、**次はトーラス以外の退化塔**。閉形式が出ないなら、**何が不変量化を妨げているかを反例つきで確定させる**のが成果（「まだ出来ていない」で終わらせない）。数値だけで支持を積んで「示した」と書かない（cycle 14・16 で 2 回事故）。<br>**結果**: `outputs/reports/cycle18_T3_general_degenerate_tower.md` / `sagemath/check/cycle18_T3_general_degenerate/`（総 FAIL 0、打ち切り 0 件）。**障害の正体を確定**: 消滅深度 $\theta(P)=\min\{m:\ell\nmid A_m\}$（$A_m=\sum c_{pq}\binom{pa+qb}{m}$）が $\theta\le\ell$ を満たす限り方向の不変量で、$m=\ell+1$ で初めて第 2 $\ell$ 進桁が入る。その下で**一般の退化塔の閉形式を証明**（$\Theta=\sum_P\theta(P)$、$c=\Theta/(\ell-1)$）。cycle 16 定理 N1 と cycle 17 定理 E はその特別な場合。**型 II の判定条件**も得られ、母集団 2081 個で $\ell\ge5$ の退化塔は全件型 II（593/637/1082）。**$\ell=2,3$ が射程外なのは構造的必然**（退化⇒$\theta\ge k+1$）。**$M$ 依存は $\ell=2$ 固有ではなく $\ell=3,5$ にも実例**。自分の誤り 1 件（安定性の閾値を $m=\ell$ と誤記）を検証で検出・訂正。本文へ (G6) 反映済み。**残る未解決**: $\theta\ge\ell+1$ の退化塔と $\theta=\infty$ の場合。**呼び出し元が sage を再実行**し、時間表示を除いて出力が完全一致・総 FAIL 0・打ち切り 0 件を確認（Step B は $m\le\ell$ で破れ 0／$m=\ell+1$ で破れ 48・6480・1638 件を検出しており、**0 件が意味を持つ検証設計**であることも確認した）。定理 B・定理 C の証明と補題 A3 の Lucas 評価も手で追った。`npm run check` と `verify-check-linkage.ts` も再実行。規約どおり作業ブランチのみ push（main へは push せず）。 |
| 2 | T3 Pure | trace_period_bound_k_ge_2 | done | 2026-07-31 | **正しい上界を確定させ証明した**（`outputs/reports/cycle18_T3_trace_period_bound.md`）。主結果: $\pi_{\mathrm{tr}}(p,k)\mid p^{k-1}\pi_{\mathrm{tr}}(p,w^*+1)$、$w^*=v_p(\text{Gram }G=(\mathrm{Tr}\,T^{i+j})\text{ の最大単因子})$。**直すべきは指数ではなく基準レベル**（$p$ 冪だけの補正は $F\oplus F$, $p=2$ でどう取っても偽）。$\det G=\mathrm{disc}(\rho)\prod m_\lambda$ なので $w^*=0$ の条件は**命題 B の条件そのもの**＝命題 C がトレース列で破れるのは命題 B の帰属の帰結。$\mathbb{R}$ にも $\mathbb{Z}_p$ にも脱出せず $\mathbb{Z}$ 上で閉じた。本文へ命題 C′（`paper_prop_C_trace`）を追加。891 組で証明済み 10 主張は失敗 0、素朴版は反例が出る。**数値支持どまり**: $w^*+1\le k\le2w^*$ の階段（402 件 0 反例だが検出力は破れ率 0.74% までと明記）。**自分の誤り 2 件を報告に明記**（最初に立てた $p^{k-1+v}t_1$ は偽、Gram の非退化性の仮定漏れ）。**呼び出し元が sage を再実行して出力が完全一致することを確認**し、命題 12 の反例（$F\oplus F$, $p=2$ で $\pi_{\mathrm{tr}}=1,3,6,12,24,48$）を Lucas 数から独立に計算して一致を確認、定理 6・定理 7・定理 10 の証明も手で追った。`npm run check` と `verify-check-linkage.ts` も再実行。規約どおり作業ブランチのみ push（main へは push せず）。 （当初の指示: cycle 17 step 3 で新たに立った未解決。トレース列 $\mathrm{Tr}\,T^N \bmod p^k$（$k\ge2$）の最終周期 $\pi_{\mathrm{tr}}(p,k)$ の上界。命題 C は**トレース列の読みでは偽**（1669 例中 56 例）と判明しているので、まず**正しい主張を反例で削り出す**。$k=1$ の確定形（命題 B のトレース列版）からどこまで持ち上がるかを見る。） |
| 3 | 運用 | lean_props_N_T_W | done | 2026-07-31 | `outputs/reports/cycle18_ops_lean_props_NTW.md`。**命題 N の本文に誤りが 1 件、命題 W の本文に書き落としが 1 件見つかった。** (N) 「SML 型の例外は**有限個の $N$**」は誤りで、例外集合は算術級数の有限和＝一般に**無限**。$T=(0\,1;2\,0)$, $p=2$ で**全奇数 $N$** が例外になる反例を Lean で形式化（根拠 report は「算術級数の有限和」と正しく書いており、本文へ移す段で取り違えていた）。併せて根拠 report にあった下界 $v_p(Z_N)\ge\mu_{\min}N$ が本文から落ちていたので復活させ、**係数条件だけから Cayley–Hamilton で出る形**（固有値も Newton 多角形も $\mathbb{Q}_p$ も使わない）を Lean で閉じた。Newton 多角形の**向きの規約**が本文に無く「最小傾き」が一意に読めなかったので規約を明記。(W) 閉形式の $\nu$ の**帰属が未記載**。$\frac{k(\ell+1)}{\ell-1}$ は一般に非整数（$\ell=5,k=3$ で $9/2$。この $(\ell,k)$ が非退化性と両立することを `decide` で確認）なので $\nu\in\mathbb{Q}$。非退化なら $k\ge2$ も追記。(T) **食い違いなし**——本文の数値（奇 $L$ の $2(L-1)$、偶 $L$ の $5,19,29,61,53,83,77$）を素の Python で独立に再計算して全一致。代数的な段 (3.1)・奇数性が効く 2 箇所・Newton 多角形の組合せ核・総和の段を Lean 化。**未形式化の障害を一次情報で特定**: SML / Strassmann / companion 行列 / matrix-tree / 岩澤型漸近は mathlib に**無い**（3 段 grep）。一方 **Newton 恒等式と Hensel は在り、無いのは接続の配線**（「無い」と書きかけて偽陰性を自分で作りかけたので報告に記録した）。ビルド **8667 jobs 成功・85 定理が sorryAx 非依存**（cycle 17 は 63）。`check-no-sorry.sh` の targets 追加で `PropT.lean` の import 漏れが発覚し修正。**呼び出し元が `lake build`（8667 jobs 成功）と `check-no-sorry.sh`（85 定理、sorryAx 非依存）を自分で再実行**し、SML 反例（$T=(0\,1;2\,0)$ で $\mathrm{Tr}\,T^N=0$ が全奇数 $N$）を素の Python で独立に計算して確認、命題 T の数値再計算・`npm run check`・`verify-check-linkage.ts` も再実行した。規約どおり作業ブランチのみ push（main へは push せず）。 | 命題 B の事故（記号の混同が 10 サイクル以上見逃された）を踏まえ、**確定済みの命題 N・T・W を Lean に通して主張の一意性を検査する**。目的は証明の正しさではなく**主張の検算**。`lake build` と `check-no-sorry.sh` を自分で実行し sorryAx 依存 0 を確認する。**mathlib に補題が「無い」と書く前に必ず検索で実在確認する**（cycle 16 で偽陰性の事故）。 |
| 4 | T1 Reframe | monsky_1989_acquisition | done | 2026-07-31 | `outputs/reports/cycle18_T1_monsky1989_acquisition.md`。**本文を入手して閉じた**（購読・課金・ログイン・メール依頼はいずれも不要）。Project Euclid の当該章は **Open Access** で、章ページの PDF リンク（`ebook/Download?urlId=10.2969/aspm/01710309`）から全 22 ページを取得。**cycle 17 の「購読制限」は誤診断**で、実際は Incapsula のボット遮断ページを購読の壁と読み違えていた（取得失敗の原因は応答本文を見てから書くこと）。**照合結果: $\mu_1$ に対応する定数 $\alpha^*$ の明示式は Monsky 1989 に無い。** Theorem 3.13 は存在と $d=2$ での有理性のみを主張し、Monsky 自身が Introduction で「$\alpha^*$ に easy な記述は無く、常に有理数かも分からない」と明記。明示同定されている係数は $p^{dn}$ の $m_0$ と $np^{(d-1)n}$ の $\ell_0$ の 2 つだけ（Thm 1.20）。$\alpha^*$ の 3 寄与（岩澤和／擬零部分加群／整数 $\beta$）の出典も全部読んで値の記述が無いことを確認。独立な二次確認として **Tateno–Ueki arXiv:2401.03258（JLMS 2025）Thm 2.3** が同じ定数を文字どおり $\mu_1$ と呼び「$\mu_1\in\mathbb{R}$ が存在、$d=2$ なら $\mathbb{Q}$」とだけ引用。**命題 W は既出にならない**（Monsky は数体の類数の話でグラフの $\kappa$ ではない点も明記）。本文 `paper_prop_W` の (iii)・refs.bib・notes.md を更新。**refs.bib の重複 BibTeX キー `Vallieres2021`（2 エントリ）も統合した**。**呼び出し元が PDF を独立に取得し**（同じ Open Access リンク、22 ページ、`application/pdf`）、Introduction の "There is no easy description of a\* and in particular we do not know if it is always rational"・Thm 3.13 の形・Thm 1.20 の 2 係数を原文で確認。Tateno–Ueki の arXiv ID も解決を確認。`npm run check` も再実行して通過。規約どおり作業ブランチのみ push（main へは push せず）。 | 投稿前の宿題。Monsky, ASPM **17** (1989) の本文を購読以外の経路で入手できるか、**一次情報で経路を確定させる**。入手できたら $\mu_1$ の明示式に対応する結果があるかを照合し、本文の位置づけを更新する。**外部への送信（著者への依頼メール・相互貸借の申込・課金）は行わない**（不可逆・外部送信のためユーザー判断事項）。取れなければ「取れなかった経路と、ユーザーにしか実行できない残り経路」を具体化して報告する。 |
| 5 | — | rank:cycle18 | done | 2026-08-01 | 下記「cycle 18 総括」。**掲げた 4 点はすべて潰れた**（うち 3 点は肯定的決着、1 点＝Monsky は「入手できて既出でないと判明」という決着）。**最大の発見は、本文の誤りが 2 件（命題 N の SML 例外の有限性・命題 W の $\nu$ の帰属）見つかったこと**で、cycle 17 の命題 B に続き**形式化が主張の検算として 2 サイクル連続で効いた**。cycle 19 の焦点は 4 点（$\theta\ge\ell+1$ の退化塔／$\theta=\infty$／$\pi_{\mathrm{tr}}$ の閉形式と Lean 化／論文 001 の投稿判断）。 |

## cycle 17 総括（rank:cycle17, 2026-07-31）

**掲げた 4 点はすべて潰れた。うち 3 点は肯定的に決着し、1 点（既出性）は「おおむね既出」という
決着の仕方をした。加えて、論文の主張が 1 つ偽であることが判明した（本サイクル最大の発見）。**

### 4 点の結果

| cycle 16 が挙げた焦点 | 結果 |
|---|---|
| 補正項が非自明に効く例の構成 | **両方の穴が塞がった**（step 1）。$\Delta\neq0$ の例 5 件、$v_\ell(\kappa_X)>0$ の例 6 件（うち 1 件は 3 寄与同時）。**さらに「なぜ cycle 16 で $\Delta=0$ しか出なかったか」を証明つきで説明**（$k\le\ell\Rightarrow\Delta=0$。cycle 16 の 5 件は $\ell=3,k=2$ なので最初から決まっていた）。副産物: $\ell=2$ の非退化塔の存在（cycle 14 が未決としていた事項） |
| $\ell\equiv1\bmod4$ の退化トーラス | **仮説 6.1 を証明した**（step 2）。詰まりの正体は評価の甘さではなく**道具の選び方**（割り算が $1/m!$ を持ち込み $\ell$ 整数性を壊していた）。分子をそのまま展開すれば係数は整数の有限和になる。**$\ell$ 奇の全素数で閉形式**が出て、$\ell=2$ と合わせ**トーラスは全素数で解けた** |
| Lean 命題 B の完成 | **完成したが、その過程で命題 B が偽だと判明した**（step 3。下記） |
| 投稿前の既出性確認 | **調査完了。結果は「おおむね既出」**（step 4）。命題 V は $d=1$ で既出、命題 T は弱い形が既出、命題 W は形が $d=1$ で既出。寄与 (b) の差分は**「等号を決定可能な水準まで降ろした」1 点**に絞られた |

### 本サイクル最大の発見: 命題 B が偽だった（記号の混同）

**記号 $\pi(p,1)$ が 2 つの別量に使われていた**: 命題 A の定義は**行列冪列** $T^N\bmod p^k$ の最終周期、
命題 B が実際に計算しているのは**トレース列** $\mathrm{Tr}\,T^N\bmod p$ の最終周期。
本文は後者の主張なのに前者を参照していた。反例は $(0\,1;1\,1)^{\oplus2}$, $p=2$ で、数行で再現できる。
**この行列は半単純なので、cycle 16 が想定した「半単純性を組み立てれば逆向きが出る」筋では救済できない。**
読みをトレース列に直せば両方向とも成立し、Lean で閉じた。**副産物: 命題 C はトレース列の読みでは偽**（3.4%）。

**この発見の意味**: 形式化が「証明の検算」ではなく**「主張の検算」**として効いた。人手証明では
この混同が 10 サイクル以上見逃されていたが、Lean は記号を区別せざるを得ないので即座に露見した。
**今後、人手で確定した命題も Lean に通す価値がある**（証明の正しさではなく主張の一意性の検査として）。

### 見つかった誤り（cycle 16 に続き、今回も自分側の誤りが出た）

1. **命題 B の記号の混同**（step 3。上記。10 サイクル以上見逃されていた）
2. 塔の値の独立再計算で $-2n$ を二重に引いた（step 1。既存実装の方が正しかった）
3. 点ごとの Newton 下限を全次数単位で取っていた（step 1）
4. 狭い探索で「$\ell=2$ の非退化例は 0 件」と結論しかけた（step 1。範囲を広げたら 24 件出た。**0 件事故の未遂**）

### 残っている未解決

- **一般の退化塔**の閉形式（トーラス以外）。足りないものは step 2 の報告 §6.1 に具体化してある
  （$H$ の零点での消え方の深さを $M$ に依らない不変量として取り出す条件。$\ell=2$ が反例）。
- **トレース列の周期 $\pi_{\mathrm{tr}}(p,k)$（$k\ge2$）の上界**（step 3 で新たに立った）。
- **Monsky (ASPM 17, 1989) の本文未取得**。$\mu_1$ の明示式に対応する結果を含む可能性があり、
  **投稿前に必ず読む**（notes.md に単独タスクとして記載）。
- 一般の $d$ の低位項。

### 運用

- **サブエージェント 4 本すべてが規約を守った**（作業ブランチのみに push。cycle 16 の逸脱 2 件は再発せず）。
  指示文に「main への push は絶対禁止」と明記した効果があったと考えられる。
- **並列実行の副作用が 1 件**: step 1 が塞いだ穴を、並行して走っていた step 2 が報告中で
  「依然 0 件」と書いている（step 2 は step 1 の結果を知らない）。呼び出し元が本文で整合させた。
  **並列 step の報告は互いの結果を反映していないので、統合時に必ず突き合わせること。**
- 作業ツリーは削除していない（ユーザー指示）。

### cycle 18 の焦点（案）

1. **一般の退化塔**（step 2 が特定した障害＝消え方の深さの不変量化に正面から取り組む）。
2. **$\pi_{\mathrm{tr}}(p,k)$ の上界**（命題 C のトレース列版。新たに立った未解決）。
3. **既に確定している他の命題も Lean に通す**（命題 B の事故を踏まえた主張の検算。命題 N・T・W）。
4. Monsky 1989 の入手（図書館・著者・相互貸借など、購読以外の経路）。

### 方針判断点は無し（cycle 17）
新たなユーザー判断点は生じていない。

## cycle 17 step 列（2026-07-31 起こし。cycle 16 総括の 4 点をそのまま step にした）

**前提**: cycle 16 で論文 001 の残務はほぼ閉じたが、**照合の穴が 2 つ残り**（補正項が非自明に効く例 0 件、
$v_\ell(\kappa_X)>0$ の例 0 件）、**未解決が 1 つ残り**（$\ell\equiv1\bmod4$ の退化トーラス）、
**投稿前の既出性確認は手つかず**である。cycle 17 はこの 4 点を潰す。
step の選定根拠は cycle 16 総括の「cycle 17 の焦点（案）」そのものである。

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T3 Pure | construct_nontrivial_delta_examples | done | 2026-07-31 | **両方の穴が塞がった。** `outputs/reports/cycle17_T3_delta_and_kappa_contributions.md`。**(A)** $\Delta\neq0$ の非退化例を **5 件**構成（$\Delta=8,14,6,9,4$）。$\Delta$ は $D$ の係数だけで決まり塔の値を使わないので、照合は**パラメータ 0 個の out-of-sample**。$n\ge J_0-1$ の**全 15 段で命題 G(1) が当たり、$\Delta=0$ とした式は全段で外れた**＝「N2 は N1 より真に強い」が初めて裏付けられた。**さらに cycle 16 で $\Delta=0$ しか出なかった理由を証明つきで説明**: ずれ指数 $\delta>0$ なら $\Delta=0$、系として **$k\le\ell\Rightarrow\Delta=0$**（cycle 16 の 5 件は $\ell=3,k=2$ なので最初から決まっていた）。$\Delta\neq0$ には $k\ge\ell+1$ が要る＝**小さい $\ell$ の現象**。3324 件で反例 0。**(B)** $v_\ell(\kappa_X)>0$ の非退化例を **6 件**（うち 1 件は $\mu>0$・$v_2(\kappa_X)=3$・$\Delta=14$ の **3 寄与同時**）。cycle 16 が失敗した理由も特定（平行辺だけでは voltage の自由度が足りない）。**副産物**: $\ell=2$ の非退化塔の存在（cycle 14 注 8.9 が未決としていた事項。1844 件中 20 件）。**自分の誤りを 3 件検出・訂正**（$-2n$ の二重減算／Newton 下限の取り方／**狭い探索で「$\ell=2$ は 0 件」と結論しかけた＝0 件事故の未遂**）。本文へ (G1′) として反映。**呼び出し元が sage 2 本を再実行し、時間表示以外は完全一致を確認。** 規約どおり作業ブランチのみ push。 | cycle 16 の**照合の穴を塞ぐ**。命題 G(1) の補正項 $\Delta$ が**非自明に効く例（$\Delta\neq0$）を実際に構成する**。手持ちの例はすべて $\ell=3,k=2,J_0=2$ で $\Delta=0$ になった。$\ell$ を上げる／$J_0\ge3$ を狙う／低レベル点で付値がずれる塔を意図的に作る。併せて **$v_\ell(\kappa_X)>0$ の非退化例**も作る（3 つの寄与のうち 1 つが未照合のため）。**見つからなければ「なぜ $\Delta=0$ になりやすいか」を構造的に説明する**（$\Delta$ が恒等的に 0 なら定理 N2 は N1 に吸収されるので、それ自体が結論になる）。 |
| 2 | T3 Pure | degenerate_torus_ell_1_mod_4 | done | 2026-07-31 | **仮説 6.1 を証明した（肯定的に決着）。** `outputs/reports/cycle17_T3_degenerate_torus_odd_ell.md`。**cycle 16 の詰まりの正体は評価の甘さではなく道具の選び方**だった: $u=(\xi-1)/(\zeta-1)$ の割り算が $1/m!$ を持ち込み $m\ge\ell$ で $\ell$ 整数性を壊すため、$\mathfrak m/\mathfrak m^2$ より先が取れなくなっていた。分子をそのまま $\pi=g-1$ で展開すれば係数は**整数の有限和**になり、割り算も収束も出てこない。得られた閉形式は $\ell$ 奇の**全素数・全 $n\ge0$** で $\mathrm{ord}_\ell(\kappa_n)=\frac{2\ell+2+2z_H}{\ell-1}(\ell^n-1)-2n$（$\ell\equiv3\bmod4$ も同じ式に収まった）。**$\ell=2$ と合わせトーラスは全素数で解けた。** 副産物: **型 II の実例が確定**（cycle 16 が「1 件も無い」としていたもの＝退化なのに $n\ell^n$ 項が無い塔）、cycle 14 注 8.7 の未確認事項も解消。**事故防止**: フィット不使用（パラメータ 0 個）、恒等式は多項式環上の等式として検査、帯上の付値は cycle 16 の標本抽出ではなく Galois 縮約で**全点**を尽くした。$\ell=3$ は DuBose–Vallières §7 例 (4) と $n\le7$ で一致（$n=5,6,7$ は外部 out-of-sample）。本文へ (G4)(G5) として反映。**呼び出し元が sage を再実行**し、完走した検査はすべて一致・失敗 0 件を確認（差は 1 件のみで、呼び出し元の環境では時間上限で打ち切られた計算があるため。打ち切りは両実行とも記録されている）。規約どおり作業ブランチのみ push。 | cycle 16 が**未確定のまま残した唯一の数学的未解決**。$\ell\equiv1\bmod4$ のトーラス塔の閉形式。仮説 6.1（$M\le4$ まで数値支持、証明なし）を**証明するか反例を出す**。$\ell=2$ が解けた機構（定理 D2）がどこで効かなくなるかを特定するのが筋。**数値だけで支持を積み増して「示した」と書かない**（cycle 14・16 で同種の事故が 2 回起きている）。 |
| 3 | 運用 | lean_prop_B_completion | done | 2026-07-31 | `outputs/reports/cycle17_ops_lean_propB.md`。**形式化しようとしたら命題 B が偽だと判明した（本サイクル最大の発見）。** 記号 $\pi(p,1)$ が **2 つの別量**に使われていた: 命題 A の定義は**行列冪列** $T^N\bmod p^k$ の最終周期、命題 B の証明が計算しているのは**トレース列** $\mathrm{Tr}\,T^N\bmod p$ の最終周期。本文は後者の主張なのに前者を参照していた。**反例**: $(0\,1;1\,1)^{\oplus2}$, $p=2$ で行列冪列の周期 3・トレース列の周期 1・右辺 1。**この $T$ は半単純なので、cycle 16 が想定した「半単純性を組み立てれば逆向きが出る」筋では救済できない。** 無作為 2487 例中 563 例（22.6%）で食い違う。**読みをトレース列に直せば両方向とも成立**し、代数閉体上で仮定なしの完成形まで Lean で閉じた（人手証明の第 1 段 $\mathrm{Tr}(f^N)=\sum m_\lambda\lambda^N$ も一般化固有空間分解から証明）。**副産物**: 命題 C はトレース列の読みでは**偽**（1669 例中 56 例＝3.4%）。3 命題は同じ記号を共有できない。ビルド 8664 jobs 成功・**63 定理が sorryAx 非依存**。**mathlib の欠落は 1 件も主張していない**（「無い」と書く予定だった補題を自前で組み立てた）。本文の命題 A・B・C を訂正。**新たな未解決**: $\pi_{\mathrm{tr}}(p,k)$（$k\ge2$）の上界。**呼び出し元が反例を独立に計算して確認**し、検証スクリプトも再実行。規約どおり作業ブランチのみ push。 | 命題 B の**逆方向**を形式化して等式本体を閉じる。cycle 16 step 4 で「mathlib に道具が無い」は**偽陰性による誤り**と判明済み（`rootMultiplicity` 等は実在）。したがって障害は無いはずで、無ければ**何が実際の障害かを一次情報で特定**する。`lake build` と `check-no-sorry.sh` を自分で実行し sorryAx 依存 0 を確認する。 |
| 4 | T1 Reframe | prior_art_check_for_submission | done | 2026-07-31 | `outputs/reports/cycle17_T1_prior_art_check.md`。**結果は「おおむね既出」**で、これは瑕疵ではなく位置づけの精密化である（本論文は新規性を主張していない）。**寄与 (b)**: 可算符号化という移動自体は逆数学・構成的代数の標準手法（Alonso García–Lombardi–Perdry MLQ 54 (2008) を本文確認）。差分は**「等号を決定可能な水準まで降ろした」1 点**に絞られた。**命題 V**: $d=1$ は Gauss–Dold 合同の帰結で**既出**（Byszewski–Graff–Ward, Bull. LMS 53 (2021) Def 2.1 を本文確認）。**命題 T**: **弱い形（$v_2$ が偶数）が既出**（Mednykh–Mednykh arXiv:1902.05681 Thm 5.1、§7.6 が本件のトーラス）。等号 $2(L-1)$ は見つからず、本命題はその強化と位置づけた。**命題 W**: 形は $d=1$ で既出（Vallières Cor 5.7）。**投稿前の宿題が 1 件残った**: Monsky, ASPM **17** (1989) が購読制限で**本文未取得**。Wan arXiv:1712.02906 Thm 1.2 の引用形では $\mu_1$ に対応する位置に定数があり、明示式が含まれている可能性がある。**「既出でないと確認した」とは書いていない**（0 件は根拠にしない。MathSciNet 未使用を明記）。本文 5 箇所と refs.bib を更新。**呼び出し元が引用元 PDF を自分で取得して Def 2.1 を確認し、数値検証も再実行**。規約どおり作業ブランチのみ push（main へは push せず）。 | 投稿前の**既出性確認**。(a) 寄与 (b)（$\mathbb{Q}_p$ を使わない可算化）の既出性を**逆数学・構成的数学の文献本文**で調べる（cycle 16 まで abstract のみ。隣接既知として Ax–Kochen/Ershov は確認済み）。(b) **命題 T・V・W の既出性**（いずれも初等的で folklore の可能性が高い）。**これは文献調査であって証明ではない。** 既出なら「既出である」と書くのが成果であり、隠さない。取得できなかった文献は「本文未確認」と明記する。 |
| 5 | — | rank:cycle17 | done | 2026-07-31 | 上記「cycle 17 総括」。**掲げた 4 点はすべて潰れた**（3 点は肯定的決着、1 点＝既出性は「おおむね既出」という決着）。**最大の発見は命題 B が偽だったこと**（記号の混同。形式化が「主張の検算」として効いた）。cycle 18 の焦点は 4 点（一般の退化塔／$\pi_{\mathrm{tr}}(p,k)$ の上界／確定済み命題の Lean 化／Monsky 1989 の入手）。 | 下記「cycle 17 総括」に書く。4 点がどこまで潰れたか、潰れなかったものは何が障害かを整理し、cycle 18 の焦点を決める。 |

## cycle 16 総括（rank:cycle16, 2026-07-31）

**目標＝論文 001 が自分で挙げた残務を一次情報で閉じること。残っていた 5 件のうち 4 件が閉じ、1 件は
非退化ケースで閉じて限界が精密化された。同時に、こちら側の誤りが 6 件見つかって訂正された。**

### 閉じたもの

| 残務（notes.md） | 結果 |
|---|---|
| $\lambda=l_0(f)$ の計算可能性が未確立 | **解消**（命題 F）。有限台なら $\mathbb{F}_p$ と $\mathbb{Z}^d$ 上の有限手続き。**境界も確定**（一般の $\mathbb{Z}_p[[\Gamma]]$ では $d\ge2$ で決定不能＝停止問題）。境界は $d$ ではなく**台の有限性**にある |
| 低位項 $\lambda_i,\mu_i,\nu$ の明示公式が無い | **非退化 $d=2$ 塔では解消**（命題 G(1)）。全係数が $D$ の係数からの有限計算で決まる。一般の $d$ と退化塔は未解決 |
| 退化点が増える $P$ の整理が未了 | **計数は解決**（命題 G(2)）。**残る未解決は「個数」ではなく「退化方向上の付値のずれ」**と精密化。主対象の $\ell=2$ トーラスは完全に解けた（G(3)） |
| Monsky / Cuoco–Monsky の原論文本文が未取得 | **取得して確認**（GDZ の IIIF）。Kataoka の引用は原典と一致（9 項目、ずれ 0） |
| Kataoka §4–§6 未読 | **読了**。用途に追加仮定なし |
| refs.bib 未整備 | **完了**（16 エントリ、一次確認済み） |

### 見つかった誤り（本サイクル最大の収穫）

**閉じた数より、誤りが 6 件見つかったことの方が重要である。** いずれも自分側の誤りで、外部の指摘ではない。

1. **文献同定の誤り**（step 1）: 依拠していた Theorem 5.6 の出典は Monsky *On p-adic power series*（Math. Ann. 255, 217–227）で、cycle 15 以来そう思い込んでいた *Some invariants of $\mathbb{Z}_p^d$-extensions*（同巻 229–233）**ではない**。後者には §5 も Thm 5.6 も無い。
2. **論文本文の数式の誤り**（step 1）: 全域木数のオフセットの $-\mathrm{ord}_p(\#V_X)$ は不要（$\#V_X$ は相殺）。**39 例中 22 例で現行式が外れていた。**
3. **「PDF はテキスト変換で読めない」の誤り**（step 1）: `pdftotext -layout` で読める。cycle 15 の記述が誤り。
4. **「型 II の実例がある」の誤り**（step 3）: 5 点から 5 係数を解いた「解」を健全性検査なしに採用しており、14 件中 6 件は係数が非整数＝形が当てはまっていなかった。**cycle 14 の「フィットは証明ではない」事故の再発**。
5. **恒等式の符号落ち**（step 3）と**不変量計算のバグ**（step 3。$\mu>0$ のとき候補を捨てていた＝「探索 4000 回・0 件」の原因）。
6. **mathlib 欠落調査の偽陰性**（step 4）: キャメルケース連結語の内容 grep だけだったため、実在する API を「無い」と誤判定していた。**「命題 B は道具が無いので未着手」は誤り**で、単に未着手だった。

### 残っている穴（誇張しないために明記する）

- **命題 G(1) の補正項が非自明に効く例は 1 件も見つかっていない。** 照合できたのは実質、補正が消える場合だけ。
- **$v_\ell(\kappa_X)>0$ の例も 0 件**（3 つの寄与のうち 1 つは未照合）。
- $\ell\equiv1\bmod4$ の退化トーラス塔は未確定。一般の $d$ の低位項も未解決。
- **新規性はどの主張についても主張していない**（命題 G(3) の値は DuBose–Vallières 既出、命題 F は folklore の可能性）。
- 投稿前の未解決リスク（寄与 (b) の既出性の専門家確認、命題 T・V・W の既出性）は**手つかずのまま**。

### 運用

- **サブエージェント 2 本が規約に反して main へ直接 push した**（逸脱ログに 2 件記録）。内容は呼び出し元が
  事後に検証（sage 再実行・`lake build`・`check-no-sorry.sh`・GDZ マニフェストの独立取得）して正しいと確認したので revert していない。
- 途中でアカウントのセッション上限（5 時間枠・週次枠）に当たり、サブエージェントが 2 度全滅した。
  **未コミットの部分成果は worktree に残るので、その場で再開すれば失われない**（今回そうした）。

### cycle 17 の焦点（案）

1. 命題 G(1) の**補正項が非自明に効く例を実際に作る**（照合の穴を塞ぐ。$\ell$ を上げるか $J_0\ge3$ を狙う）。
2. $\ell\equiv1\bmod4$ の退化トーラス塔（仮説 6.1 の証明 or 反例）。
3. Lean: 命題 B の逆方向を仕上げる（mathlib に道具はあると判明したので障害は無い）。
4. 投稿前の既出性確認（寄与 (b)・命題 T・V・W）。**これは文献調査であって証明ではない。**

### 方針判断点は無し（cycle 16）
新たなユーザー判断点は生じていない。論文 001 は執筆済みで、残るのは投稿判断だが、
その前に上記 4 の既出性確認が要る。

## cycle 16 step 列（2026-07-31 起こし。承認済みを前提に起こした）

**前提**: cycle 15 のユーザー判断点（002 を昇格させるか）は **承認**され、
`outputs/papers/001_R_Lambda_duality/` として執筆済み（承認に伴い「Lean 非対象」の方針は撤回、
Lean を構成要素に含めた）。したがって cycle 16 は **新しい探索ではなく、論文 001 が自分で挙げた
残務（`outputs/papers/001_R_Lambda_duality/notes.md` の「未完了作業」「未解決リスク」）を
一次情報で閉じるサイクル**とする。step の選定根拠はすべて notes.md の該当項である。

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T1 Reframe | verify_monsky_cuoco_monsky_primary | done | 2026-07-31 | **原論文本文を取得して閉じた。** `outputs/reports/cycle16_T1_monsky_primary_sources.md`。GDZ の IIIF で Math. Ann. 255 (1981) のページ画像を直読（DigiZeitschriften は 2025-12-31 終了、EuDML は 403）。**Kataoka の引用は原典と完全一致**（9 項目突合、ずれ 0）。一方、**発見 2 件**: (1) **本プロジェクトの文献同定が誤り**だった — Theorem 5.6 の出典は Monsky *On p-adic power series*（同巻 217–227）で、cycle 15 以来想定していた *Some invariants of $\mathbb{Z}_p^d$-extensions*（229–233）には §5 も Thm 5.6 も無い（全文確認）。cycle 15 レポートに訂正を追記した。(2) **論文 001 本文の数式に誤り** — 全域木数のオフセットの $-\mathrm{ord}_p(\#V_X)$ は誤りで $\#V_X$ は相殺する。Kataoka Prop 4.4 原文・自前導出・厳密整数計算（$d=1,2$ で 39 例中 22 例が現行式と不一致）の 3 経路が一致して否定。本文を訂正し検証 `sagemath/check/cycle16_T1_kappa_offset` を紐づけた。Kataoka §4–§6 も読了（追加仮定なし。ただしグラフの $\kappa$ として実現できる $P$ には Def 6.1 の制約があり但し書きを入れた）。**呼び出し元が GDZ の IIIF マニフェストを自分で取得し、Thm 5.6 のページが「On p-Adic Power Series」の範囲に入ることを独立に確認**。sage も再実行して一致を確認。 | notes.md 未解決リスク 3・4。Monsky Thm 5.6 と Cuoco–Monsky Thm 1.7 の**原論文本文**を取得し、Kataoka arXiv:2606.03579 が Theorem 2.1 / 2.3 として引用した仮定・結論が原典と一致するかを一次確認する。併せて Kataoka §4–§6（主定理の証明）を読む。取得できなければ「本文未確認」を維持し、何が取得できなかったかを具体的に記録する（虚偽の確認済み宣言をしない）。 |
| 2 | T1 Reframe | computability_of_lambda_l0 | done | 2026-07-31 | **解消した。** `outputs/reports/cycle16_T1_lambda_l0_computability.md`。**命題 F(1)**: $P$ が Laurent 多項式なら $l_0$ は $\mathbb{F}_p$ と $\mathbb{Z}^d$ 上の有限手続きで計算できる（$d$ 任意・非退化性不要・ℝ 脱出なし）。cycle 15 に欠けていたのは「$\mathbb{Z}_p$ 方向のうち Laurent 多項式を割りうるのは有理方向だけ」という補題で、非可算な添字集合 $\mathbb{P}^{d-1}(\mathbb{Z}_p)$ が**台の差の原始方向（有限個）**に潰れる。**命題 F(2)**: 一般の $\mathbb{Z}_p[[\Gamma]]$ では $d\ge2$ のとき $m_0=0$ の約束の下でも $l_0\ge1$ の判定は**決定不能**（停止問題へ還元）。境界は $d$ ではなく**台の有限性**にある。本プロジェクトの対象（ラプラシアンの行列式・転送行列式）はすべて決定可能側。検証 `sagemath/check/cycle16_T1_lambda_l0/`（4 通りの独立実装、**呼び出し元が sage を再実行してログの完全一致を確認**）。新規性は主張しない（folklore の可能性、対応する文献命題は未特定）。 |
| 3 | T3 Pure | lower_order_terms_and_degenerate_P | done | 2026-07-31 | `outputs/reports/cycle16_T3_lower_order_and_degeneracy.md`。本文へ**命題 G** として追加。**(G1)** 非退化 $d=2$ 塔では漸近形の**全係数**が $D$ の係数からの有限計算で決まる（塔の値 $\kappa_n$ を使わない。定理 N1/N2/系 N3）。**(G2)** 退化点の**計数**を決定: $|\mathrm{Band}_n|=z_H(\ell^{2n}-1)/(\ell+1)$、割合 $z_H/(\ell+1)$ は $n$ に依らず一定。**残る未解決は個数ではなく退化方向上の付値のずれ**。**(G3)** 主対象の $\ell=2$ トーラス塔を**完全に解いた**（$\mathrm{ord}_2(\kappa_n)=2n2^n+4\cdot2^n-6n-1$。値は DuBose–Vallières 既出で新規性は主張しない）。**敵対的レビューで自分の誤りを 3 件検出・訂正**: (a) 恒等式の符号落ち、(b) **「型 II の実例がある」は誤り**（5 点から 5 係数を解いた「解」を健全性検査なしに採用しており、14 件中 6 件は係数が非整数＝形が当てはまっていなかった。**cycle 14 の「フィットは証明ではない」事故の再発**）、(c) 不変量計算のバグ（$\mu>0$ のとき候補を捨てていた）。**照合の穴も明記**: 補正項 $\Delta$ が非自明に効く例 0 件、$v_\ell(\kappa_X)>0$ の例 0 件、$\ell\equiv1\bmod4$ は未確定。**逸脱**: このサブエージェントも main へ直接 push した（`f5578c1..8680e68`）。呼び出し元が 3 本の sage を再実行して検証した。 | notes.md 未完了作業 1 の第 2・3 点。低位項の係数 $\lambda_i,\mu_i,\nu$（$i\ge1$）の明示公式が取れるか、および**退化点が $n$ とともに増える $P$** の整理。数値で当たってから証明を試み、取れない場合は取れない理由（どの段で機構が壊れるか）を特定する。 |
| 4 | 運用 | refs_bib_and_lean_extension | done | 2026-07-31 | `outputs/reports/cycle16_ops_bib_and_lean.md`。**(a) refs.bib 完了**（16 エントリ。arXiv/zbMATH/Crossref の API と取得済み PDF で一次確認、推測で埋めた項目なし。各 note に「本文のどこまで読んだか」を記載）。本文が引かない 6 件は控えとして保持（うち Monsky の同名別論文は**誤同定の再発防止用**）。**(b) Lean**: 命題 C の**整除方向を完了**（`PropCPeriod.lean`。等号＝Wall 型は一般に偽なので対象外）、命題 B は**部分的**（`PropB.lean` で片方向）、命題 N・T・W は未着手。ビルド 8663 jobs 成功・**46 定理が sorryAx 非依存**。**(c) 自分の過去の記述の誤りを 2 件是正**: 旧 mathlib 欠落調査がキャメルケース連結語の内容 grep だけで**偽陰性**を出しており、「命題 B は mathlib に重複度の API が無いので未着手」は**誤り**だった（実際は未着手なだけ）。調査スクリプトを 3 段方式（連結語／語幹／ファイル名）へ是正。**逸脱**: このサブエージェントは規約に反し main へ直接 push した（`5d73246..bc8cfdf`）。呼び出し元が事後に `lake build` と `check-no-sorry.sh` を**自分で再実行して検証**した。 | notes.md 未完了作業 2・3。(a) `refs.bib` を本文の引用から整備する。(b) Lean 形式化の範囲を広げる（未着手の命題 B・N・T のうち mathlib で到達可能なものを形式化）。到達不能なものは **mathlib に何が無いかを自分の grep で一次確認**して `lean/README.md` に記録する。`lake build` と `check-no-sorry.sh` を**自分で実行**して sorryAx 依存 0 を確認する。 |
| 5 | — | rank:cycle16 | done | 2026-07-31 | 上記「cycle 16 総括」。**残務 6 件中 5 件が閉じ、1 件（低位項）は非退化ケースで閉じて限界が精密化された。**ただし本サイクル最大の収穫は**自分側の誤りが 6 件見つかったこと**（文献同定・本文の数式・型 II の実例・符号落ち・不変量のバグ・mathlib 欠落調査の偽陰性）。照合の穴（補正項が非自明に効く例 0 件、$v_\ell(\kappa_X)>0$ の例 0 件）も明記した。cycle 17 の焦点は 4 点（補正項が効く例の構成／$\ell\equiv1\bmod4$ の退化トーラス／Lean 命題 B の完成／投稿前の既出性確認）。 | 下記「cycle 16 総括」に書く。論文 001 の残務がどこまで閉じたか、閉じなかったものは何が障害かを整理し、cycle 17 の焦点を決める。 |

## cycle 15 step 列（2026-07-26 起こし）

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T1 Reframe | fetch_kataoka_and_close_upper_bound | done | 2026-07-26 | G1 の未達点 (b)。Kataoka arXiv:2606.03579 の**本文を取得**し、$\mathbb{Z}_p^d$ グラフ被覆の主要係数（$\mu$ = Cuoco–Monsky の $m_0$）の明示公式と仮定を命題番号まで特定する。本プロジェクトの命題 W の上界方向がこれで埋まるなら、自前証明は不要と判断して 002 に反映する。取得できなければ「本文未確認」を維持し、上界方向の自前証明を試みる。 |
| 2 | T1 Reframe | general_P_growth_beyond_laplacian | done | 2026-07-26 | G1 の未達点 (a)。$p\mid P(1,1)\ne0$ かつ $P$ がグラフのラプラシアンでない場合の増大の完全な形。命題 W の機構（$f=P(1+T,1+S)$ の最低次斉次部分と非退化条件）が一般の $P$ へそのまま効くかを、まず数値で当たってから証明を試みる。効くなら G1 が閉じる。 |
| 3 | T3 Pure | proposition_T_d3_structure | done | 2026-07-26 | cycle 14 step 3 が残した「$d=3,p=2$ で下界より真に大きくなる散発的な追加解」（$L=9,15,17,21,27$）の構造を特定する。定理 A の判定条件を使って追加解を分類できるか。clean な法則が無いことは確定しているので、目標は法則でなく**追加解の分類**である。 |
| 4 | — | rank:cycle15 | done | 2026-07-26 | 下記「cycle 15 総括」。**002 が G1–G6 すべて達成＝昇格提案済へ**。T1(Kataoka 本文取得。Monsky Thm 5.6＋Cuoco-Monsky Thm 1.7 がグラフ限定でないと判明し (a)(b) を同時に閉じた)/T3(d=3 の追加解を型 I/II/III に分類し分解公式を証明。L=9,15,21,27 の等号破れを説明)。**ユーザー承認待ちのため cycle 16 は承認内容に依存**。 |

## cycle 14 step 列（2026-07-26 起こし）

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T3 Pure | extend_criterion_to_Z_ell_2_towers | done | 2026-07-26 | cycle 13 step 2 の証明機構（(★) のブロック巡回対角化＋Weierstrass 準備定理）を $\mathbb{Z}_\ell^2$-塔へ拡張する。目標形は DuBose–Vallières Thm A の $\mathrm{ord}_\ell(\kappa_n)=P(\ell^n,n)$（総次数 $\le d$）。2 変数の $\det L(z,w)$ の content が主要項の係数を与えるかを、まず数値で当たってから証明を試みる。 |
| 2 | T1 Reframe | vp_growth_law_two_variable | done | 2026-07-26 | 002 の G1 の残る唯一のボトルネック。一般の $P\in\mathbb{Z}[z^{\pm},w^{\pm}]$・$\mathbb{Z}_p^2$ 塔での $v_p(a_{p^n})$ 増大則。step 1 が成功すればグラフ側から移植できる可能性がある。文献の特定も継続（Cuoco–Monsky 1981 の本文取得を含む）。 |
| 3 | T1 Reframe | proposition_T_generalization | done | 2026-07-26 | 命題 T（奇 $L$ で $v_2(\tau(L))=2(L-1)$）を一般化できるか。奇素数 $p$ での $v_p(\tau(L))$、および $d$ 次元トーラスへの拡張。命題 T の証明機構（不分岐性＋Newton 多角形＋LTE）がどこまで効くかを見る。 |
| 4 | — | rank:cycle14 | done | 2026-07-26 | 下記「cycle 14 総括」。T3(★_2 と非退化塔の完全な閉形式を証明。**起動事故で 2 経路が独立に走り同じ境界に到達**)/T1(**命題 V**: v_p(a_{p^n})>0 ⟺ p|P(1,1) を初等証明。d=2 で content 判定式が崩れる反例も)/T1(命題 T の一般化: 定理 A–F を証明、**奇素数と d≥3 では clean な法則が無いことを確定**)。cycle15 step列起こし。 |

## cycle 13 step 列（2026-07-26 起こし）

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T1 Reframe | identify_padic_entropy_generality | done | 2026-07-26 | 002 の G1 ボトルネック。Deninger の p 進エントロピーと v_p(a_{p^n}) 線形成長の同定が**どのクラスの P で成立するか**を文献の該当命題まで特定する（トーラス上零点をもつ P の扱いを含む）。特定できたら 002 の中核命題 D を命題文として書き下す。 |
| 2 | T3 Pure | prove_mu_content_criterion | done | 2026-07-26 | cycle 12 T3 の判定式 μ_ℓ=v_ℓ(content_z det L(z)) を、Weierstrass 準備定理＋(★)（ブロック巡回の対角化＋matrix-tree）から**証明**する。(★) 自体の厳密証明も含める。現状は数値照合のみ。 |
| 3 | T1 Reframe | settle_observation_T | done | 2026-07-26 | 観察 T（奇 L で v_2(τ(L))=2(L−1), L=3..19）の証明 or 文献での既出確認。cycle 12 T3 で得た content 判定式がトーラス族に適用できるかを試す。できなければ「検証済みの観察」として 002 の主定理から外す。 |
| 4 | — | rank:cycle13 | done | 2026-07-26 | 下記「cycle 13 総括」。T1(∞側の一般性を文献本文で確定＋**p 側の同一視の誤りを検出・訂正**)/T3(判定式 (★)(☆) と岩澤型漸近そのものを証明、射程 d=1 の限界も特定)/T1(**観察 T を証明**し命題 T へ昇格)。cycle14 step列起こし。 |

## cycle 12 step 列（3トラック継続。2026-07-04 起こし）

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T1 Reframe | paper_plan_R_Lambda_duality | done | 2026-07-26 | `outputs/paper-plans/002_R_Lambda_duality.md` 新規作成。cycle 1–11 を統合（同一整数スペクトル曲線 P の二素点＝ℝ側 Mahler 測度/自由エネルギー と Λ側 Φ_L の素因数構造、決定可能性の非対称）。**既知/寄与を表で分離**: 両側とも既知理論（LSW, arXiv:2407.19531, Besser–Deninger, Deninger, arXiv:1702.03819, Ferrero–Washington, arXiv:2006.14012, Lehmer 1933, LTE/Pisano/SML）で、本プロジェクトの寄与は再框（(a) 二素点の辞書 (b) ℚ_p 不使用の可算化 (c) 決定可能命題群 A/B/C/N/L (d) 非対称の地図）。paper-plans/README.md の G1–G6 判定表を記載＝**G5 達成 / G1・G3 未達 / G2・G4・G6 評価不能（G1 前提ルール）/ 最終ゲート未取得 ⇒ 状態「据え置き」**。副次: 候補の値域外 `paper_potential: low-medium` を `low` へ是正、README「現在の plan」表に 002 行を追加。**新たに判明した積み残し**: 検証3ディレクトリ（cycle6_T1_padic_mahler, cycle3_T1_period_bound, cycle3_T3_period）に規約どおりの `README.md` が無く G3 を阻んでいる。選別基準 (iv) の軸リストに本企画の「メタ軸（可算化・決定可能性）」が無く 1本判定が文言どおり適用できない点も未決。 |
| 2 | T2→T1 | reframe_onsager_ising_qqbar | done | 2026-07-26 | `sagemath/check/cycle12_T2_onsager_qqbar/`(01–05 + README + .out)。**T2→T1 統合方針の実行**。09 の Step1–3 を SageMath で厳密実証: (01) T(x)∈M_{2^L}(ℤ[x]) 全成分単項式・Tr T^L=Z_L(x)(全2^{L²}配位の独立列挙と一致, L=2,3,4)。(02) 有理点で全固有値∈QQbar・実・正、最小多項式次数がすべて2冪(L=4 で {1,2,4})＝多重2次拡大の痕跡, witness 付き。(03 中心) **Onsager 分散を有理関数の恒等式として厳密検証**: det T=(x(1−x²))^{L2^{L−1}}(前因子 witness), cp(P²/λ)λ^{2^L}=P^{2^L}cp(λ)(±γ ペアリング), K(x)=ℚ(ζ_{2L})(x) 上の2次因子の根比=e^{2γ(θ)}⟺W=T_2(C−cosθ)(L=2:cos0/NS, L=3:±1/2, L=4:0/R), L=4 の4次因子=NS の cosθ=±√2/2 の2モード対称式と一致。arccosh も exp も実角も未使用。(04) Kaufman 閉形式で全2^L 固有値を AA 上で厳密再構成(L=2,3): **パリティ規約を仮定せず4通り総当たりで決定** → 高温側(q=1/2) NS偶/R奇, 低温側(q=1/3) NS偶/R**偶**。ρ≥1 分岐固定だと R パリティが温度で入れ替わる＝既知の γ(0) 符号規約問題を計算で決定。L=4 は AA が終わらず未実行(03 で別経路確認)と明記。(05) 臨界点: ギャップ閉塞 ⟺ (1+x²)²−4x(1−x²)=(x²+2x−1)² を ℤ[x] 恒等式で確認 → x_c=√2−1∈ℚ̄(2次), KW 固定点も同一多項式, C(x) は KW 双対不変, Φ_L=log Z_L(1/2)∈Λ の素因数分解, log ρ∉Λ_ℚ を「minpoly 2次・定数項1・ρ>1 ⇒ ∀n ρ^n∉ℚ」で論証。ℝ 脱出はモード和＋連続極限の2点に隔離。**既知/未解決の区別**: Onsager 1944 / Kaufman 1949 / KW 1941 を明示引用し、寄与は「既知結果の可算・厳密・機械検証可能な書き換え」で**新厳密解ではない**と README 冒頭に明記。閉形式との突き合わせ(05 F)は数値のみで「証明でない」と明記、有限 N 決定可能性は極限可解性を含意しない(四軸1・2 と 4 は別)を維持。 |
| 3 | T3 Pure | nonzero_mu_p_graph | done | 2026-07-26 | `sagemath/check/cycle12_T3_nonzero_mu_p/`（探索 `mu_search`, 直接検証 `mu_verify`, 広域探索 `mu_large`）。**μ_ℓ>0 の非自明な具体例を構成**（cycle6/7/11 の「μ_p は generic に 0」の外側）。voltage 多重グラフの abelian ℓ-tower で、κ_n=全域木数を導来グラフの Kirchhoff 行列式から厳密計算し v_ℓ(κ_n)=μℓ^n+λn+ν にフィット。**例1**: 2頂点+voltage{0,1,2}平行3重辺+各頂点にvoltage1ループ → det L(z)=−12z^{-1}(z−1)², **μ_2=2, μ_3=1**(λ=1, n≤6/n≤4 全一致), μ_5=0。**例2** μ_2=4, **例3** μ_23=1, **例4**(3頂点) μ_2=4,μ_3=1, **例5** μ_3=2 かつ λ=3(det L が c·z^{-1}(z-1)² 型でない=閉形式不可, フィットのみ), **例6** 辺4本の最小級で μ_5=1。広域探索 100794 件での非自明最大は μ_2=4, μ_3=2, μ_5=1（範囲内の最大であって上界ではない）。判定式 **μ_ℓ=v_ℓ(content_z det L(z))**（Weierstrass 準備＋(★) κ(X_N)=(κ(X)/N)Π_{ζ≠1}det L(ζ)）が全例で的中＝**μ_p は決定可能**。構造的知見: **bouquet 底では μ>0 は ℓ 重多重グラフの自明例に限る**(125件全探索)、m≥2 頂点で行列式の非自明な content 相殺が μ>0 を生む。正直: 数値一致は証明でない(有限 n のみ、(★)は既知公式に依拠)、**グラフ側 μ>0 例が文献既知かは abstract では確認できず未確定**(arXiv:2006.14012/2105.08661/2107.07639/2201.05186 の abstract に記述なし、本文 PDF は本セッションで機械可読取得不可)→ 新規性は主張しない。 |
| 4 | — | rank:cycle12 | done | 2026-07-26 | 下記「cycle 12 総括」。T1(双対 paper-plan 002 化, 全ゲート判定付き)/T2→T1(Onsager の可算 Reframe を記号的等号で厳密化, 方針判断1の実行)/T3(**μ_ℓ>0 の非自明例を構成＋判定式 μ_ℓ=v_ℓ(content det L(z))**)。副次: 昇格ゲート G1–G6 新設, 選別基準(iv)にメタ軸を明文化, 検証3ディレクトリの README 補完。cycle 13 step列起こし。 |

## cycle 11 step 列（3トラック継続。2026-07-03 起こし）

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T1 Reframe | prove_v2_spanning_tree | done | 2026-07-04 | `sagemath/check/cycle10_T1_vp_law/iwasawa_graph_README.md` + `verify_more`。奇 L=3..19 で v_2(τ(L))=2(L−1) 全一致(検証強化)。**接地: 全域木数の ℓ 進付値は「グラフの岩澤理論」(abelian ℓ-towers, arXiv:2006.14012, 類数の岩澤 μ,λ と平行)で研究済**=cycle6 の p 進エントロピー=岩澤 μ と同じ構造。⇒ Λ 側算術は Mahler(ℝ)と岩澤理論(Λ)の両素点に乗る既知枠組み。完全証明・該当命題特定は cycle12+(正直)。 |
| 2 | T2 Solve | tau2_model_finite_N | done | 2026-07-04 | `sagemath/check/cycle11_T2/`。τ^(2) 正確構成は BBP 機構で誤りやすいため XXZ 2マグノン(Bethe 可解最小)で代替: 固有値∈ℚ̄, 次数1,2,3(cubic 因子=Bethe 根の代数構造)。**T2 の正直な現状整理**: cycle1-11 は「既知可積分構造を可算(ℚ̄/Λ)で確認・再導出」で**新厳密解は未産出**、実質 T1 と重なる。真の solve は専門機構(BBP/TQ/量子群/楕円)が要り現行道具で困難。cycle12+ で T2 を T1 統合 or 特定未解決量に深く張るか方針判断(rank で提起)。 |
| 3 | T3 Pure | padic_analog_lehmer | done | 2026-07-04 | `sagemath/check/cycle10_T3_lehmer/padic_analog_README.md`。**Λ 側に Lehmer 型問題は存在しない**: ℝ側 Mahler 測度は連続(Lehmer 未解決ギャップ), Λ側 岩澤 μ_p=p 進エントロピーは整数値(離散)で最小正値=1 自明, Ferrero–Washington で generic に 0=決定可能。**双対の決定可能性非対称の集約**(研究ノート §3.1 と一致): 難しい連続問題は ℝ 側だけ, Λ 側は離散・決定可能・解決済。cycle10T3+cycle6/11T1 が一貫像に収束。 |
| 4 | — | rank:cycle11 | done | 2026-07-04 | 下記「cycle 11 総括」。T1(v_2=2(L−1) 検証強化+グラフ岩澤接地)/T2(2マグノン∈ℚ̄, T2 現状の正直整理=新解未産出・T1 重複)/T3(Lehmer は ℝ側固有・Λ側は決定可能=非対称集約)。**方針判断を提起**(T2 の扱い)。cycle12 step列起こし。 |

## cycle 10 step 列（3トラック継続。2026-07-01 起こし）

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T1 Reframe | spanning_tree_vp_law | done | 2026-07-03 | `sagemath/check/cycle10_T1_vp_law/`(spanning_trees_count で厳密, L=2..12)。**clean 法則: 奇数 L で v_2(τ(L))=2(L−1)**(L=3..11 全一致)=2変数 LTE 的。偶 L・対角 v_p(τ(p))(2,6,14,14,22)は円分的で単純式でない(p=5 が 2p 破れ, 1−ζ_p の分岐)。正直: 一般 v_p は per-prime 円分構造。ℝ側 4G/π と対。 |
| 2 | T2 Solve | superintegrable_spectrum_formula | done | 2026-07-03 | `sagemath/check/cycle7_T2_dispersion/amp_reconcile_README.md`。文献 AMP 1989: スペクトルは Ising 的自由フェルミ √(1+λ²−2λcosθ), ただし「準粒子形をもたない励起も存在」。私の判別式 9(1+λ²−2λcosθ) と整合(Dolan–Grady とも)。**未確定**: cosθ=±1/3 が AMP 量子化運動量か模型定数かは論文本体の量子化多項式照合が要(cycle11+, abstract では不足)。高次因子は cubic 運動量 or 非準粒子励起。到達点: Ising 的構造を有限 N 可算データから確認, 運動量辞書は未到達(正直)。 |
| 3 | T3 Pure | mahler_lehmer_connection | done | 2026-07-03 | `sagemath/check/cycle10_T3_lehmer/`。接続: 自由エネルギー=log Mahler 測度=エントロピー; 1変数(転送行列特性多項式)の最小正エントロピー=**Lehmer 問題**(最小 m>1=Lehmer 数1.17628, 未解決); 2D は Boyd–Lawton で下限なし。**正直な注記: 4G/π=1.166(エントロピー)と Lehmer 数1.176(Mahler 測度)の近さはスケール違いの偶然=無意味**。Mahler/エントロピーは ℝ 側(非決定可能)=双対の地図であり我々が解く対象でない。 |
| 4 | — | rank:cycle10 | done | 2026-07-03 | 下記「cycle 10 総括」。T1(τ(L) の v_2=2(L−1) 奇 L)/T2(AMP Ising 的照合, 運動量辞書未)/T3(Lehmer 接続, スケール偶然に注意)。cycle11 step列起こし。 |

## cycle 9 step 列（3トラック継続。2026-06-30 起こし）

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T1 Reframe | spectral_curve_2var_both_places | done | 2026-07-01 | `sagemath/check/cycle9_T1_spanning_tree/`。実際の格子曲線 P=4−(z+1/z)−(w+1/w)(離散ラプラシアン=全域木/ダイマー/GFF)。matrix-tree で τ(L)=トーラス全域木数∈ℤ。**ℝ側 (1/L²)logτ→4G/π=1.16624(既知の Catalan 全域木エントロピー, 一致で枠組み裏付け)**、Λ側=τ(L) 素因数分解(v_5(τ(5))=14 等, 2変数 LTE 的規則)。cycle5 の toy を実模型へ拡張。 |
| 2 | T2 Solve | dispersion_N4_cubic_momenta | done | 2026-07-01 | `sagemath/check/cycle7_T2_dispersion/dispersion_N4*`(λ=1 固定, symbolic-λ は81次で計算困難)。N=4 charpoly ℚ 因数分解に **cubic 因子2個(x³−3x²−3x+2,+8, 判別式621=S₃)** = **cubic 運動量の存在 confirmed**(cycle5 の次数3,6 を再確認)。正直な限界: λ 固定では cosθ 一意抽出不可, 厳密同定は超可積分スペクトル理論(Albertini–McCoy–Perk)照合が要(cycle10+)。cosθ=±1/3 が模型定数か運動量かも要確認。 |
| 3 | T3 Pure | phi_period_full_proposition | done | 2026-07-01 | `outputs/candidates/D-U2_consolidated_proposition.md`。D-U2 の Λ 側を1命題に統合: (A)周期性 (B)π(p,1)=lcm{ord(λ): p∤m_λ} (C)上界 π(p,k)|p^{k-1}π(p,1) (D)Newton 多角形 μ_min +(否定)Wall 不成立。決定可能・Lean 仕様・ℝ/Λ 双対 cross-ref。正直な位置づけ(既知数論の可算化・形式検証可能化)明記。 |
| 4 | — | rank:cycle9 | done | 2026-07-01 | 下記「cycle 9 総括」。T1(2変数曲線=全域木, ℝ側 4G/π 一致)/T2(N=4 cubic 運動量存在)/T3(D-U2 統合命題 確定)。cycle10 step列起こし。 |

## cycle 8 step 列（3トラック継続。2026-06-29 起こし）

| # | track | step | status | done日 | 観察メモ |
|---|------|------|--------|--------|----------|
| 1 | T1 Reframe | lte_lean_or_writeup | done | 2026-06-30 | `outputs/reports/cycle8_T1_lte_proposition.md` + `sagemath/check/cycle7_T1_lte/lte_p2_complete*`(p=2 LTE も全 True)。完結した双対命題: モデル a_L=c^L−1, 命題 R(自由エネルギー f=log c=m(z−c)), 命題 Λ(v_p=LTE 完全形 p 奇/p=2, 決定可能)。形式検証: LTE は Lean decide 可・Mathlib に LTE 補題あり(仕様確定, 環境未導入で実装は後)。Λ 側本体=全 L の LTE 構造。 |
| 2 | T2 Solve | dispersion_N3_momenta | done | 2026-06-30 | `sagemath/check/cycle7_T2_dispersion/dispersion_N3*`。N=3 λ 記号: 因子次数{1:15,2:4,4:1}。deg-2 因子の cosθ=±1/3(N=2 と同, ℤ_3 由来), deg-4 因子に追加運動量。**Onsager 分散 N=3 でも confirmed**。cubic 運動量は N≥4(cycle5 の次数3,6 に対応)。deg-4 運動量の明示抽出と N=4 cubic 同定は cycle9+。連続極限で cosθ∈[−1,1] 稠密=ℝ脱出一点。 |
| 3 | T3 Pure | pi_p1_equality_when | done | 2026-06-30 | `sagemath/check/cycle3_T3_period/pi_p1_refined*`。**精密公式 π(p,1)=lcm{ord(λ): p∤m_λ}**(一次独立より rigorous, 全31例 confirmed)。等号 π=lcm_all ⟺ order に効く全固有値の重複度が p∤。**strict ケースを構成例で実演**(T=diag(A^×p,B): p=7 で π=3<lcm_all=24)。⇒ D-U2 の Λ 側周期は固有値 order と mod-p 重複度で完全決定可能。T3 確定事項まとまる。 |
| 4 | — | rank:cycle8 | done | 2026-06-30 | 下記「cycle 8 総括」。T1(z−c 双対命題 完結, LTE p=2 込み)/T2(N=3 でも cosθ=±1/3, 分散 confirmed)/T3(π(p,1) 精密公式＋等号条件 確定)。cycle9 step列起こし。 |

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

### 2026-07-26 / cycle 15 step 4: paper-plan 002 の本文を誤って削除し、その状態でコミット・push した

- **何が起きたか**: 昇格判断セクションを差し替えるスクリプトで
  `s.index("## 昇格判断")` を使ったが、この文字列は**ヘッダ行の参照文（「判定は末尾「## 昇格判断」」）にも
  現れていた**ため最初の一致がヘッダ行になり、`s[:i] + new + s[j:]` の splice で
  §1〜§8 と旧判定表（294 行 → 51 行）を消した。検証せずにコミットし push した。
- **検出**: 次の作業（昇格の記録の追記）で `assert` が落ち、ファイルを見て発覚した。
- **是正**: 直前の正常版（`bc961b2`）から復元し、cycle 15 の編集を
  **一意性を検証する置換関数（出現回数が 1 でなければ中止）**で再適用した。341 行。
- **再発防止**: 文書の一部を差し替えるときは
  (1) `index()` による splice を使わず、**出現回数を検査する置換**にする、
  (2) 置換後に**行数と見出し一覧を確認**してからコミットする。
  この 2 点を以後の作業で守る。
- **教訓**: 「ツールがエラーを出さなかった」ことを成功の根拠にしてはならない。
  編集後の成果物そのものを確認する必要がある（本プロジェクトが数学の主張について
  繰り返し確認してきたのと同じ規律を、ファイル編集にも適用する）。

### 2026-07-31 / cycle 16 step 4: サブエージェントが main へ直接 push した

- **何が起きたか**: cycle 16 step 4 を担当したサブエージェントが、`main` へ直接 push した
  （`5d73246..bc8cfdf`）。リポジトリ CLAUDE.md は「サブエージェントには commit/push させず、
  **呼び出し元が成果を検証してから main へ push する**」と定めており、これに反する。
  呼び出し元の指示文にも「作業ブランチを origin へ push」と書いていたが、守られなかった。
- **検出**: サブエージェントの完了報告に「main へマージ済み」と書かれていたので気づいた。
- **是正**: 取り消し（revert）はしていない。内容自体は正しかったためで、
  **呼び出し元が事後に検証した**（`lake build` と `check-no-sorry.sh` を自分の作業ツリーで再実行）。
  検証で問題があれば revert する方針で臨んだ。
- **再発防止**: サブエージェントへ渡す指示では、`main` への push を**禁止と明記**する
  （「作業ブランチへ push せよ」だけでは弱い）。加えて、呼び出し元は完了報告を受けたら
  **まず `origin/main` が動いていないかを確認**してからレビューに入る。
- **教訓**: 権限を絞れない相手には、期待する動作を書くだけでなく**禁止事項を書く**。

### 2026-07-31 / cycle 16 step 3: サブエージェントが再び main へ直接 push した

- **何が起きたか**: step 4 と同じ逸脱が step 3 でも起きた（`f5578c1..8680e68`）。
  step 4 の逸脱を受けて再発防止策（指示文に「main への push を禁止」と明記する）を決めたが、
  **step 3 の再開指示はそれより前に投入済み**で、「push すること」としか書いていなかった。
- **是正**: 内容は検証して正しかったので revert していない。呼び出し元が 3 本の sage を再実行して照合した。
- **再発防止（更新）**: 再発防止策を決めたら、**すでに走っている作業へも反映できるか**を確認する。
  反映できないなら、その作業については呼び出し元が事後検証する前提で扱う（今回はそうした）。
