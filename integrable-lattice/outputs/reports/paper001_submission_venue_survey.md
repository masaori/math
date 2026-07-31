# 論文 001（ℝ/Λ 双対）の投稿先調査 — 候補誌と推奨順位

作成日: 2026-08-01 / 対象: `integrable-lattice/structured-latex/content/`（論文 001 本体）

**この文書は投稿先の調査であって、投稿の実行ではない。外部への連絡・投稿は一切していない。**

各候補誌の性質は**その誌の公式サイト（出版社ドメイン）を実際に取得して**確認した。
取得できなかったものは §5 に「取得できなかった」と明記する。検索結果の要約だけを根拠にした項目は
§5 に隔離し、§3 の比較表には入れていない。

---

## 0. 結論（先に結論だけ）

**論文 001 は、現在の形（日本語・14 ページ・「新しい定理を主張しない」と本文冒頭で宣言）のままでは、
研究論文を載せる雑誌には出せない。** 出せるのは解説・サーベイを載せる雑誌だけであり、
そのすべてが**英語**を要求する。したがって投稿の可否より先に決まるのは「英訳するか」である。

推奨順位（英訳する前提。根拠は §3、判定の理由は §4）:

| 順位 | 投稿先 | 記事種別 | なぜここか | 障害 |
|---|---|---|---|---|
| **1** | **Expositiones Mathematicae** | Survey Article | 「専門家でない研究者・大学院生が読めるサーベイ」という種別が公式に定義されており、**ページ数上限が無い**。「新結果を主張しない」ことが減点にならない唯一の主要誌 | 英語必須。Elsevier 購読誌（OA は任意） |
| **2** | **L'Enseignement Mathématique** | 研究論文（ただし「広い数学者層に少なくとも部分的に理解できる」ことを明示的に重視） | Subscribe-to-Open で**著者負担ゼロ・読者無料**（2026 年末まで確認済み）。broad accessibility を掲げる数少ない研究誌 | 「research articles」を主に載せる誌なので、新結果ゼロの宣言は不利 |
| **3** | **EMS Surveys in Mathematical Sciences** | サーベイ・高水準の解説 | 「あらゆる数学諸分野の権威あるサーベイ」を掲げる査読誌。Subscribe-to-Open で著者負担の記載なし | 想定されている水準が高い（分野の権威によるサーベイ）。14 ページは短い |
| **4** | **Jahresbericht der DMV** | Review article / research report | 総説・研究報告・歴史記事を載せ、英独バイリンガル。読者を限定しない方針 | ドイツ数学会の会誌という性格。日本発の投稿の前例を確認していない |
| — | **arXiv（math.NT + math.LO クロスリスト）** | プレプリント | 雑誌と排他ではない。**先に出しておく**のが自然 | §3.9 の注意（新規性欠如が却下事由に挙がっている）。分野ごとに endorsement の仕組みがある |

**別ルート（論文を切り分けるなら、こちらの方が通る見込みは高い）:**

- **ルート B（新規部分を研究論文として切り出す）**: cycle 18 step 1 の「一般の退化塔・消滅深度 θ による閉形式」は、
  cycle 17–18 の既出性調査で**既出が見つからなかった唯一の中核**である（Monsky 1989 を入手して潰した）。
  これだけを研究論文にすれば、**Annales mathématiques du Québec**（Vallières 系列の abelian ℓ-tower 論文 2 本の掲載誌）、
  **Algebraic Combinatorics**（DuBose–Vallières の $\mathbb{Z}_\ell^d$ 塔論文の掲載誌）、
  **Research in Number Theory** が正面から適合する。**引用文献がそのままこれらの誌に載っている**のが根拠である。
- **ルート C（Lean 形式化を主題にする）**: 85 定理が sorryAx 非依存であること、形式化が本文の誤りを 2 サイクル連続で
  検出したことを主題にするなら、**CPP**（12 ページ・formalization case study を明示的に歓迎）または **ITP**、
  雑誌なら **Journal of Automated Reasoning**（数学の形式化を応用例として明記）。

**投稿できないと判定した候補（一次情報で確定）:**

- **雑誌『数学』（日本数学会）**: 原稿は**原則として依頼稿**。公募の「寄稿」欄は**組版 3 ページ以内**かつ
  **日本数学会会員に限る**。14 ページの論文 001 は寄稿欄に入らない（§3.7、公式 PDF から引用）。
