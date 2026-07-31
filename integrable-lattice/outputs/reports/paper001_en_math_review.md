# 論文 001 英語版の数学レビュー（日本語正本との主張の一致）

- 対象: `integrable-lattice/structured-latex-en/`（英語投稿稿）
- 正本: `integrable-lattice/structured-latex/`（日本語）
- 実施日: 2026-08-01
- 作業ブランチ: `worktree-bubbly-painting-cat`（統合先 `origin/goal-expositiones-rewrite`）
- 方法: 日本語版 36 ブロック・英語版 43 ブロックを 1 件ずつ全文で突き合わせた。
  加えて英語版限定 7 ブロックとフロントマター（要旨）を、日本語版本文・Lean 開発・
  `outputs/reports/` の一次情報に対して検証した。

---

## 0. 結論（先に述べる）

**投稿稿として数学的に致命的な問題: 1 件。**

日本語版由来の 36 ブロックについては、**主張が強まった箇所・caveat が消えた箇所は 1 件も無い。**
第 2 節のチェックリスト 13 項目はすべて「保存されている」であり、量化子・仮定・成立範囲・
数値（22.6% / 2.1% / 4.5% / 3.4% / 43 例 / 572 例）・記号の言い分け（$\pi$ と $\pi_{\mathrm{tr}}$）も
すべて日本語版と一致していた。既出性の言い回しも、用語集 §1.4 が固定した
「we could not find … in the literature we searched」「we do not claim that it does not exist」を保っており、
"to the best of our knowledge" / "this is new" / "well-known" への化けは 1 件も無い。

**問題はすべて英語版限定ブロック（`content/001a_reader_guide.ts`、`content/008_prior_art.ts`）と
要旨（`frontmatter.ts`）に集中している。** これらは日本語版に対応物が無く、日英対応検証の
検査対象外である（対応検証は「英語版限定 7 件」として素通しする）。すなわち
**機械検証が緑であることは、これらのブロックが検証されたことを意味しない。**

致命的 1 件は §1 の【致命 1】（英語版限定の読者ガイドが、本論文自身が否定している
「Λ 側はすべて決定可能」を無条件の全称主張として書いている）。
それ以外に、投稿前に直すべき問題が 6 件（うち新規の未検証数学主張 1 件、事実誤り 2 件）ある。

---

## 1. 発見した問題（重い順）

### 【致命 1】読者ガイドが「Λ 側の全命題は決定可能」と全称で書いており、本論文自身の (F2) 決定不能性・命題 W の $\nu\in\mathbb{Q}$ と矛盾する

- **ブロック id**: `paper_014_remark_survey_scope`（`structured-latex-en/content/001a_reader_guide.ts`）
- **日本語の原文**: **対応物なし（英語版限定ブロック）。** 日本語版で最も近いのは
  `paper_011_remark_positioning` の寄与 (c):
  > **(c) 決定可能命題群の確定**: $\Lambda$ 側の有限・初等・決定可能な顔を、具体的な決定手続きと
  > witness をもつ命題として確定する（第 4 章の命題 A・B・C・N・L と、第 6 章の命題 T・V・W）。

  日本語版はここで**対象を 8 命題に限定して列挙している。**
- **英訳（英語版限定の新文）**:
  > … while on the $\Lambda$ side **every quantity we discuss is an integer or an element of $\Lambda$**,
  > and **each proposition is accompanied by a procedure that decides it in finitely many steps
  > together with a witness**. Chapter 7 states the asymmetry that results.
- **何が変わったか**: 限定列挙（A・B・C・N・L・T・V・W）が、**Λ 側の全命題・全量への全称主張**に
  拡張された。
- **なぜ問題か**: 本論文自身がこの全称主張の反例を 3 つ持っている。
  1. **命題 F の (F2)**（`paper_052_theorem_l0_computable`）は、$d\ge2$ で述語 $l_0(f)\ge1$ が
     **決定不能**（停止問題に還元される）と述べる。「each proposition is accompanied by a
     procedure that decides it」はこれと正面から矛盾する。
  2. **命題 W**（`paper_063_theorem_W`）は $\nu\in\mathbb{Q}$ **であって一般に $\mathbb{Z}$ ではない**と
     明示し、ブロックの `habitat` も `Q` である。命題 G・G′ の `habitat` は `Qbar` である。
     「every quantity we discuss is an integer or an element of $\Lambda$」は、
     **本論文自身の habitat 宣言と食い違う。**
  3. **命題 D** の低位項 $\lambda_i,\mu_i,\nu$（$i\ge1$）には明示公式が無い
     （`paper_054_remark_limits` (i)）。
  投稿稿の序論に置かれた全称主張が、第 5 章で自分の論文に否定されるのは、Expositiones が
  採否基準に挙げる「細部の正確さ」に直接抵触する。かつこれは**査読者が最初に読む位置**にある。
