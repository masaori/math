# 死に作業の棚卸し（2026-07-31）

main に取り込まれていない差分を網羅的に洗い出し、価値の有無を一次情報で判定した記録。

- **調査時点の `origin/main`**: `af8d209`（Merge pull request #46 from masaori/feat/renderer-domain-model）
- **判定方法**: 全ブランチについて `git diff origin/main...<branch>` の**中身を読み**、
  main 側に同等内容が存在するかを**内容で照合**した（ブランチ名・日付・コミットハッシュの一致では判定していない）。
- **この調査で main へ push・マージは一切していない。** worktree の削除も行っていない。
- 調査中に別セッションが救済PR #50〜#60 のマージを進めていたため、main とそれらのブランチには触れていない。

---

## 1. 新しく起こした救済PR

### PR #63 — integrable-lattice の 4ソース文献収集の実装（1,187 行）

**どこに残っていたか**

`origin/worktree-synchronous-weaving-parasol`。`origin/main` より **389 コミット遅れ**、
**PR が一度も作られておらず**、`git branch -r --contains` で確認したところ**他のどのブランチにも含まれていない**。
単一コミット `191692f` に 40 ファイル・14,926 行が入っていた。

救済したのは以下の実装部分のみ（新ブランチ `salvage/integrable-lattice-harvest-impl`、コミット `c4995a4`）。

- `src/integrable_lattice/harvest.py` — arXiv Atom API（標準ライブラリのみ、レート制限 3 秒）
- `src/integrable_lattice/harvest_openalex.py` — OpenAlex Works API（要旨の inverted index 復元つき）
- `src/integrable_lattice/harvest_semantic_scholar.py` — Semantic Scholar Graph API（429 リトライ／バックオフ）
- `src/integrable_lattice/harvest_inspire.py` — INSPIRE-HEP Literature API
- `src/integrable_lattice/dedup.py` — canonical key（arxiv_id > doi > 正規化タイトル）による 4 ソース統合
- `src/integrable_lattice/filter_relevance.py` — 精度フィルタ
- `pipeline/01_harvest/{run,run_multi,merge}.py` — 上記の CLI
- `pipeline/01_harvest/README.md` — 構成の記述を更新
- `docs/schemas.md` — `ManifestRecord` スキーマを追加

**なぜ価値があると判断したか**

main に harvest の実装が**一行も存在しない**。

```
$ git ls-tree -r --name-only origin/main -- integrable-lattice/src/integrable_lattice
integrable-lattice/src/integrable_lattice/__init__.py
integrable-lattice/src/integrable_lattice/schema.py
```

一方で `integrable-lattice/pipeline/README.md` は現在も 7 段構成の 1 段目として
`01_harvest`「文献候補を集める」を掲げ、`pipeline/01_harvest/README.md` も
「まずは arXiv metadata と OpenAlex metadata を対象にする」と**実装方針だけを書いた未実装状態**で残っている。
外部 API 4 種のクライアント・重複排除・フィルタは、探索方針から独立した基盤コードである。

**意図的に救済しなかったもの（13,700 行超）**

`inputs/corpus/*.jsonl`（arXiv 349・OpenAlex 1815・Semantic Scholar 577・INSPIRE 156 → 統合 2687 →
フィルタ後 1504 件、うち 1504 件は LLM 分類済み）、`inputs/queries/seed-queries.md`、
`inputs/seeds/open_problem_collections.md`、`integrable-lattice/.gitignore` の書き換え、
`integrable-lattice/MEMORY.md` の全面置換。

理由は main のコミット `c7fe283` である。

```
$ git log -1 --format=%B c7fe283
integrable-lattice: cycle 0 成果と文献バイアス seed を全削除(Λ再定義のためクリーンスタート)

削除対象: corpus/query/map 001-004, candidates 000-003, reports 001,
seeds(canonical-papers/operations/axes/seed-queries)。
復元点(削除前・全 intact): 918af09。…… models.md(模型の基質)のみ残置。
```

3,550 行を削除している。さらに `docs/tasks/auto-loop-runbook.md` は

> 文献の「厳密可解」分類（determinant か character か）で整理してはならない

と明記している。救済しなかった corpus は `model_hints` / `operation_hints`
（determinant, character, YBE, star-triangle …）で分類されたもので、**まさにこの禁じられた整理軸そのもの**である。
したがって main へ戻すことは方針の巻き戻しになる。`MEMORY.md` も 389 コミット分古く、
現在の main の内容（論文 001 の完成・Lean 形式検証）を丸ごと消してしまうため除外した。

