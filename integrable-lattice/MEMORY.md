# MEMORY

## cycle 9 完了（2026-07-01, 3トラック並走）

- **T1**: 2変数曲線=離散ラプラシアン(全域木)。ℝ側 (1/L²)logτ(L)→4G/π(既知 Catalan)一致=枠組み裏付け, Λ側=τ(L)素因数分解。`cycle9_T1_spanning_tree/`。
- **T2**: N=4 で cubic 因子(判別式621=S₃)=cubic 運動量存在 confirmed。厳密 cosθ 同定は超可積分スペクトル理論照合が要(cycle10+)。`dispersion_N4*`。
- **T3**: D-U2 Λ 側の統合命題確定 `outputs/candidates/D-U2_consolidated_proposition.md`(周期性+π(p,1)精密+上界+Newton+Wall 否定, 決定可能, Lean 仕様)。
- cycle10 step列: T1 τ(L) の v_p 則 / T2 超可積分スペクトル公式照合 / T3 Mahler-Lehmer 接続。

## cycle 8 完了（2026-06-30, 3トラック並走）

- **T1**: z−c の完結双対命題(R: f=log c=m(z−c); Λ: v_p(c^L−1)=LTE 完全形 p 奇/p=2, 決定可能・Lean decide 可)。`outputs/reports/cycle8_T1_lte_proposition.md`。
- **T2**: N=3 でも Onsager 分散 confirmed, cosθ=±1/3, deg-4 に追加運動量。`cycle7_T2_dispersion/dispersion_N3*`。
- **T3**: π(p,1)=lcm{ord(λ): p∤m_λ}(精密, rigorous, 全31例)＋等号条件＋strict 構成例。`pi_p1_refined*`。
- cycle9 step列: T1 2変数 P(z,w) 双対 / T2 N=4 cubic 運動量 / T3 Λ側周期を統合命題化(Lean 仕様)。

## cycle 7 完了（2026-06-29, 3トラック並走）

- **T1**: 双対の Λ 側の本体=全 L の LTE 構造(z−c で v_p(c^L−1)=LTE, 岩澤 μ_p generic 0)。`cycle7_T1_lte/`。
- **T2（白眉）**: カイラル Potts N=2 から Onsager 分散 ε∝√(1+λ²−2λcosθ), cosθ=±1/3 を有限 N ℚ̄ から抽出。`cycle7_T2_dispersion/`。
- **T3**: π(p,1)=lcm{固有値順序}(全25例 等号)→ D-U2 命題 A の周期に閉形上界 π(p,k)|p^{k-1}lcm{ord}。`pi_p1_closed_form*`。
- cycle8 step列: T1 LTE 命題化/Lean / T2 N=3,4 運動量 cosθ_k 抽出 / T3 π(p,1) 等号条件。

## cycle 6 完了（2026-06-28, 3トラック並走）

- **T1（大成果）**: ℝ/Λ 双対の Λ 側＝既知理論(Deninger p 進エントロピー＝Besser–Deninger p 進 Mahler 測度＝岩澤 μ_p)に接地。`cycle6_T1_padic_mahler_grounding.md`, 研究ノート更新。
- **T2（再訂正）**: Dolan–Grady で超可積分=Onsager 確定。cycle5 の「Onsager でない」撤回は過剰訂正で誤り(次数3,6 は cubic 運動量由来)。`cycle6_T2_superintegrable/`。
- **T3（仮説棄却）**: 六頂点 Wall 572件で破れ4.5%→「可積分が Wall 保護」棄却(0/43,0/91 は小標本偶然)。rigorous 上界のみ残る。`wall_large_scale*`。
- 教訓: 構造判定は Dolan–Grady で(次数でなく); 0件は有意性検定してから結論。
- cycle7 step列: T1 非自明 μ_p 例 / T2 Onsager 分散抽出 / T3 π(p,1) 閉形(Wall は棄却済)。

## cycle 5 完了（2026-06-27, 3トラック並走）

- **T1（大成果）**: ℝ/Λ 双対を最小・厳密に実証。`sagemath/check/cycle5_T1_mahler/`。同一 P の周期点数 a_L∈ℤ で (1/L²)log a_L→log m(P)(ℝ)と a_L 素因数分解=Φ_L∈Λ(Λ)。
- **T2（自己訂正）**: cycle4 の「カイラル Potts=Onsager 多重2次体」撤回（N=4,5 で非2冪因子, 一般 λ は超可積分点でない）。robust は有限 N∈ℚ̄ のみ。`sqrt_set_*`。
- **T3（統計的に正直）**: Wall は非退化でも一般不成立（Pell p=13 確定）。六頂点 0/43 は有意でない→可積分の効果未確定。`wall_nondegenerate_*`。
- cycle6 step列: T1 p 進 Mahler 同定 / T2 真の超可積分点で再検証 / T3 Wall 大規模統計。

## cycle 4 完了（2026-06-26, 3トラック並走）