- **Sugaku Expositions（AMS）**: 『数学』の論説の英訳を載せる誌であり、直接投稿する誌ではない（§3.7）。
- **Japanese Journal of Mathematics**: 招待サーベイ誌（§3.8）。

---

## 1. 論文 001 の確定事実（リポジトリの実測。推測なし）

投稿先を選ぶ判断は、すべてこの節の事実から出している。

| 項目 | 値 | 確認方法 |
|---|---|---|
| 言語 | **日本語** | `structured-latex/content/*.ts` の本文 |
| 分量 | **14 ページ**（A4・余白 25mm） | `npm run build:pdf` の実測（2026-08-01 実行） |
| 構造 | ブロック 33 件（見出し 8・証明 14・TODO 0）／ラベル 27 件／相互参照 32 件（未解決 0） | 同上 |
| 参考文献 | 23 エントリ（`outputs/papers/001_R_Lambda_duality/refs.bib`） | `grep -c "^@"` |
| 位置づけ | **「新しい定理・新しい厳密解・新しい深い数論を一切主張しない」と第 1 章冒頭で宣言** | `content/001_intro.ts` の `paper_011_remark_positioning` |
| 与えるもの | (a) 二素点の辞書 (b) $\mathbb{Q}_p$ を要さない可算化の精密化 (c) 決定可能命題群の確定 (d) 決定可能性非対称の地図 | 同上 |
| 命題 | A・B・C・C′・N・L（第 4 章）、D・F・G（第 5 章）、T・V・W（第 6 章） | `content/004`–`006` |
| 形式検証 | Lean 4 + mathlib4、85 定理が sorryAx 非依存 | `MEMORY.md` cycle 18 step 3 |
| 既出性 | **「おおむね既出」**。命題 V は古典の帰結、命題 T は弱形が既出、命題 W は $d=1$ の形が既出。寄与 (b) は逆数学・構成的代数の標準手法 | `outputs/reports/cycle17_T1_prior_art_check.md` の結論サマリ |
| 既出が見つからなかった中核 | 命題 W の $d=2$ 明示係数（$d=1$ の形は Vallières 2021 で既出だが、$d=2$ の係数の明示は最新論文が「追わない」と明記。Monsky 1989 を入手して $\alpha^*$ の明示式が無いことを確認）と、cycle 18 の一般退化塔（消滅深度 $\theta$ による閉形式） | `MEMORY.md` cycle 18 step 1・step 4、`outputs/reports/cycle18_T1_monsky1989_acquisition.md`、`cycle17_T1_prior_art_check.md` |

分野横断の内訳（投稿先の分野選択に効く）: 数論（Mahler 測度・Lehmer 問題・$\mathbb{Z}_\ell^d$ グラフ塔の岩澤型漸近）、
数理論理（決定可能性・逆数学）、力学系（代数的 $\mathbb{Z}^d$ 作用の周期点）、統計力学（全域木エントロピー）、
形式検証（Lean）。**単一分野の専門誌に収まらない**ことが、解説誌を推す構造的な理由である。

---

## 2. 判定に使った軸

1. **内容適合性**: その誌が「新結果を主張しない解説」を記事種別として認めているか。
2. **長さ・形式**: 14 ページ（英訳後はおそらく 12–18 ページ）が種別の規定に収まるか。
3. **言語**: 日本語のまま出せるか、英訳が要るか。
4. **査読方針**: 査読の有無と、査読が何を見るか（新規性か、明快さか）。
5. **掲載料・OA 条件**: 著者負担の有無。

---

## 3. 候補ごとの一次情報

### 3.1 Expositiones Mathematicae（Elsevier）— 推奨 1 位

- 公式: <https://www.sciencedirect.com/journal/expositiones-mathematicae>（ScienceDirect 本体は取得時 403。
  出版社ドメインの <https://shop.elsevier.com/journals/expositiones-mathematicae/0723-0869> から取得）
- **記事種別が 3 つ公式に定義されている**:
  - **Survey Articles** — 特定の研究領域を、非専門家にも読める形で組織立てて概観するもの。**ページ数上限なし**。
  - **Main Research Articles** — **significant new results を含むことが必要**。**最低 11 ページ**。
  - **Short Research Notes** — 専門的で狭い範囲でもよい。**10 ページ以内**。