**これらは削除していない。** `origin/worktree-synchronous-weaving-parasol` にそのまま残っており、必要なら取り出せる。

**救済時に加えた唯一の変更**: `pipeline/01_harvest/README.md` の冒頭に注意書きを追加した。
この README が入力として挙げる `inputs/queries/seed-queries.md` 等は上記 `c7fe283` で削除済みで
現在の main に存在しないため、そのままでは走らせられないこと、走らせるなら Λ-statement の選別基準に沿った
クエリを新規に用意すべきことを明記した。コード本体は**無改変**（クエリファイルのパスは CLI 引数で差し替え可能）。

**未実施**: 実 API を叩いた動作確認。

---

### PR #62 — 従順群ノートの「注意 6.7」重複・矛盾の解消（2 行）

**どこに残っていたか**

`origin/claude/amenable-non-amenable-groups-rk3jxz`。`origin/main` より **245 コミット遅れ**、PR 未作成。
対象は `docs/research/従順群と非従順群の基礎論/06_非従順性_パラドキシカル分解_Tarski.md` の 1 箇所。

**なぜ価値があると判断したか**

main に、**番号が重複し内容が食い違う「注意 6.7」が 2 つ並んだままである**。

```
$ git show origin/main:docs/research/従順群と非従順群の基礎論/06_非従順性_パラドキシカル分解_Tarski.md \
    | grep -n "注意 6.7"
92:**注意 6.7（$e_{F_2}$ の帰属）.** … 定義 6.2 … と整合。
94:**注意 6.7（$e_{F_2}$ と有限例外の再配分）.** 上の素朴な分割では単位元 $e_{F_2}$ と
   一部の語の帰属が二重になる。…
```

92 行目は「本文の 4 素片のままで定義 6.2 と整合する」と言い、
94 行目は「素朴な分割では帰属が二重になるので細分が必要」と言う。
**同じ番号の注意が互いに矛盾した結論を述べており**、読者はどちらが正しいか判断できない。

ブランチの差分はこれを解消している。

- 92 行目 → 「注意 6.7（$e_{F_2}$ の帰属と『片が $E$ を被覆しない』こと）」に書き換え、
  **定義 6.2 は素片が $E$ を被覆することを要求していない**（要求は「互いに素で $E$ に含まれ、
  移動後の合併が $E$ を被覆する」だけ）という点を明示し、$e_{F_2}$ が両分解で移動後に回収されることを
  $a\cdot a^{-1}$ / $b\cdot b^{-1}$ の 2 経路で具体的に書いた。結論は「4 素片のままで定義 6.2 を完全に満たす」。
- 94 行目 → 番号を「注意 6.7′」に変え、**「素片が $E$ を分割する」という強い流儀を採る場合の話**として
  位置づけ直した。これで 92 行目と矛盾しなくなる。

加えて逆元の記法を $a^{-1}$ から $a^{-1_{F_2}}$ へ揃えており、
リポジトリ CLAUDE.md の「登場するすべての記号がどの集合に属するかを明示する」原則に沿う。

**未実施**: 数学的な内容レビュー。

---

### PR #61 — 「対数順序群の機械検証性」ノート群（7 ファイル・422 行）

**どこに残っていたか**

`origin/claude/log-order-group-stat-mech-sybmxm`。`origin/main` より **331 コミット遅れ**、PR 未作成。
`docs/discussion/対数順序群の機械検証性/` 以下の 7 ファイル。

- `README.md` — 結論（形式証明・厳密計算の 2 つの工学的メリット）と早見表
- `00_問いと前提.md` — 「Λ に絞る」＝「decidable / computable に絞る」という再解釈と対応表
- `01_自動証明_LeanCoq.md` — Lean / Coq / Isabelle 側の利得（Presburger / ⊕ℤ vs RCF、
  Mathlib の `Finsupp` / `Nat.factorization`、超越性の回避）
- `02_厳密計算_SageMath.md` — `QQbar` / `AA` の厳密性、素因数分解＝log、浮動小数点に落ちる境界
- `03_横断原理.md` — 計算可能解析（TTE）・逆数学による一般的裏付け
- `出典.md` — 全主張の一次資料 URL と確信度
- `MEMORY.md` — 当該議論の引き継ぎメモ

**なぜ価値があると判断したか**

1. **main に同等内容が存在しない。**
   `git ls-tree -r origin/main -- docs` に「機械検証」を含むパスは 0 件。
   `git grep "横断原理" origin/main -- docs` も 0 件。
   既存の `docs/discussion/対数順序群上の統計力学/`（00〜10 + README）は数学的立場を述べたもので、
   Lean / Coq / SageMath の機械検証コストという工学的観点は扱っていない。