- **T1**: ℝ/Λ 双対を Mahler 測度で命題化 `outputs/reports/cycle4_T1_R_Lambda_mahler.md`。ℝ側=自由エネルギー=log m(P)(既知, Ising で楕円曲線/L 函数)。Λ側=同 P の p 進 Mahler(予想)。研究ノート `docs/research/R-Lambda-duality/` 更新。
- **T2**: カイラル Potts スペクトルの Onsager/多重2次体構造を有限 N 観察(全2冪次数・全実・少数√, λ=1/2 で ℚ(√33,√57) 安定)。`sagemath/check/cycle3_T2_chiral_potts/onsager_*`。
- **T3**: Wall 等式は一般には不成立(退化+Pell p=13 で破れ)。rigorous 上界は不変。可積分での成立は退化交絡で未確定。`sagemath/check/cycle3_T3_period/wall_search*`。
- cycle 5 step 列(state): T1 スペクトル曲線 m(P) 両素点実証 / T2 √集合 N 依存則 / T3 非退化 Wall 比較。

## cycle 3 完了（2026-06-25, 3トラック並走）

- **T1**: D-U2 厳密命題化 `outputs/reports/cycle3_T1_D-U2_rigorous.md`。命題 A（min(v_p(Z_N),k) は T^N mod p^k の周期 π で最終周期, 決定可能・Lean decide 可）＋命題 B（線形傾き=Newton 多角形）。`sagemath/check/cycle3_T1_period_bound/` 全例検証。
- **T2**: 本命カイラル Potts（超可積分 ℤ_3）で有限 N スペクトル∈ℚ̄・全実・代数的（witness x²−6）。`sagemath/check/cycle3_T2_chiral_potts/`。
- **T3**: 周期を Pisano/Wall 理論に接続。`outputs/candidates/T3_wall_type_period_candidate.md`。上界 π(p,k)|p^{k-1}π(p,1)（rigorous）、Wall 等式（一般未証明）が全テスト例成立 → 候補命題。
- cycle 4 step 列（state）: T1 ℝ/Λ 双対命題化 / T2 有限 N→極限(Onsager) / T3 Wall 証明 or 反例。次発火で連続消化。

## テーマ3トラック化（2026-06-24, ユーザー合意。正典 `docs/themes.md`）

- **T1 Reframe（本流）**: 理論物理の既知結果を可算（Λ/ℚ̄）で厳密化・自動証明可能化。D-U2 等。「既知の再框」は first-class 成果。
- **T2 Solve**: 未解決模型の実際の厳密解（カタログ `outputs/maps/integrable_unsolved_catalog.md`）。
- **T3 Pure（追加）**: 道具(Λ,ℚ̄,p進,決定可能性,逆数学,形式検証)が効く基礎論・数論の未解決問題。
- 2本立て(T1,T2)主軸＋T3 随時。共通土台＝梯子＋四軸＋選別 (i)-(iv)（`lambda-statement-program.md`）。cycle 3 step 列は state 参照。
- **ℝ/Λ 双対**（D-U2 で発見: 同じ固有値集合の絶対値↔ℝ側自由エネルギー / p 進付値↔Λ側 Φ 数論）はユーザー依頼で root `docs/research/R-Lambda-duality/` に切り出し（別セッションで深掘り）。

## 収集対象の再定義（2026-06-21, ユーザー合意）

- 集める statement = **「Λ/ℚ̄ で決定可能・ℝ脱出隔離・形式検証可能」**。整理軸は決定可能性の梯子（ℕ⊂ℚ⊂Λ⊂ℚ̄ ⊂ ℝ）＋四軸（帰属／計算可能性／複雑性／可解性）。定義 `inputs/seeds/lambda-statement-program.md`、土台 `docs/discussion/対数順序群上の統計力学/`。
- 旧アプローチ（文献の exact 分類＝determinant/character で集めた cycle 0）は**全削除**。文献分類に引きずられて帰属と可解性を混同していたため。**復元点 918af09**（全 intact）／削除コミット c7fe283。
- 探索方向 A–F（A 零点∈ℚ̄ / B 臨界点代数性・双対 / C ℝ脱出隔離・自由フェルミオン / D Massieu Φ∈Λ / E 複雑性×可解性分類 / F 形式検証可能性）は **絞らず広く** 探す（ユーザー指示）。

## 自動ループ（daily）

- 手順 `docs/tasks/auto-loop-runbook.md`、状態 `docs/tasks/auto-loop-state.md`。各 step 完了ごとに点検 → main 差分 push（マージ結果を必ず報告）→ 次 step。**1発火で todo を尽きるまで連続消化**（リポジトリ CLAUDE.md「自律実行：判断を要さない限り止まらない」）。
- cron は session-only（Claude 起動中のみ・7日失効）。

## cycle 2 進捗（2026-06-24, D-U2 数論）