- 言語: **英語**。刊行: 年 1 巻 6 号。ISSN 0723-0869。
- 採否の基準として「解説の明快さ・細部の正確さ・研究結果の質・主題の関連性と興味深さ」が挙げられている。
- **論文 001 の適合**: Survey Article に出す。**「新結果を主張しない」ことが種別の要件と矛盾しない唯一の候補**。
  ページ上限が無いので 14 ページ相当でも短さ以外の問題は生じない。
  ただし種別の想定は「その領域の概観」であり、論文 001 は概観ではなく**特定の辞書と命題群**なので、
  序論で「何を概観として与えるか」を書き足す必要がある。
- 掲載料: 購読誌（hybrid）。OA を選ばなければ著者負担は生じない（Elsevier の一般方針。**この誌固有の APC 額は未取得**）。

### 3.2 L'Enseignement Mathématique（EMS Press）— 推奨 2 位

- 公式: <https://ems.press/journals/lem>
- Aims: 「あらゆる数学分野の研究論文を載せる。**広い数学者層に少なくとも部分的にアクセス可能な寄稿を特に重視する**」。
  ICMI（国際数学教育委員会）の公式誌。
- **OA**: 2023-01-01〜2026-12-31 に刊行される号は **Subscribe to Open により無料公開**。
- 刊行規模: 年 1 巻 2 号・約 450 ページ。zbMATH Open / MathSciNet / Web of Science 収録。
- **論文 001 の適合**: 「広い読者に届く」という編集方針は論文 001 の性格と合う。
  一方で誌の主たる対象は research articles であり、**新結果ゼロの宣言をそのまま出すと種別が合わない**。
  寄与 (b)（「$\mathbb{Q}_p$ を可算化した」ではなく「等号を決定可能な水準まで降ろした」）を
  中心に据え直せば研究論文として立つ、というのが cycle 17 の調査の指摘である。
- 掲載料: 公式ページに著者負担の記載なし（S2O は読者側の無料化であり、APC ではない）。
  **投稿規定ページ（`/submission`, `/submissions`, `/about`）はいずれも 404 で取得できなかった。**

### 3.3 EMS Surveys in Mathematical Sciences（EMS Press）— 推奨 3 位

- 公式: <https://ems.press/journals/emss>
- Aims: 「数理科学のあらゆる分野における**権威あるサーベイと高水準の解説**を刊行することに専念する」査読誌。
  広い読者向けに書かれたサーベイを対象とし、応用や概念的論点を含んでよい。
- **OA**: 2021-01-01〜2026-12-31 の号は Subscribe to Open で無料公開。**著者費用の記載なし**。
- 刊行規模: 年 1 巻 2 号・約 600 ページ。DOAJ 収録。
- **論文 001 の適合**: 種別としては最も素直に合う。ただし 1 本あたり 600/2 ページ規模の誌であり、
  **想定されているサーベイの水準・分量に対して 14 ページは小さい**。
- 投稿の可否: ページに Submit リンクはあるが、**招待制かどうかの明記は無い**（取得したページ上に記述なし）。

### 3.4 Jahresbericht der DMV（Springer）— 推奨 4 位

- 公式: <https://link.springer.com/journal/13291/aims-and-scope>
- Aims: 「数学のショーケース」。**総説（review articles）と研究報告（research reports）**で、
  現在進行中の重要な発展を**できるだけ多くの読者**へ伝える。歴史記事と書評欄をもつ。
- 言語: **英語とドイツ語のバイリンガル**。1890 年創刊。Springer の hybrid モデル。
- **論文 001 の適合**: 「review article / research report」という種別は論文 001 に合う。
  読者を専門家に限定しない方針も合う。
- 未確認: 長さ規定、投稿が公募か招待か、APC 額（aims and scope ページには記載が無い）。

### 3.5 数論・グラフ塔の研究誌（ルート B の投稿先）

論文 001 の引用文献が実際に載っている誌である。これは適合性の推測ではなく、**引用文献の掲載誌という事実**である。