- **どう直すべきか（そのまま適用できる文案）**: 当該文を次に置き換える。

  ```
  " The axis is not decoration. It separates them cleanly: on the archimedean ",
  "side the central quantity is a real number and the central open problem is a continuous gap, ",
  "while on the ",
  math(String.raw`\Lambda`),
  " side the quantities are discrete — integers, elements of ",
  math(String.raw`\Lambda`),
  ", or algebraic numbers — and a family of the statements about them comes with an explicit ",
  "decision procedure and a witness (Propositions A, B, C, N, L of Chapter 4 and Propositions T, V, W ",
  "of Chapter 6). The countable side is not uniformly decidable, and Chapter 5 marks the two places ",
  "where it is not: the predicate of Proposition F (F2) is undecidable for ",
  math(String.raw`d\ge2`),
  ", and the lower-order coefficients of Proposition D admit no explicit formula. Chapter 7 states ",
  "the asymmetry that results.",
  ```

---

### 【重要 2】読者ガイドが、日本語版に無い数学的事実（$\mathbb{Z}_p$ 拡大の類数）を、仮定を付けずに新規に主張している

- **ブロック id**: `paper_093_remark_prior_art_propositions`（`structured-latex-en/content/008_prior_art.ts`）
- **日本語の原文**: **対応物なし。** 日本語版の命題 V の既出性記述
  （`paper_061_theorem_V` の proof 末尾）は次だけである。
  > $d=1$ の場合は**既知の古典から直ちに従う**。周期点数の列は Dold 数列…であり、
  > Byszewski–Graff–Ward … Definition 2.1 の定義で $n=p$ と取れば $a_p\equiv a_1\pmod p$ が出る…
  > $d\ge2$ の終結式合同の形は、調べた範囲では見つからなかった（無いとは言わない）。

  **日本語版は類数について一言も述べていない。**
- **英訳（英語版限定の新文）**:
  > On the number-theoretic side the corresponding fact — that $p\nmid h_0$ implies $p\nmid h_n$
  > throughout a $\mathbb{Z}_p$-extension — is classical.
- **何が変わったか**: 日本語版に無い数学的主張が、**出典なし・仮定なし**で新規に追加された。
- **なぜ問題か**: この形の古典的定理（Iwasawa。例えば Washington, *Introduction to Cyclotomic
  Fields*, Proposition 13.22）は、**「ちょうど 1 つの素点が分岐し、かつ完全分岐である」という
  仮定の下で**成立する。任意の $\mathbb{Z}_p$ 拡大について無条件に述べた形は、一般には正しくない
  （$p\nmid h_0$ から $\lambda=\mu=\nu=0$ は従わない）。本論文は「新規性を主張しない」ことを
  中心に据えており、その章で**未検証・無仮定の新主張を持ち込むのは自己矛盾**である。
  なお私はこの反例を具体的に構成していない（§4 参照）。仮定が落ちていること自体が問題である。
- **どう直すべきか**: 出典と仮定を付けるか、削除する。削除が安全である。付けるなら:

  ```
  " On the number-theoretic side there is a classical analogue: in a ",
  math(String.raw`\mathbb{Z}_p`),
  "-extension in which exactly one prime ramifies and does so totally, ",
  math(String.raw`p\nmid h_0`),
  " implies ",
  math(String.raw`p\nmid h_n`),
  " for every ",
  math(String.raw`n`),
  " (Iwasawa; see Washington, Proposition 13.22). We do not use this fact, and we record it only to ",
  "place the present statement.",
  ```

  ただし `refs.bib` に Washington が無いため、`cite` を足すなら書誌の追加が要る。
  **削除する場合は、直前の文（Dold 数列の段）だけで日本語版と等価になる。**

---

### 【重要 3】要旨の Lean 宣言数 85 が古い（現在は 105）

- **ブロック id**: `frontmatter.ts` の `abstract` 第 3 段
- **日本語の原文**: 日本語版は**数を述べていない**。`paper_011_remark_positioning` は
  「$\mathrm{sorry}$ ゼロを機械確認した」とだけ書く。