- 定理候補 `outputs/candidates/D-U2_vp_law_theorem_candidate.md`: 整数転送行列の Massieu Φ_N の v_p(Z_N)=μ_min(p)N+最終周期(SML 例外), μ_min=p 進 Newton 多角形。SageMath で六頂点・Potts 検証（`sagemath/check/D-U2_padic_law/`, `potts_phi/`）。ℝ/Λ 双対 λ_max↔μ_min 発見。
- **正直な総括**: 既知 p 進線形漸化理論の可積分 Φ への適用＝構造的/基礎論寄り、新厳密解でない。cycle 0-2 通して Λ 収集は「既知数学の可算再框」に流れ、新しい数学的結果は未産出。
- **cycle 3 方向はユーザー判断待ち**（state「cycle 2 総括」）: 1.基礎論ノート化 / 2.カイラル Potts 直撃 / 3.実際の厳密解に挑む別設計 / 4.撤退。私見=3 かテーマ再設定。

## cycle 1 進捗（2026-06-23, finite_N_decidable 深掘り）

- 母集団を「可積分だが極限未解決」へ refocus（カタログ `outputs/maps/integrable_unsolved_catalog.md`, McCoy/Baxter 原典）。
- SageMath 10.6 で実証（`sagemath/check/`）: XXZ・六頂点・スピン1 BT で有限 N 量が Λ/ℚ̄ 決定可能・witness、ℝ脱出は極限のみ。六頂点 Φ に非自明な数論構造（v₂(Z_N)=N+2 等, D-U2）。
- paper-plan `outputs/paper-plans/001_finite_N_decidable_unsolved.md`。Lean は環境未導入でブロック（仕様確定済）。
- **cycle 1 総括＝state「cycle 1 総括」**。成果は基礎論・形式検証寄与（可積分の新定理ではない）。cycle 2 方向は**ユーザー判断待ち**（基礎論寄与に価値を置くか／カイラル Potts 直撃／D-U2 数論定理化／撤退）。

## cycle 0 完了（2026-06-22, Λ-statement 版・A-F 広い探索）

- A-F 全方向を広く浅く1周。maps/candidates `outputs/{maps,candidates}/{A,B,C,D,E,F}_*`、観察 `outputs/reports/cycle0_lambda_observation.md`。
- **横断観察**: A-F が「有限・離散・可積分 ⇒ 全量が Λ/ℚ̄ で決定可能・形式検証可能、相転移=ℝ脱出 N→∞ 一点」に収束。
- **cycle 1 方向確定**: 束 `finite_N_decidable`（零点 A・臨界点 B・スペクトル C・Massieu Φ D を Λ/ℚ̄ 決定可能・witness 付きで確立、F で形式検証）。深掘りサイクルなので sagemath QQbar・Lean を投下。step 列は state の「cycle 1 step 列」（次回 verify:A-U1_resolved_check から）。

## 未解決

### Harvest policy

- 論文コーパス取得を arXiv source 優先にするか、metadata/abstract 優先にするか。

### Classification / verification policy

- 初期分類を rule-based にするか、LLM-assisted にするか。
- 「未解決」の判定をどこまで自動化するか。

### Tooling

- `integrable-lattice/skills/` を Codex の自動発見対象にするか、プロジェクトローカル運用に留めるか。

## 完了

### Project setup

- プロジェクト雛形を作成した。
- `outputs/papers/` を最終論文の置き場として追加した。
- `integrable-lattice-` prefix のプロジェクト専用 skill を7つ作成した。

### Seeds / schema

- `inputs/seeds/` に seed taxonomy と初期クエリを追加した。
- `docs/schemas.md` に候補ステートメントの最小スキーマを追加した。
- `inputs/seeds/canonical-papers.md` を追加し、MVPの代表文献アンカーを seed 化した。
- `inputs/seeds/canonical-papers.md` に mvp_role / operation_type / gap_axes と追加アンカーを入れて補強した。
- 補強後の subagent review で「harvestへ進む」と判定され、minor 指摘の first-pass axis を反映した。

### Harvest

- `six_vertex_dwbc_determinant` の first-pass query log と curated corpus を追加した。

### Gap map

- 案A（curated corpus 内の Immediate Map Hints を分類成果物として扱い、02_extract/03_classify の独立成果物を作らず直接 gap map）で `outputs/maps/001_six_vertex_dwbc_determinant_seed_map.md` を作成した。
- known 7 / probably_known 1 / needs_review 4 / unknown 6（U1–U6）でセル化。

### Candidate generation（05_generate, first pass）

- gap map の unknown 最有力セル U1 / U3 を `outputs/candidates/000_seed_candidates.md` に StatementCandidate 形式で起こした。
- U1-corr（partial DWBC 境界1点相関 det）/ U1-efp（partial DWBC EFP det）/ U3-corr（half-turn 一般パラメータ境界相関 det）の3件。いずれも known anchor 付き・小サイズ検証可能。