| 誌 | 公式 | scope | 言語 | OA / APC | 論文 001 の該当部 |
|---|---|---|---|---|---|
| **Annales mathématiques du Québec** | <https://link.springer.com/journal/40316/aims-and-scope> | 純粋数学の全分野（応用数学・数理物理・計算機科学に及ぶこともある）の高水準誌 | **フランス語または英語**（要旨は両言語で掲載） | hybrid。**OA は £2190 / $3090 / €2490**、購読モデルなら**著者負担なし** | Vallières「On abelian ℓ-towers of multigraphs」I・III の掲載誌。命題 W・G 系列の直系 |
| **Algebraic Combinatorics** | <https://alco.centre-mersenne.org/> | 代数的手法と組合せ論の交点 | （公式ページに明記なし） | **完全 OA**（Free Journal Network 加盟）。**著者費用の記載なし** | DuBose–Vallières「On $\mathbb{Z}_\ell^d$-towers of graphs」の掲載誌 |
| **Research in Number Theory** | <https://link.springer.com/journal/40993/aims-and-scope> | 数論・数論幾何の国際査読誌。原著研究と**総説**を載せる | 英語 | hybrid。**OA は £2590 / $3790 / €2990**、購読モデルなら**著者負担なし** | 岩澤型漸近・$p$ 進付値の一般的な受け皿 |
| **Journal of the Mathematical Society of Japan** | 投稿規定 PDF（`sugaku-kitei.pdf` 付録 II） | 「数学における研究論文を掲載する」。年 1 巻 4 号 | **英語・仏語または独語** | （PDF に記載なし） | 日本国内の研究誌ルート |

Algebraic Combinatorics の投稿要件（公式 instructions-for-authors から）: 初回は LaTeX から組んだ PDF 1 本、
`amsart.cls` と BibTeX 推奨、参考文献は MathSciNet の BibTeX をそのまま使う。採択後は誌のクラスファイル必須で、
**版面・フォント・文字サイズの変更禁止、`\def` と `\renewcommand` 禁止、外部パッケージ禁止、複数ファイル禁止**。
→ 本プロジェクトの生成器（`structured-latex/tools/build-latex.ts`）は独自プリアンブル（xeCJK・`\jpstar` 等）を
出力するため、**この誌に出すなら出力を誌のクラスに合わせる作業が別途要る**。

JMSJ の投稿規定（公式 PDF 付録 II、実際に読んだ）: 英・仏・独語、PDF を <https://ef.msp.org/submit_new.php?j=jmsjapan> から
アップロード、英文 Abstract 必須、2020 MSC と Key Words を 1 ページ目脚注に、原則 TeX、上下左右 3cm の余白。

### 3.6 形式検証の会議・雑誌（ルート C の投稿先）

| 投稿先 | 公式 | scope と規定 |
|---|---|---|
| **CPP（Certified Programs and Proofs）** | <https://popl26.sigplan.org/home/CPP-2026> | 形式検証・証明支援系（Lean/Isabelle/Rocq 等）・数学ライブラリ・**formalization case studies を明示的に歓迎**。**本文 12 ページ以内**（文献表と付録を除く／付録なしで自足していること）。**軽量 double-blind**（著者名・所属を伏せ、自著は三人称で引用、証明スクリプトは匿名アーカイブで提出） |
| **ITP（Interactive Theorem Proving）** | <https://itp-conference-2026.github.io/> | 対話的定理証明の全側面（数学の形式化、証明器技術、検証応用、proof pearls）。**予稿集は LIPIcs（オープンアクセス）**。ITP 2026 は 2026-07-26〜29 に開催済みで、投稿締切（2026-02-19）は過ぎている → **次は 2027 年版** |
| **Journal of Automated Reasoning**（Springer） | <https://link.springer.com/journal/10817/aims-and-scope> | 「計算機による論理的推論」。証明支援系、証明システムの理論的性質、AI による証明探索。**実世界のケーススタディを重視し、数学の形式化を応用例として明記**。hybrid |

**論文 001 の該当部**: Lean 形式化が本文の誤りを 2 サイクル連続で検出した（cycle 17・18）という事実は、
CPP/ITP の case study として書けば主題になる。逆に、論文 001 の数学本体はこれらの会議の主題ではない。

### 3.7 雑誌『数学』（日本数学会）と Sugaku Expositions — **投稿できない（一次情報で確定）**

- 公式（誌のページ）: <https://www.mathsoc.jp/publications/sugaku/>
  年 4 回刊。論説・企画記事・書評・学界ニュース。岩波書店から出版。
- 公式（投稿規定 PDF）: <https://www.mathsoc.jp/assets/pdf/publications/sugaku/sugaku-kitei.pdf>
  「付録 I 雑誌'数学'原稿の作り方」の **III. '数学' 投稿案内** から引用:

  > 雑誌'数学'の原稿は原則として依頼稿ですが、'寄稿'欄への投稿も受け付けております。
  > '寄稿'欄は広い範囲の読者に興味をもってもらえるようなオリジナルな小編で**長さは組版原稿で 3 ページ以内**とします。
  > 原稿は'数学'のクラスファイルを用いて作成して下さい。
  > なお、'寄稿'欄への投稿は、**日本数学会の会員に限ります**のでご了承下さい。
  > 投稿された'寄稿'の採否は編集委員会で決定されます。

  同 I. 原稿について: 「本誌の原稿は、**日本語で作成**の上、日本数学会'数学'編集部宛に e-mail で
  編集可能なファイル（TeX・テキスト・ワード）と PDF ファイルを添付してお送り下さい。」