- **英訳**:
  > Part of the material has been formalised in Lean 4 with mathlib4, where **85 declarations** have
  > been checked mechanically to be free of $\mathrm{sorry}$, …
- **何が変わったか**: 日本語版に無い定量値が足され、その値が**リポジトリの現状と一致しない**。
- **なぜ問題か**: 一次情報で確認した実測は次のとおり。
  - `lean/logs/check-no-sorry-cycle18.log`: `depends on axioms` の行 **85 件**
  - `lean/logs/check-no-sorry-cycle19.log`: `depends on axioms` の行 **105 件**（最新）
  - `lean/IntegrableLattice/*.lean` の トップレベル `theorem`/`lemma`/`def` 合計 **100 件**

  85 は cycle 18 時点の値である。cycle 19 で命題 C″（`PropCTracePeriod.lean`、22 宣言）が
  入っており、日本語版・英語版の `paper_045_theorem_trace_ladder` は
  その 5 定理を `lean` フィールドに宣言している。**投稿稿の要旨に、検証可能で、かつ現状と
  食い違う数値が載っている**のは投稿前に必ず潰すべきである。
- **どう直すべきか**: 数を書くなら最新の実測へ更新し、根拠ログを固定する。

  ```
  "mathlib4, where 105 declarations have been checked mechanically to be free of ",
  ```

  あるいは数を落として日本語版と同じ強さにする:

  ```
  "mathlib4, and the formalised statements have been checked mechanically to be free of ",
  ```

---

### 【重要 4】読者ガイドの前提知識の記述が、本論文が実際に使う道具と合っていない

- **ブロック id**: `paper_015_remark_reading_guide`（英語版限定）
- **日本語の原文**: **対応物なし。**
- **英訳**:
  > **What the reader is assumed to know.** Undergraduate algebra is enough: finite fields, the
  > resultant of two polynomials, the Smith normal form of an integer matrix, and the Newton polygon
  > of a polynomial over a valued field. Each of these is used concretely and is recalled where it
  > is first needed.
- **何が変わったか**: 日本語版に無い、論文全体の前提についての新主張。
- **なぜ問題か**: 挙げた 4 つでは本文が読めない。本文が実際に使う道具のうち、この一覧に無いもの:
  - **Dedekind の差積・分岐指数・$p$ 極大位数・Euler の双対基底公式**（命題 W*、
    `paper_046_theorem_wstar_different`）
  - **Turing 機械と停止問題**（命題 F の (F2)）
  - **Newton 多面体と Minkowski 分解**（命題 G′ の (G′1)。1 変数の Newton **多角形**とは別物であり、
    用語集自身が「別物なので語を使い分ける」と書いている）
  - **Artin の指標の一次独立性・一般化固有空間分解**（命題 B）
  - **代数的 $\mathbb{Z}^d$ 作用の位相的エントロピー・atoral 多項式**（第 3 章）
  - **$\mathbb{Z}_p[[\Gamma]]$ 上の岩澤加群**（第 5 章の命題 D）

  Expositiones の Survey Article は「その話題の専門家でない数学者」が読者であり、
  **前提の一覧が実態と合っていないことは、その読者を直接裏切る。**
- **どう直すべきか**: 一覧を実態に合わせ、「recalled where it is first needed」という約束を、
  実際に守れる範囲へ弱める。

  ```
  "**What the reader is assumed to know.** The backbone is undergraduate algebra: finite fields, ",
  "the resultant of two polynomials, the Smith normal form of an integer matrix, and the Newton ",
  "polygon of a polynomial over a valued field. Three chapters go beyond that at one point each, ",
  "and each such point is isolated: Chapter 3 quotes the topological entropy of an algebraic ",
  math(String.raw`\mathbb{Z}^d`),
  "-action without proof, Chapter 4 uses the different and the ramification data of a number field ",
  "in Proposition W* alone, and Chapter 5 uses the halting problem in Proposition F (F2) alone. ",
  "A reader who skips those three statements loses nothing else.",
  ```

---

### 【重要 5】読者ガイドが「岩澤理論を引くのは第 3 章と第 5 章」と書いているが、第 3 章は岩澤理論ではなく、第 6 章が抜けている

- **ブロック id**: `paper_015_remark_reading_guide`（英語版限定）
- **日本語の原文**: **対応物なし。**
- **英訳**:
  > Where results from Iwasawa theory are quoted — **in Chapters 3 and 5** — they are quoted as
  > known theorems, with reference and proposition number, and are not reproved.