2. **プロジェクトの中核方針を一次資料つきで裏づける。**
   リポジトリ CLAUDE.md と `integrable-lattice/docs/tasks/auto-loop-runbook.md` は
   「可算（ℕ/ℚ/Λ/ℚ̄）と非可算（ℝ/ℂ）を分別し、ℝ 脱出箇所を明示する」ことと「形式検証可能性」を
   選別基準に据えている。本ノート群は、ℝ 脱出点＝Lean の `noncomputable` 化点＝厳密計算の
   浮動小数点化点が一致することを出典つきで整理しており、方針そのものの根拠資料になる。

**未実施**: 数学的な内容レビュー。

---

## 2. 既存の未マージ救済PR #18〜#49 の判定

### 2-1. まだ価値があるもの（4 件）

いずれも**そのままマージしてはいけない**。必要な作業を各項に明記する。
判定根拠は各PRにコメントとして投稿済み。

#### PR #25 `worktree-nifty-drifting-engelbart` — 部分的に価値あり

main の `3548907` と同じ「判定式 (★)(☆) の証明」を独立に書いた並行成果。
骨格（§1〜§6）は main の `integrable-lattice/outputs/reports/cycle13_T3_mu_content_criterion_proof.md`
（483 行版）が同じ結論・同じ仮定緩和で既に持っている。数値検証も main の
`sagemath/check/cycle13_T3_criterion_proof/proof_steps.sage`（Step 1〜7）がカバー済み。

**main に無い部分（＝救う価値がある部分）**

| 箇所 | 内容 | main 側の状態（一次情報） |
|---|---|---|
| §10.1 | arXiv:2107.07639 の PDF 本文からの逐語引用と、Corollary 5.6 の $P=\det M$ 代入による $Q(T)=\det L(1+T)$ の同定 | main 同ファイル 447 行目が「**[E] Corollary 5.6 の岩澤冪級数 $Q(T)$ の定義そのものは確認していない**」と未確認項目として明記 |
| §10.2 | (★) の出典特定（Vallières 論文 式(7)、Hammer–Mattman–Sands–Vallières Thm 2.11 / Cor 3.5 からの独立導出） | `git grep Hammer origin/main` → **0 件**。main は (★) の出典を特定していない |
| 命題 7.1 | $\mu_\ell>0 \iff \det(L \bmod \ell)=0$ over $\mathbb{F}_\ell(z)$（1 変数 $d=1$ の有限判定） | main に該当命題なし（`cycle14_T3` の「最低次斉次部分 $H$」判定は $d=2$ の別命題） |
| 命題 7.2 | bouquet で $\mathrm{content}_z(D)=\gcd_a m_a$ の**証明** | main 側は `cycle12_T3_nonzero_mu_p` の 125 件全探索という**数値観察のみ**（`docs/tasks/auto-loop-state.md` 269 行目） |
| 命題 8.1 | $p\neq\ell$ での下界 $v_p(\kappa_n)\ge\mu_p\ell^n+(v_p(\kappa_0)-\mu_p)$、および $v_p(R_n)$ 有界性が未解決という切り分け | main は §9.4 で「$\ell\nmid N$ は射程外」と述べるだけで下界を出していない |
| §12 | 使った体を列挙し「ℓ 進脱出は Weierstrass 準備定理の 1 点に隔離」と整理 | main に同等の整理なし |
| `sagemath/check/cycle13_T3_criterion_proof/verify_star.sage` | D 節（命題 7.2 の bouquet 照合） | main の `proof_steps.sage` に該当ステップなし |
| 同 `verify_criterion.sage` | F 節（命題 7.1 の $\mathbb{F}_\ell$ 判定）、G 節（命題 8.1 の下界、$v_5(\kappa_n)$ が途中で増えて止まる実例） | 同上 |
| 同 `lib_voltage.sage` | 上 2 本の共通ライブラリ | 単独では価値なし。上を救うなら必要 |

**マージに際して必要なこと**

- **レポートを丸ごと差し替えてはならない。** main の 483 行版にしかない §6.5（一意性）・§9.4（witness）等が失われる。
  正しいのは **§7 / §8(c) / §10 / §12 を main 版へ追記する形**での統合。
- `sagemath/check/cycle13_T3_criterion_proof/` の 3 ファイルはファイル名が衝突しないので追加のみで済むが、
  **ブランチ側には `README.md` が無い**（main 側にはある）。

#### PR #22 `worktree-foamy-foraging-map` — 部分的に価値あり（今回で残余が最大）

