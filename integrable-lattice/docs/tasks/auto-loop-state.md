# 自動ループ 状態（Λ-statement 版）

daily cron が読み書きする状態ファイル。手順は `auto-loop-runbook.md`、収集定義は `inputs/seeds/lambda-statement-program.md`。

```yaml
program: lambda-statement   # 再定義: Λ/ℚ̄ 決定可能・ℝ脱出隔離・形式検証可能
current_cycle: 23           # cycle 0-22 完了。cycle 23 は 2026-08-01 に cycle 22 総括の「cycle 23 の焦点（案）」4 点から起こした。
                            # 2026-06-24 ユーザーが3トラック(docs/themes.md)へ再スコープ。cycle 3 以降はトラック明記。
                            # cycle 16 は 002 の昇格承認後の「論文 001 の残務を閉じる」サイクル。
                            # cycle 17 は cycle 16 総括が挙げた4点（照合の穴・退化トーラス・Lean・既出性）を潰すサイクル。
                            # cycle 18 は cycle 17 総括が挙げた4点（一般の退化塔／π_tr(p,k) 上界／命題 N・T・W の Lean 化／Monsky 1989 入手）を潰すサイクル。
# 3トラック: 1 Reframe(本流) / 2 Solve(未解決模型の実厳密解) / 3 Pure(基礎論・数論)。2本立て(1,2)主軸 + 3 随時。
last_run: 2026-08-01
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
| 1 | 運用 | reflect_g4_and_d_series | todo | | **先に定理 G4 §5.3 の条件 2 を訂正**し、定理 G4（$\ell^n$ の係数 $c$）と定理 D1–D6（係数の 3 層構造）を本文（日英）へ移す。**step 2 が作った転記検査の実戦投入初回。** 本文と根拠 report を触ってよい唯一の step。 |
| 2 | 運用 | ledger_coverage | todo | | 転記検査の台帳被覆を 25%（32 中 8）から上げる。**step 1 の main 反映後に起こす**（本文ブロックが増えるため）。検査道具を触ってよい唯一の step。 |
| 3 | T3 Pure | cuoco_thesis_acquisition | done | 2026-08-01 | `outputs/reports/cycle23_T3_cuoco_thesis_acquisition.md`。**既出性は決着した。しかも学位論文を読まずに済んだ。** 決め手は **Monsky *Some invariants of $\mathbb{Z}_p^d$-extensions* (1981) の p.229 と p.233 の直読**——p.229 は「Cuoco, **[2]**, introduced an invariant $m_0$」「**To tackle this we introduce an invariant $l_0(L/k)$**」と書き、**[2] は Cuoco 1980（Compositio Math.）であって学位論文ではない**。p.233 の References は**全 5 件で学位論文を 1 件も含まない**。すなわち **$l_0$ は Monsky が 1981 年に導入した不変量**であり、**(K3) も定理 W4 も $l_0$ の局所構造の主張だから 1979 年の学位論文にはありえない**。推論の残り穴 2 点も明示（帰属記述からの演繹であって読了ではない）。**Cuoco 1980 は全文 pp.415–437 を通読**し、精密に記述される不変量は $m_0$ だけで $n$ の係数 $m_1$ は定義されるだけ＝(K3)・W4 に当たるものは無いことを確認。**学位論文そのものは入手できず**、試した経路（ProQuest・Brandeis 機関リポジトリ・HathiTrust・WorldCat・著者本人）と失敗理由を一次情報で具体化し、**課金は不可逆なので進めていない**（ユーザーが取れる手段 4 つを URL・識別子つきで report §2.1 に用意）。**step の前提の誤りを 2 件検出**: 指示と cycle 22 report が言う「CM は **p.248** で詳細について学位論文を指す」は誤りで、**当該文は p.252、しかも学位論文は「originally introduced」の側にしか挙がらず、詳細の参照先は [2,5]（どちらも読める）**。**自分の誤りを 5 件記録**（最重は **OCR 出力をそのまま引用文として書いた**こと。3 ページを画像で直読して照合し直した）。**呼び出し元の検証**: **Monsky p.229 と p.233 のページ画像を自分で取得して直読し、$l_0$ の導入文と References 5 件（学位論文なし）を独立に確認**した。指示どおり本文・検査道具・MEMORY・state を触っていない。 |
| 4 | 運用 | lean_cycle22_theorems | todo | | 定理 D1–D6・命題 D1a を Lean に通して検算（8 サイクル目）。 |
| 5 | — | rank:cycle23 | todo | | cycle 23 総括。cycle 24 の焦点を挙げる。 |

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