- **何が変わったか / なぜ問題か**: 事実誤り。
  - **第 3 章は岩澤理論を 1 つも引かない。** 引くのは Lind–Schmidt–Ward（力学系）と
    Lind–Schmidt–Verbitskiy であり、内容は位相的エントロピー＝Mahler 測度である。
  - **第 6 章（命題 W）が抜けている。** `paper_063_theorem_W` の証明は
    「$\mu$ の上界方向は自前で証明していない。これは Cuoco–Monsky Theorem 1.7 の帰結であり」と
    明記しており、これは岩澤理論の引用そのものである。
- **どう直すべきか**:

  ```
  "at all, which is precisely contribution (b). Where results from Iwasawa theory are quoted — in ",
  "Chapters 5 and 6 — they are quoted as known theorems, with reference and proposition number, and ",
  "are not reproved.",
  ```

---

### 【中 6】先行研究の章が「命題 T は Mednykh–Mednykh からは従わない」を、証明機構の違いという成立しない根拠で述べている

- **ブロック id**: `paper_093_remark_prior_art_propositions`（英語版限定）
- **日本語の原文**: 日本語版 `paper_062_theorem_T` の既出性記述は次で止まっている。
  > **等号 $v_2(\tau(L))=2(L-1)$ そのものは、調べた範囲では見つからなかった。**
  > 本命題はその強化として位置づく。
- **英訳（英語版限定の新文）**:
  > The two proofs proceed by different mechanisms — unramifiedness, Hensel lifting and the Newton
  > polygon here, versus squareness via an involution on Galois conjugates there — **so Proposition T
  > does not follow from theirs.**
- **何が変わったか**: 「見つからなかった」という**探索の報告**が、「彼らの定理からは導けない」という
  **導出不可能性の主張**へ格上げされた。
- **なぜ問題か**: 結論自体は（彼らの定理が $v_2$ の偶数性しか与えない以上）真だが、
  **述べられた根拠が論理的に成立しない。** 2 つの証明の機構が違うことは、一方が他方から
  従わないことを一切含意しない。本論文は命題 C で「0 件の観察を根拠にしてはならない」と
  方法論を説いており、**同じ論文の中で非論証を根拠として置くのは一貫性を損なう。**
  査読者が最初に突く型の穴である。
- **どう直すべきか**: 根拠を「彼らの結論が厳密に弱いこと」へ置き換える。

  ```
  " Their conclusion is strictly weaker — it fixes the parity of ",
  math(String.raw`v_2(\tau(L))`),
  " but not its value — so Proposition T is not a consequence of it. The two proofs also proceed by ",
  "different mechanisms: unramifiedness, Hensel lifting and the Newton polygon here, versus ",
  "squareness via an involution on Galois conjugates there.",
  ```

---

### 【中 7】日本語版が `ref()` で張っていた相互参照 13 件が、英語版では地の文の手書き章番号に落ちたままになっている

- **ブロック id**: `paper_051_theorem_duality`、`paper_053_theorem_lower_order`（第 5 章）、
  `paper_055_theorem_theta_infinity`（第 5 章続き）、`paper_063_theorem_W`（第 6 章）、
  `paper_071_remark_asymmetry`、`paper_081_remark_scope`（第 7・8 章）
- **実測**: 日本語版の相互参照 **48 件**、英語版 **35 件**（両方の `npm run check` の出力。§3 に貼る）。
  失われた 13 件の内訳は次のとおり。いずれもソース中に `TODO(ref)` / `TODO(integration)` の
  コメントが残っている。

  | 参照先ラベル | 日本語 | 英語 | 英語版での書かれ方 |
  |---|---|---|---|
  | `paper_thm_archimedean` | 2 | 0 | "the archimedean theorem of Chapter 3" |
  | `paper_prop_W` | 5 | 2 | "Proposition W of Chapter 6" |
  | `paper_prop_G` | 9 | 6 | "Proposition G" |
  | `paper_remark_D_limits` | 2 | 0 | "the remark on the limitations that remain in Proposition D" |
  | `paper_def_curve` | 2 | 1 | "the definition of the integer spectral curve (Chapter 2)" |
  | `paper_claim_resultant` | 2 | 1 | "the resultant claim of Chapter 2" |
  | `paper_prop_V` | 1 | 0 | "Proposition V of Chapter 6" |
  | `paper_prop_D` | 3 | 2 | "Proposition D" |
  | `paper_prop_F` | 3 | 2 | "Proposition F" |