**main に対応する検証がまったく存在しないラベルを 2 つ埋めている。**
全 check の `overview.md` の「対象ラベル」宣言を grep した結果、`def_T_g` と `def_T_V` を宣言する
ディレクトリは main にゼロ件（main の `253_injectivity_of_T_up_to_scalar` /
`254_V2_not_in_clifford_group` は同じ番号だが別の主張）。

| ブランチ側 | 判定 | 根拠 |
|---|---|---|
| `253_def_T_g/check_01_composition_law.sage` | 価値あり | Pauli 基底での $4^M\times4^M$ 行列表示と vec 公式 $\mathrm{vec}(AXB)=(A\otimes B^{\mathsf T})\mathrm{vec}(X)$ の 2 経路照合。`T_matrix_by_vec` は全 ref で本ブランチのみ。main の `117_conjugation_is_ring_homomorphism` / `200_linearity_of_T` は作用素レベルの合成則・線型性止まり |
| `254_def_T_V/check_01_T_V_eq_T_of_V.sage` | 価値あり | 「3 段の共役の合成 = 行列 $V$ による 1 回の共役」の検証。`T_conj(H, T_conj(V2, T_conj(H, X)))` パターンは全 ref で本ブランチのみ。main の `256_...` は $T_{(V)}$ と $T_{(V')}$ の一致という別主張 |
| `250_.../check_02_symmetries_and_pbc.sage` | 部分的に価値あり | (a) 全スピン反転不変性・(d) 自由境界版と一致しないこと・(e) 巡回シフト不変性が main に無い。特に (d) は「周期境界が実際に効いている」ことの否定コントロール。(b) 転置対称性は main の `check_01_definition_sanity.sage`「独立経路 2」と重複 |
| `251_.../check_01_V1_V2_structure.sage` | 部分的に価値あり | 増分は $V_2=t^{\otimes N}$（2×2 転送行列のクロネッカー積）による独立構成（main に `np.kron` での $V_2$ 構成は grep 0 件）。他は main の `check_01_transfer_matrix_sanity.sage` と重複 |
| `250_.../check_01_Z_closed_form_1d.sage` | 価値なし | main の `check_01_definition_sanity.sage` の独立経路 1・3 が同じ 1 次元退化を $\mathrm{tr}(T^M)$ で実施済み |
| `252_.../check_01_Z_eq_trace.sage` | 価値なし | main の `252_.../check_01_bruteforce_vs_trace.sage` と同内容 |
| `252_.../check_02_bijection_independence.sage` | ほぼ価値なし | main の同ファイルが乱数置換での不変性を実施済み |
| `252_.../check_03_JJprime_assignment.sage` | ほぼ価値なし | main の `check_01_bruteforce_vs_trace.sage` が J と J′ の入れ替えで一致しないことを検査済み |
| `.sage.py` 8 個 | 価値なし | Sage プリパーサ生成物 |

**マージに際して必要なこと**

- **共通ライブラリの API が非互換。** ブランチの `252_.../_prelude.sage`（blob `19e88c3`）は
  main の同パス（blob `d3c4e54`）と別物で、シグネチャが逆になっている。
  - ブランチ: `transfer_matrices(N, J, Jp, order=)` / `brute_force_Z(M, N, J, Jp)`
  - main: `transfer_matrices(J, Jp, N, order=)` / `Z_bruteforce(J, Jp, M, N)`
  - **そのまま持ってきても動かない。書き換えが前提。**
- **`overview.md` が無いため、そのままマージすると
  `node sagemath/tools/verify-check-linkage.ts` が exit 1 で落ちる**
  （同ツール 37–55 行目、`if (!existsSync(overview)) problems.push(...)`）。
  check ファイル単位で main の現行番号のディレクトリへ移し、
  `overview.md`（対象ラベル・判定数・最大相対誤差・ステータス）を実行ログから作り直す必要がある。

#### PR #24 `worktree-indexed-singing-blum` — 部分的に価値あり

30 ファイル中 **17 個が完全に同一の `_prelude.sage`**（165 行 × 17 = 2805 行 ＝ 全 3697 行の 76%）。
そのうち **10 ディレクトリは prelude のみで check ファイルが無い**
（`137_matrix_exp_series_converges`, `138_theorem_exp_product`, `139_theorem_exp_zero`,
`140_scalar_identity_commutes`, `141_def_frobenius_inner_product`, `142_frobenius_inner_product_axioms`,
`143_ad_binomial`, `144_matrix_exp_conjugation`, `145_brianhall_exc14`, `146_exp_X_Y_exp_-X`）。
成果ゼロの足場で、対応する主張は main の `136_`〜`144_` が検証済み。

実体は check ファイル 12 個。main の対応 check（`130_`〜`135_`、番号が 1 つずれている）は
主張レベルでは全て被覆済みだが、main 側はいずれも 20〜30 行の乱数スポットチェックで、
ブランチ側は「証明のステップそのもの」を検査する設計になっており、以下が main に存在しない。

| ブランチ側 | 判定 | 根拠 |
|---|---|---|
| `131_.../check_03_limit_uniqueness.sage` | 価値あり | main の `130_matrix_norm_triangle_inequality/overview.md` の「備考」が**明示的に「(4) 極限の一意性は数値では直接確認できないため、この check には含めていない」と書いている**。ブランチは三角不等式による評価 $\|A-A'\|\le\|A_N-A\|+\|A_N-A'\|$ の骨格として検査しており、main が意図的に落とした穴を埋めている |
| `130_def_matrix_norm/check_01`, `check_02` | 部分的に価値あり | `def_matrix_norm` を対象ラベルに宣言する check は main に無い（main の `130_` は `matrix_norm_triangle_inequality` を宣言）。ノルム値を naive 二重ループ / numpy / $\sqrt{\mathrm{tr}(A^*A)}$ / 特異値の 4 経路で突き合わせ（`fro_svd` は全 ref で本ブランチのみ）、「ノルム収束 ⟺ 成分収束」の同値評価 $d_N\le\|\cdot\|\le n\,d_N$ も検査 |
| `133_.../check_01_vector_bound.sage` | 部分的に価値あり | 増分は**本文の証明が使う行列 $W$（第 1 列が $w$、他が 0）の構成を再現し $\|AW\|=\|Aw\|$・$\|W\|=\|w\|$ を検査**する点。証明ステップの書き写しミス検出になる |
| `134_.../check_01_cauchy_completeness.sage` | 部分的に価値あり | main の `133_matrix_completeness/check_01_absolute_convergence.sage` は絶対収束側のみ。ブランチは完備性側（Cauchy 性の sup が $N_0$ について単調減少、Step 1 の $\max\lvert a_{ij}\rvert\le\|A\|$ 評価）を追加 |
| `136_.../check_01_monotone_bounded.sage` | 微小に有効 | 増分は**証明 Step 2 の具体的な有界性評価 $m_0\ge 2a \Rightarrow \sum_{m\ge m_0}a^m/m!\le 2a^{m_0}/m_0!$** の直接検査 |
| `131_.../check_01`,`check_02`, `132_.../check_01`,`check_02`, `134_.../check_02`, `135_.../check_01` | ほぼ価値なし | それぞれ main の `130_`/`131_`/`133_`/`134_` が同じ主張を検証済み。増分は退化行列（零・冪零・ランク 1・非対角化不能）と Ising 実作用素をテスト集合に混ぜた点、および比の最大値記録 |
| `.sage.py` 2 個 | 価値なし | 生成物。しかも 17 ディレクトリ中 2 つ分しか無く不整合 |

**マージに際して必要なこと**

- **`overview.md` が無いため `verify-check-linkage.ts` が exit 1 で落ちる。**
- **番号が main の現行採番と 1 つずれている**ため、そのまま足すと同一ラベルに対して重複ディレクトリができる。
  check ファイル単位で main の現行番号のディレクトリへ移し、`overview.md` を実行ログから作り直すこと。

#### PR #23 `worktree-fuzzy-petting-bengio` — ほぼ価値なし（残余は 2 つの事実のみ）

`integrable-lattice/outputs/reports/cycle13_T1_observation_T_settlement.md` は
**main に同名ファイルが既に存在**（main blob `2174455` / ブランチ blob `25ad6c5`）。同じ成果物の別ドラフト。
main はさらに `cycle14_T1_proposition_T_generalization.md` で定理 A–F へ一般化し、
**定理 D として同じ主張を Hensel・Newton 多角形・LTE を使わない 10 行の証明に短縮**している。
ブランチの証明経路（$m_L$ / 終結式 / $\mathbb{F}_2[x]$ の分離性、Lemma 1–6 + Proposition 4）は
3 つ目の別経路にすぎず、main の定理 D より短くも初等的でもない。
ブランチの $\tau(L)=L^2R_L^4$ は main の**定理 C に一般化された形で含まれている**。
§2 は main の `cycle14_T3_Zl2_tower_criterion.md` §9.2 / §9.3 が同じ結論をより深く扱っており上書き済み。

**残余として有効な 2 点**

| 内容 | 根拠 |
|---|---|
| 偶数 $L$ の「観察 T′」の一般形 | ブランチは任意の偶数 $L$ に対し $v_2(\tau(L))=(2s+4)L-(6s+1)$（$s=v_2(L)$）を主張し $L=2..128$ の **64 例**で確認。main は `cycle14_T3_Zl2_tower_criterion.md` §9.2 の式 (9.1) として **$L=2^n$ の 7 点のみ**。両者は代数的に同一の式だが、ブランチは「$s$ が同じなら $L$ の奇部分に依らない」という**より広い族への拡張**を主張しており、この形は main に無い（`2s+4` / `6s+1` を main の integrable-lattice 配下で grep → 0 件） |
| 文献確認の一次情報 | ブランチ §5 は OEIS A212800 を全文取得して「2 進付値も $\tau=L^2R^4$ 型分解も記載無し」を確認し、arXiv:1711.00175 を ar5iv 本文で「1 次元 circulant のみ、$p$ 進付値は扱わない」と確認。main の cycle13 レポート §5 は同じ 2 本を**「本文未確認」のまま**残している（`A212800` / `ar5iv` は main で grep 0 件） |

**マージに際して必要なこと**

- **レポートを丸ごとマージすると main の既存版（定理 D への短縮を含む）を壊す。**
  上記 2 点を main の既存レポートへ**追記する形**が正しい。ファイルとしては救わない方が筋が通る。

---

### 2-2. 価値なしと判定したもの（10 件）

判定根拠は各PRにコメントとして投稿済み。

| PR | ブランチ | 根拠（一次情報） |
|---|---|---|
| **#18** | `claude/goofy-davinci-3fcf6f` | `docs/discussion/指数体上の統計力学/README.md` の新規追加 1 ファイル（27 行）。main の `docs/discussion/対数順序群上の統計力学/README.md` 冒頭が「**旧称「指数体 $E$ 上の統計力学」。……改称**」と明記しており、ファイル一覧は本PRの 00〜03 の 4 本に対し main は **00〜10 の 11 本 + 早見表 + 集合帰属表**。本PRの「未解決」4 項目のうち 2 項目は main で取り消し線つきの決着済みとして記録されている。新規情報ゼロ。追加すると改称で解消したはずの旧称ディレクトリが復活し二重管理になる |
| **#26** | `worktree-polished-sleeping-badger` | main の `6e32fe5`（検証カバレッジを 7 ラベル → 96 ラベルへ拡張）が同じ 6 ラベルを `overview.md`・実行ログ・`run-all-checks.sh` 統合つきで既にカバー。全ログ PASS で新規検出ゼロ。さらに 102〜105 が **main の別の意味の番号と衝突**（main の 102 = 角度切断、103 = 絶対値）。`105_abs_basic_properties` は `.sage` 1 本のみで未完 |
| **#27** | `worktree-reflective-fluttering-panda` | 同じく `6e32fe5` に敗れた並列試行。main 版は同じ範囲で `commutator_of_H_and_Z_Y` の 6 式中 2 式が本文と一致しないことを検出し差分（$-4e^{-i\theta}Y_M$、係数 $-2$ ではなく $+4$）まで特定しているが、本PRの `196_...` は `.py`・ログが無く**未実行**でこの検出を再現していない。唯一の未カバーは `191_definition_def_hatZ_hatY/` の 2 本だが価値は小さい |
| **#28** | `worktree-spicy-kindling-lamport` | `structured-latex/content/*.mjs`（**旧 JavaScript 形式**）への追記 4 ファイル。CLAUDE.md が「ソース形式は TypeScript に統一する（`.mjs` は使わない）」と明記。内容も 4 件すべて main の `.ts` 側に存在（うち `000_calculation_formulae_10_19.mjs` の証明本文は main の `angle_section_existence_uniqueness` と**一字一句同一**でラベル名だけが違う）。リー群ブロックは main が README のゴール設定に従い**意図的に本文から外して `notes/` へ退避**した内容で、戻すと方針の巻き戻しになる |
| **#29** | `worktree-sunny-tickling-island` | 6 ディレクトリすべてが main に**同名ディレクトリ・同一の対象ラベル**で存在（`6e32fe5`）。加えて **`.log` が 1 つも無く未実行**。`160` のヘッダが CLAUDE.md の禁じる旧 `.mjs` 形式を参照 |
| **#38** | `worktree-quizzical-mixing-bunny` | `integrable-lattice/lean/` のブートストラップのみ。`lean-toolchain` は main と完全同一、`IntegrableLattice.lean` は `import Mathlib` の 1 行（main は 5 モジュールを import する本体）、`lake-manifest.json` は `"name": "Ising2D"` という別プロジェクトからのコピー由来の誤りを含む |
| **#39** | `worktree-scalable-foraging-muffin` | 2 コミット中 `4b19120` はマージコミットで両親（`35c3961` / `f8b42f4`）とも **main の祖先**（`git merge-base --is-ancestor` で確認）＝新規内容ゼロ。残る WIP コミットの `016_even_sector_fermions.ts`（1761 行）は main の同名ファイル（1934 行）の**下位互換**でブランチ固有ラベルは 1 つも無い。check 群も main の 6 本＋`overview.md`＋`run-log.txt` に再構成済み |
| **#47** | `worktree-ancient-wiggling-cocoa` | `019_max_eigenvalue_sector.ts`（789 行）は main（798 行）の下位版でブランチ固有ラベル 2 つとも main に吸収済み。`054_.../_prelude.sage`（319 行）は **main の `053_claim_even_sector_closing/_prelude.sage` とバイト同一**（別章のプレリュードを丸ごとコピーした未編集状態）。`sanity_tmp.sage` は一時スクリプト。`*.generated.ts` は自動生成物 |
| **#48** | `worktree-cosmic-discovering-alpaca` | #38 と同種の Lean ブートストラップ。**唯一の Lean コードは `Basic.lean` の全文が `theorem placeholder : True := trivial`**。`lake-manifest.json` と `lean-toolchain` は main と完全同一、`logs/00_cache_get.log` は空ファイル |
| **#49** | `worktree-woolly-dreaming-marshmallow` | `lean/Ising2D/Abstract/PsdBilinear.lean`（260 行）。同じ 3 主張が main の `Abstract/PsdCauchySchwarz.lean` / `Abstract/RayleighMoments.lean` に、**同じ場合分け（$a=0$ で $t=-(c+1)/(2b)$、$a>0$ で $t=-b/a$）で証明の運びまで同一**の形で存在。main 版は `IsPsdPair`/`IsPdPair` で仮定を整理し `moment_pos`/`moment_le_pow`/`moment_ratio_le`/`moment_pow_le` まで拡張済み |

### 2-3. 全体に共通する構造的事実

- #21〜#29・#38・#39・#47〜#49 は、いずれも tip コミットが
  「WIP: salvage agent worktree before cleanup」＝**作業完了物ではなく中断時スナップショット**。
  今回の照合は、その中断内容が main 側で別エージェントにより再実装され切っていることを示している。
- **#21 / #22 / #24 / #26 / #27 / #29 は新規 check ディレクトリに `overview.md` が 1 つも無く、
  現状のままでは `node sagemath/tools/verify-check-linkage.ts` が exit 1 で落ちる。**
- 各ブランチ固有の内容は、全 `origin/*` ref に対する blob 照合の結果、
  **そのブランチ以外のどの ref にも存在しない**。二重救済の危険はない。

---

## 3. 調査した対象の網羅範囲

`origin/main = af8d209` 時点の集計。

| 対象 | 件数 | 見つかったもの / 見つからなかったもの |
|---|---|---|
| **リモートブランチ** | 72（`origin/HEAD` を除く）。うち `origin/main` と `origin/gh-pages` を除いた実質 **70** | **31 本が main より先に進んでいた。**残る 39 本は main に完全包含（`git rev-list --count origin/main..<branch>` = 0）＝差分ゼロ。31 本の内訳: 既存の救済PR #18〜#49 が 15 本、別セッション担当の #50〜#60 が 11 本、**オープンな PR が存在しなかったものが 5 本**。5 本のうち 4 本は **PR が一度も作られていなかった**（`claude/amenable-...`, `claude/log-order-...`, `claude/zen-allen-...`, `worktree-synchronous-weaving-parasol`）、残り 1 本は PR #2 としてクローズ済み（`copilot/fix-arg-interval`） |
| **ローカルブランチ** | **142** | main より先に進んでいたのは 22 本。うち 21 本はリモートに同名ブランチがあり内容も同一。**リモートに存在しない固有の作業は 1 本のみ**（`copilot-worktree-2026-02-17T02-42-05`）。ローカルのみのブランチ自体は 99 本あるが、そのすべてが main に完全包含 |
| **worktree** | **4**（調査開始時） | 4 個すべて `git status --porcelain` が**0 件**＝未コミット変更・未追跡ファイルともゼロ。`--ignored` で確認した無視ファイルも `node_modules` / `.lake` / `__pycache__` / ビルド生成物 / `.claude/settings.local.json` / `type-tests/.tmp/` のみで、作業成果物なし |
| **stash** | **0** | `git stash list` は空。救済対象なし |
| **未追跡ファイル** | **0** | 上記のとおり全 worktree でゼロ |
| **PR** | 全 **63** 件（オープン 22・クローズ 1・マージ済み 40） | クローズ済みは PR #2（`copilot/fix-arg-interval`）の 1 件のみで、**差分ゼロ**（`git diff --stat origin/main...origin/copilot/fix-arg-interval` が空。コミットは "Initial plan" のみ）。マージ済み 40 件は定義上 main に入っている |

### 個別に確認して「価値なし」と結論したもの（PR に紐づかないもの）

| 対象 | 根拠 |
|---|---|
| `origin/claude/zen-allen-gojq1o`（9 ファイル・469 行） | 主要な内容は `038_claim_T_V_eq_T_Vprime.typ` の証明完成（434 行）だが、**main に既に取り込まれている**。main の `structured-latex/content/008_TV1_hatZ_hatY_part2.ts:3934` の conversion note が「**移行漏れだった証明を `_old/typst` の原本（`038_claim_T_V_eq_T_Vprime.typ`）から復旧。Step 1〜4 を圧縮せず全ステップ再現した。**」と明記。main の `_old/typst/parts/.../038_claim_T_V_eq_T_Vprime.typ` も 295 行で `#proof[TODO]` は 0 件。MEMORY.md に残る「縮退モード $\gamma_2(\theta_\mu)=0$ の扱い」という宿題も、main が専用の Claim（ラベル `T_Vprime_fixes_hatZ_hatY_when_gamma2_zero`、`_old/typst/.../041_claim_..._gamma2が0の場合.typ` 由来）として解決済み |
| `origin/copilot/fix-arg-interval`（PR #2、クローズ済み） | `git diff --stat origin/main...origin/copilot/fix-arg-interval` が**空**。コミットは "Initial plan" のみで実体なし |
| `copilot-worktree-2026-02-17T02-42-05`（ローカルのみ） | 偏角の記法を $(-\pi,\pi]$ から $[0,2\pi)$ へ移行する 3 ファイルの編集。main で**完全に完了済み**: `git grep -c -- '(-pi, pi]' origin/main -- .../_old/typst` は **0 件**、同 041 ファイルは `[0, 2pi)` が 9 箇所。structured-latex 側も `\arg^{[0,2\pi)}` で統一済み。移行は PR #1〜#11 でマージ済み |
| `/Users/masaori/git/masaori/exact-solution-of-2d-ising-model.worktrees/copilot-worktree-2026-02-17T02-42-05`（親リポジトリが消滅した停止中 worktree） | ディレクトリ内の全ファイル（`Ising(自著).typst`, `Refs_Ising(自著).bib`, `0419-行列計算検討.typ`, `Zhatの交換関係を検討20240811.md`, `calc_notes/` 54 件 ほか）を main と照合し、**全件が main に存在**することを確認（`git -c core.quotePath=false ls-tree`）。固有の作業なし |
| `origin/gh-pages` | main と**共通祖先を持たない孤立ブランチ**（`git merge-base` が失敗）。コミットは `deploy: <main の SHA>` の列で、中身は `.nojekyll` / `index.html` / `main.pdf` のみ。CI のデプロイ出力＝生成物 |

### 調査手法の注意点（引き継ぎ用）

`git ls-tree` / `git grep` の出力はパス名を**8 進エスケープでクォート**するため、
日本語パスや括弧を含むパス（`Ising(自著).typst` など）に対して素の `grep -F` を掛けると
**存在するのに 0 件**になる。この調査でも一度誤検出した。
`git -c core.quotePath=false ...` を付けて照合すること。

---

## 4. この調査で行った操作

- **main への push・マージは一切していない。** #50〜#60 とそのブランチにも触れていない。
- **worktree の削除は行っていない。**
- 新規作成: ブランチ `salvage/integrable-lattice-harvest-impl`（コミット `c4995a4`）と PR #61 / #62 / #63。
  #61 / #62 は既存のリモートブランチをそのまま head にしている（新規コミットなし）。
- PR #21 / #22 / #23 / #24 / #25 に「マージに際して必要なこと」を含む判定コメントを投稿。
  PR #18 / #26 / #27 / #28 / #29 / #38 / #39 / #47 / #48 / #49 に「価値なし」の判定コメントを投稿。
- 数学的な内容レビューと、救済したコードの動作確認（実 API 呼び出し）は**未実施**。