- 公式（論説執筆の手引 PDF）: <https://www.mathsoc.jp/assets/pdf/publications/sugaku/ronsetsu.pdf>
  想定読者は「記事に扱われた内容に興味を持つ大学院生や非専門家」。
  「入門的、歴史的記述を増やす、記事の最初の 3 分の 1 くらいは、過半の読者が関心を持ち理解できそうな内容にする」。
  **同 4.**: 「雑誌'数学'の論説は、その多くの英訳がアメリカ数学会(AMS)編集の Sugaku Expositions より出版されます。
  校正終了時に、英訳出版の諾否および翻訳の方法についておたずねいたします。」
- **判定**: 論説は依頼稿。公募枠の寄稿は 3 ページ以内かつ会員限定。**14 ページの論文 001 はどちらにも入らない。**
  Sugaku Expositions は『数学』論説の英訳版であり、**直接投稿する誌ではない**（AMS 公式ページは取得時 403、
  上記 MSJ 公式 PDF の記述で確定）。
- 補足: 読者像（非専門家にも最初の 1/3 が読める）は論文 001 の書き方と非常に近い。
  **将来 MSJ 会員となり依頼を受ける可能性はあるが、それは投稿計画にならない。**

### 3.8 Japanese Journal of Mathematics（Springer / 日本数学会）— 招待サーベイ誌

- 公式: <https://link.springer.com/journal/11537/aims-and-scope>
- 1924 年創刊。「**進んだ明快な解説（advanced and clear expositions）**」を載せ、
  最近の話題に新しい視点を与えるか、重要領域の発展を包括的に総覧する。
  「少数の専門家の輪を越えた広い数学者層」向け。日本数学会の委託により Springer が刊行。hybrid。
- **判定**: 研究サーベイ誌であり、掲載は招待（高木レクチャー等）が主。取得したページには公募の記載が無い。
  **公募投稿の可否を公式に確認できていない**ため、順位付けの対象から外した。

### 3.9 arXiv（雑誌ではない。だが最初にやるべきこと）

- 公式（分類）: <https://arxiv.org/category_taxonomy>
  - `math.NT`: 素数、ディオファントス方程式、解析的数論、代数的数論、数論幾何、ガロア理論
  - `math.LO`: 論理、集合論、点集合位相、**形式数学（formal mathematics）**
  - `math.DS`: 微分方程式と流れの力学、写像の反復、複素力学
  - `math-ph`: 物理への数学の応用、物理理論の厳密な定式化
  - `cs.LO`: 計算機科学における論理全般、**プログラム検証**
  → 論文 001 は **math.NT を primary、math.LO と math.DS をクロスリスト**が素直。
- 公式（モデレーション）: <https://info.arxiv.org/help/moderation>
  - モデレーションは**査読ではない**。フィードバックは返らない。
  - 却下事由に「**独創性の欠如（missing novelty）**」「研究でない投稿」「最近の投稿と重複」が挙がっている。
  - 分野ごとに **endorsement（推薦）** の仕組みがある。
- **注意（正直に書く）**: 論文 001 は本文冒頭で「新しい定理を主張しない」と宣言している。
  arXiv のモデレーション基準に照らすと、**この宣言のままでは却下されうる**。
  再框（reframe）が何を新しく与えるのか（辞書・決定手続き・witness・形式化）を
  abstract の水準で明示しないと通らない可能性がある。**「arXiv なら無条件に出せる」とは書かない。**

---

## 4. 推奨順位の根拠（なぜこの順か）

判定軸は §2 の 5 つ。効いたのは事実上 2 つだけだった。

1. **「新結果を主張しない」という本文の宣言が、記事種別を一意に決める。**
   Expositiones Mathematicae だけが、その種別（Survey Article）を公式に定義し、
   かつ **Main Research Article の側に「significant new results が必要」と明記**して両者を分けている。
   他の研究誌はこの分離を持たないので、同じ原稿が「新規性なし」で落ちる。これが 1 位の理由である。
2. **言語がふるいになる。** 日本語のまま出せる先は『数学』と RIMS Kôkyûroku しかなく、
   『数学』は §3.7 のとおり構造的に入らない。したがって**英訳が全候補の前提条件**になる。