- **なぜ問題か（現時点では誤りではない）**: **手書きの章番号は現在すべて正しい。**
  英語版限定の 2 ファイルは、`001a_reader_guide.ts`（`level: 1` の見出しを持たず第 1 章末尾に入る）と
  `008_prior_art.ts`（末尾の第 9 章）であり、第 2〜8 章の番号は日本語版と一致している
  （EN の文書順: 001→001a→002→…→007→008）。したがって現状の PDF は正しく組める。
  問題は**将来の壊れ方**である: 章を 1 つでも足す・並べ替えると、`\cref` が追随する 35 件は
  自動で直り、手書きの 13 件だけが**無言で誤りになる**。これは日本語版が `ref()` を使って
  避けている事故そのものであり、英語版だけがその防御を失っている。
- **どう直すべきか**: 全章の英訳が揃った現在、`TODO(ref)` / `TODO(integration)` を機械的に
  `ref()` へ戻す。参照先ラベルはすべて英語版に実在するので型検査を通る。例（第 5 章）:

  ```
  // before
  "In the setting of the definition of the integer spectral curve (Chapter 2), let ",
  // after
  "In the setting of ",
  ref("paper_def_curve"),
  ", let ",
  ```

  戻し忘れの検出のため、`tools/` に「`content/` に `TODO(ref)` が残っていたら落とす」検査を
  足しておくのが確実である（本レビューは読み取り専用なので実装していない）。

---

## 2. caveat チェックリスト（1 件ずつ判定）

判定は「保存されている / 薄まっている / 消えている」。**日本語版由来のブロックについては、
薄まり・消失は 0 件である。**

| # | caveat | 日本語版のブロック | 英訳の該当箇所 | 判定 |
|---|---|---|---|---|
| 1 | 命題 C の方法論注記（43 例で 0 件 → 572 例で 4.5% → 仮説棄却。**0 件を根拠にしてはならない**） | `paper_043_theorem_bound` proof | "a search over 43 examples produced no counterexample … enlarged … to 572 examples, counterexamples appeared at a rate of 4.5%, and **the hypothesis was refuted**. An observation of zero cases must not be used as evidence." | **保存されている** |
| 2 | 命題 C の「等号（Wall 型）は一般には成立しない」と 3 数値（2.1% / 4.5% / 3.4%） | `paper_043_theorem_bound` | "equality failed for 10 out of 472 … (about 2.1%), and for 26 out of 572 … (about 4.5%)" / "fails in 56 out of 1669 examples (3.4%)" | **保存されている** |
| 3 | 命題 B の【訂正】（以前の版は 2 つの周期を同じ記号で書き、その読みでは主張は偽。22.6%）と「半単純性でも救済できない」 | `paper_042_theorem_pi_p1` | "**[Correction]** … **under that reading the statement was false** … **assuming semisimplicity does not rescue the statement** … 563 cases (22.6%)" | **保存されている** |
| 4 | 命題 N の「例外集合は算術級数の有限和であり**一般に無限集合**」（以前の「有限個の $N$」は誤り） | `paper_044_theorem_newton` proof | "The exceptional set is a finite union of arithmetic progressions and is therefore **infinite in general**. This is an error in the text of an earlier version …" | **保存されている** |
| 5 | 命題 N の Newton 多角形の**向きの規約**（逆向きでは符号が反転する） | `paper_044_theorem_newton` | "**Convention on the orientation of the Newton polygon** … Under the opposite convention the sign is reversed, so the phrase minimal slope must never be used without stating the convention." | **保存されている** |
| 6 | 命題 C′ の「基準レベルを 1 のままにした補正は不可能」と反例 $T=F\oplus F$, $p=2$ | `paper_043b_theorem_trace_bound` | "**No correction is possible that keeps the base level fixed at one.** … is false however the exponent $a$ is chosen … What has to be corrected is not the exponent but the base level." | **保存されている** |
| 7 | 命題 F の (F2) 決定不能性 / 「素朴なレシピは上限しか与えない」と反例 $P=z+w^2-2w$, $p=3$ | `paper_052_theorem_l0_computable` | "the predicate $l_0(f)\ge1$ is **undecidable** — it reduces to the halting problem" / "**gives only an upper bound** … Counterexample: for $P=z+w^2-2w$ and $p=3$ …" | **保存されている** |
| 8 | 命題 G の (G5)「退化 ⇒ $n\ell^n$ 項」は偽 / (G6) の「$\ell=2,3$ の退化塔は構造的に射程外」 / 「残る限界: $\theta(P)\ge\ell+1$ は未解決」 | `paper_053_theorem_lower_order` | "**degenerate and yet carries no $n\ell^n$ term**. Degeneracy does not entail …" / "**the degenerate towers for $\ell=2,3$ are structurally out of scope**" / "**What remains beyond reach.** … is **still unresolved**" | **保存されている** |
| 9 | 命題 D の但し書き（一般性は $v_p(a^{\mathrm{red}}_{p^n})$ の漸近についてで、グラフの全域木数として実現できるとは限らない） | `paper_051_theorem_duality` proof | "**A caveat is needed here.** … it does **not** say that the polynomial $P$ in question can be realised as the number of spanning trees $\kappa$ of a graph, and **in general it cannot be**." | **保存されている** |
| 10 | 命題 W の「$\nu\in\mathbb{Q}$ であって一般に $\mathbb{Z}$ ではない」（cycle 18 の書き落とし追記も含む） | `paper_063_theorem_W` | "**we have** $\nu\in\mathbb{Q}$ **while in general it does not lie in** $\mathbb{Z}$ … **This membership statement was added because the Lean formalisation in cycle 18 revealed that it had been omitted.**" | **保存されている** |
| 11 | 命題 T の形式化の範囲（matrix-tree の段と Hensel の段は形式化していない）と浮動小数点の注意 | `paper_062_theorem_T` proof | "**The matrix-tree step, and the step consisting of the unramifiedness of 2 and the Hensel lifting, are not formalised**: …" / "Floating-point arithmetic must not be used here: it loses significance for $L\ge7$ and yields a false conclusion." | **保存されている** |
| 12 | 命題 D の限界（$\#V_X$ が相殺すること、「Monsky の定理の左辺 ＝ $\mathrm{ord}_p(\kappa)$」ではないこと） | `paper_054_remark_limits` | "The factor $\#V_X$ **cancels** … So the left-hand side of Monsky's theorem is **not** equal to $\mathrm{ord}_p(\kappa)$." | **保存されている** |
| 13 | 「本論文が主張しないこと」の 4 項目 | `paper_081_remark_scope` | 4 項目とも順序も内容も一致（solvability / new exact solution / new number theory / T・V・W の新規性） | **保存されている** |
| 14 | 「スケールの偶然一致を接続と呼ばない」（$4G/\pi$ と Lehmer 数） | `paper_071_remark_asymmetry` | "**A caution (we do not call a numerical coincidence of scale a connection)** … **this is a coincidence between quantities of different scales and not a connection**. This paper does not connect the two." | **保存されている** |

**集計: 保存 14 件 / 薄まり 0 件 / 消失 0 件。**
（指示のチェックリストは 13 項目だが、命題 C の「等号は一般に成立しない」と方法論注記を
別項目として数えたため 14 行になっている。）

### 既出性の言い回し（項目 3）

| 日本語 | 英訳 | 判定 |
|---|---|---|
| 「調べた範囲では見つからなかった（無いとは言わない）」（命題 V） | "we could not find … in the literature we searched; we do not claim that it does not exist" | 一致 |
| 「等号そのものは、調べた範囲では見つからなかった」（命題 T） | "**We could not find the equality … itself in the literature we searched.**" | 一致 |
| 「網羅調査ではないので『文献に無い』とは書かない」（命題 G の (G4)） | "our search was not exhaustive, and therefore **we do not write that the result is absent from the literature**" | 一致 |
| 「弱い形は既出である」（命題 T） | "**a weak form is already in the literature**"（"well known" にしていない） | 一致 |
| 「既知定理であり、本論文はこれを引用するだけである」（第 3 章） | "known theorems, and this paper merely cites them"（"well-known" にしていない） | 一致 |
| 「MathSciNet は未使用で、検索は本文検索ではない」 | "MathSciNet was not used and the searches were not full-text"（英語版限定章にも独立の節あり） | 一致 |
| 「新規性は主張しない」 | "We claim no novelty."（全 5 箇所） | 一致 |

**"to the best of our knowledge" / "this is new" / "there is no …" への化けは 0 件。**

### 記号の一貫性（項目 4）

$\pi(p,k)$（行列冪列の周期）と $\pi_{\mathrm{tr}}(p,k)$（トレース列の周期）の言い分けを
第 4 章の全 6 ブロックで確認した。

- `paper_041_theorem_periodicity`: "the period of the **matrix power sequence**" と
  "the period of the **trace sequence**" を明示的に対比し、「逆は成り立たない」も保存。
- `paper_043_theorem_bound`: "Read with the trace sequence in place of the matrix power sequence,
  this upper bound becomes false." — 日本語版の警告と等価。