順位の下げ要因:
- L'Enseignement Mathématique を 2 位に置いたのは、著者負担ゼロ・読者無料（S2O）という条件が確認できたためだが、
  **research articles の誌である**点で 1 位にはしていない。
- EMS Surveys は種別としては最適だが、**14 ページはこの誌の想定分量に対して小さい**ので 3 位。
- Jahresbericht der DMV は種別が合うが、長さ規定・公募の可否・APC を公式ページで確認できていないので 4 位。

**ルート B を「別ルート」として併記したのは、順位を付ける対象が違うからである。**
ルート B は「論文 001 をどこへ出すか」ではなく「論文 001 を書き直すか」という判断であり、
これは §6 のとおり**ユーザーの判断事項**である。

---

## 5. 一次情報を取得できなかったもの（推測で埋めない）

| 対象 | 何が取れなかったか | 理由 |
|---|---|---|
| Expositiones Mathematicae の投稿規定（guide for authors） | 投稿方法、APC 額、査読の詳細 | ScienceDirect が HTTP 403（`/about/aims-and-scope`, `/publish/guide-for-authors` とも）。§3.1 の内容は出版社ドメイン `shop.elsevier.com` から取得したもの |
| American Mathematical Monthly | 記事種別、長さ、査読、APC | maa.org・tandfonline.com とも 403。**候補として評価できなかったので順位に入れていない** |
| Experimental Mathematics | aims and scope 一式 | tandfonline.com が 403 |
| L'Enseignement Mathématique の投稿規定 | 記事種別の定義、長さ、査読手順 | `/submission`, `/submissions`, `/about` がいずれも 404 |
| EMS Surveys の投稿規定 | 公募か招待か | `/submission`, `/about` が 404。誌トップに Submit リンクはある |
| Notices of the AMS / Sugaku Expositions（AMS 公式） | 投稿要件 | ams.org が 403。Sugaku Expositions の性格は MSJ 側公式 PDF で確定させた |
| RIMS Kôkyûroku | 投稿・掲載条件、査読の有無、著者資格 | 公式ページ <https://www.kurims.kyoto-u.ac.jp/~kyodo/kokyuroku/kokyuroku.html> に記載が無かった。**研究集会の記録集**であること、日英両言語であること、ISSN 1880-2818 だけが確認できた。研究集会での講演が前提と読めるが、**確認できていないので候補として順位付けしない** |
| Algebraic Combinatorics | 著者費用の有無、言語規定、査読手順 | 公式ページに記載なし（「通常の編集・査読プロセス」とだけある） |
| Jahresbericht der DMV | 長さ規定、公募の可否、APC 額 | aims and scope ページに記載なし |

web.archive.org は本環境から取得できず（ツールが拒否）、`curl` はサンドボックスによりネットワークへ出られない。
403 の各誌は、**別のネットワーク経路（通常のブラウザ）からなら取得できる可能性が高い。**

---

## 6. ユーザーの判断が要る点（こちらでは決められない）

1. **英訳するか。** 上位 4 候補すべてが英語を要求する。英訳しないなら投稿先は事実上ゼロになる
   （『数学』は §3.7 で不可、RIMS Kôkyûroku は研究集会が前提で §5 のとおり条件未確認）。
2. **「新しい定理を主張しない」という宣言を維持するか。**
   維持するなら解説誌ルート（1〜4 位）。撤回して cycle 18 の退化塔の結果を前面に出すなら
   ルート B（Annales mathématiques du Québec / Algebraic Combinatorics / Research in Number Theory）へ変わる。
   **これは論文の性格を変える判断であり、実装判断ではない。**
3. **OA に費用を払うか。** Springer 系は購読モデルなら著者負担ゼロ、OA なら £2190–2590 相当。
   EMS 系（L'Enseignement Mathématique / EMS Surveys）は S2O で読者無料かつ著者費用の記載なし。

---

## 7. この調査で更新すべきプロジェクト側の記録

- `MEMORY.md` の「次のユーザー判断点: 論文 001 を投稿するか」は、本調査により
  **「英訳するか／新規性の宣言を維持するか」という 2 つの判断へ具体化された。**
- 付随して直したもの: `structured-latex/tools/build-latex.ts` のプリアンブルに `⇒`（U+21D2）の
  文字クラス指定を追加した。**追加前は PDF ビルドが「組めない文字」で失敗し、ページ数を実測できなかった。**
  本文（content）は書き換えていない（表示の問題は生成器の責務、という既存方針どおり）。