- `paper_043b` / `paper_045_theorem_trace_ladder` / `paper_046`: すべて $\pi_{\mathrm{tr}}$ 側の
  記述で一貫。混同は 1 件も無い。

---

## 3. 機械検証の出力

すべて自分で実行した。実行前に
`structured-latex/`・`integrable-lattice/structured-latex/`・`integrable-lattice/structured-latex-en/`
の 3 箇所で `npx --yes pnpm@9 install` を通してある（Node v22.22.3）。

### `(cd integrable-lattice/structured-latex-en && npm run check)`

```
generated .../integrable-lattice/structured-latex-en/build/document.tex
  ブロック 43 件（見出し 9、証明 16、TODO 0） / ラベル 36 件 / 相互参照 35 件（すべて解決） / 引用 59 件（.bib のキー 23 件、すべて実在）
no notes in output: ノート 0 件（本文サンプル 0 件）は いずれも build/document.tex に現れない
…
すべての負テストが期待どおり: 誤った入力は tsc が拒否する（6 件）
…
実行時検証テスト 11 件すべて期待どおり
```

**緑。**

### `(cd integrable-lattice/structured-latex-en && npm run build:pdf)`

```
generated .../structured-latex-en/build/document.tex
  ブロック 43 件（見出し 9、証明 16、TODO 0） / ラベル 36 件 / 相互参照 35 件（すべて解決） / 引用 59 件（.bib のキー 23 件、すべて実在）
built .../structured-latex-en/build/document.pdf: 25 ページ、未解決参照 0 件、未定義引用 0 件、組めない文字 0 件、版面外へ出た行 0 件（軽微な overfull 1 件は余白内）、参考文献 18 件
no notes in output: ノート 0 件（本文サンプル 0 件）は いずれも build/document.tex に現れない
```

**緑。**

### `node integrable-lattice/structured-latex-en/tools/verify-ja-en-correspondence.ts`

```
日英対応検証
  日本語版: 36 ブロック / 30 ラベル（8 ファイル）
  英語版:   43 ブロック / 36 ラベル（10 ファイル）
  突き合わせた対応ブロック: 36 件
  英語版に欠落しているブロック: 0 件
  英語版に欠落しているラベル: 0 件
  英語版限定ブロック: 7 件
  例外表: 数式差 4 件 / 英語版限定 7 件
違反 0 件: 英語版は日本語版の内容を 1 件も失っていない。
```

**緑。欠落は 0 件なので、指示にある「何が欠けているかの列挙」は該当なし。**

ただし**この緑の意味を過大に読んではならない。** 対応検証が保証しているのは
(a) 日本語版の全 36 ブロックに英語版の対応ブロックがあること、(b) `math`/`displayMath` の
多重集合が一致すること（例外表登録の 4 件を除く）、(c) ラベルが揃っていることの 3 点だけである。
**地の文の意味が保たれているか、英語版限定 7 ブロックが新主張を足していないかは検査していない。**
§1 の問題 7 件のうち 6 件は、まさにこの検査の外側にある。

例外表 4 件はいずれも「数式中の `\text{}` の中身（＝地の文）だけを英訳した」もので、
理由は `tools/ja-en-exceptions.ts` に記録されている。実際に確認した差は次の 4 件で、
**`\text{}` の外側の数式記号は 1 文字も変わっていない。**

| ブロック | 日本語 | 英語 |
|---|---|---|
| `paper_012_definition_ladder` | `\text{無条件に決定可能}` 他 2 件 | `\text{decidable unconditionally}` 他 |
| `paper_042_theorem_pi_p1` | `\text{は }\chi_T\bmod p\text{ の相異なる根}` | `\text{is a distinct root of }\chi_T\bmod p` |
| `paper_046_theorem_wstar_different` | `\text{局所的に}` | `\text{locally}` |
| `paper_055_theorem_theta_infinity` | `\text{は原始}\ \ell^M\ \text{乗根}` / `\sum_{\text{例外直線}}` | `\text{ is a primitive }\ \ell^M\ \text{th root of unity}` / `\sum_{\text{exceptional lines}}` |

### `(cd integrable-lattice/structured-latex && npm run check)`

```
  ブロック 36 件（見出し 8、証明 16、TODO 0） / ラベル 30 件 / 相互参照 48 件（すべて解決）
✓ 具体化: 本文中の ref が存在しないラベルを指す
✓ 【固有】本文ブロックが habitat を宣言していない
…
実行時検証テスト 13 件すべて期待どおり
```

**緑。** ここで得た「日本語 48 件 / 英語 35 件」の相互参照数の差が、§1【中 7】の一次情報である。

### Lean 宣言数の実測（【重要 3】の根拠）

```
$ grep -c 'depends on axioms' integrable-lattice/lean/logs/check-no-sorry-cycle18.log
85
$ grep -c 'depends on axioms' integrable-lattice/lean/logs/check-no-sorry-cycle19.log
105
$ grep -h '^theorem \|^lemma \|^def ' integrable-lattice/lean/IntegrableLattice/*.lean | wc -l
100
```

---

## 4. 自分が確認できなかったこと（推測で埋めていない）

1. **文献の実物を一切見ていない。** Monsky 1981 / 1989、Cuoco–Monsky 1981、Kataoka、
   Byszewski–Graff–Ward、Mednykh–Mednykh、Vallières、DuBose–Vallières、Tateno–Ueki、
   Ax–Kochen、Ershov、Alonso García–Lombardi–Perdry、Haskell を 1 本も読んでいない
   （この環境からネットワークへ出ていない）。したがって
   **「英訳が引用元の主張を正しく述べているか」は検証していない**（これは並走している
   引用検証レビュアーの担当である）。私が検証したのは「英訳が**日本語版の記述**を
   変えていないか」だけである。
2. **【重要 2】の $\mathbb{Z}_p$ 拡大の主張について、反例を具体的に構成していない。**
   私が確認したのは「日本語版に対応物が無いこと」と「古典的定理の標準形には分岐についての
   仮定が付くこと」であり、後者は文献を再確認していない記憶に基づく。
   **したがって『この文は偽である』とは書いておらず、『仮定なしで書かれており出典が無い』と
   書いている。** 投稿前に本人が出典を当てて確認すること。
3. **`paper_093` に新登場する Tateno–Ueki の記述**（"who quote Monsky's theorem and likewise
   record only existence and rationality for $d=2$"）は日本語版に対応物が無い。
   `refs.bib` にキーが実在することは `build:pdf` の「未定義引用 0 件」で確認したが、
   **その内容が正しいかは確認していない。**
4. **`paper_093` に新登場する Mednykh–Mednykh の定理形**（"for odd $n$ the number of spanning
   trees factors as $n\,\tau(H)\,a(n)^2$"）も日本語版に無い。日本語版が書いているのは
   $C_L\times C_L$ に特殊化した $\tau(L)=L^2a(L)^2$ だけである。**一般形が原論文どおりかは
   確認していない。**
5. **Lean の `lake build` を実行していない**（mathlib のキャッシュ取得を含む大きな実行になるため）。
   宣言数はソースの grep と既存ログの実測であり、**現在のソースが実際にビルドを通るかは
   確認していない。** 【重要 3】で「105」を推奨したのは cycle 19 のログの実測値だが、
   投稿前には `check-no-sorry.sh` を回した最新の実測へ合わせること。
6. **PDF の目視確認をしていない。** `build:pdf` の自動検査（未解決参照・未定義引用・
   組めない文字・版面外）が緑であることは確認したが、25 ページを目で読んではいない。
7. **英語としての自然さ・冠詞・時制は見ていない。** 本レビューのスコープは数学的主張の一致である。

## 5. 自分が犯した誤り

- 作業の初期に `npm run build:pdf` を、直前の `cd` でディレクトリが移動した状態のまま
  相対パスで実行し、`cd: integrable-lattice/structured-latex-en: No such file or directory` で
  失敗させた。絶対パスで実行し直して成功している（§3 の出力はやり直した後のものである）。
- 相互参照の数え上げを最初に単純な `grep` で行い、**JSDoc コメントと `TODO(ref)` コメントの中の
  `ref("...")` を実コードとして数えてしまった**（英語版の参照が日本語版より多い、という誤った
  中間結果を出した）。コード行だけを拾う形に直し、両版の `npm run check` が報告する
  相互参照数（48 / 35）と突き合わせて確定させた。§1【中 7】の表はやり直した後の値である。
- 指示は「日本語 33 ブロック」と書いているが、**実際の日本語版は 36 ブロック**である
  （`content/005b_theta_infinity.ts` の命題 G′ と、第 4 章に後から入った命題 C″・命題 W* の
  3 ブロックが、指示の元になった `docs/paper001-en-glossary.md` §0 の「7 ファイル・33 ブロック」より
  後に足されている）。**36 ブロック全部を突き合わせた。**
