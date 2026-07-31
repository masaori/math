# 論文 001 英訳の用語集・文体方針（訳語の正本）

対象: `integrable-lattice/structured-latex-en/`（英語版）
正本の日本語: `integrable-lattice/structured-latex/content/*.ts`（全 7 ファイル・33 ブロック）
作成日: 2026-08-01

**この文書は訳語の正本である。** 英訳するエージェントは、ここに載っている語を別の語で訳してはならない。
ここに無い語で訳を迷ったら、この表へ追記してから訳す（後続が同じ語を別訳にしないため）。

## 0. 根拠についての約束（読む前に）

「根拠」欄には、**このセッションで実際に確認した一次情報だけ**を書く。
確認できていないものは「未確認」と明記した。**未確認を推測で埋めていない。**

このセッションで確認できた一次情報は、次の 2 つに限られる。

- `integrable-lattice/structured-latex/content/*.ts`（日本語の本文。用語の実際の用法）
- `integrable-lattice/outputs/papers/001_R_Lambda_duality/refs.bib`（本論文が引く文献の**表題**。
  表題は書誌データとして確認済みであり、その表題に現れる英語表現は「この分野で実際に使われている形」である）

英語圏の教科書・辞書・MSC 分類表は、この環境からは取得できなかった（ネットワークへ出られない）。
したがって「標準的な教科書の用法である」という形の根拠は書いていない。

---

## 1. 対訳表

### 1.1 本論文の枠組みに固有の語（このプロジェクトの造語を含む）

| 日本語 | 英語 | 根拠 |
|---|---|---|
| 整数スペクトル曲線 | **integer spectral curve** | 本プロジェクトの造語。`content/002_setup.ts` の定義は「整数係数の Laurent 多項式 $P$」であり、"curve" は $P=0$ の零点集合を指す慣用。逐語訳を採り、初出時に定義を必ず添える（造語なので読者は知らない） |
| 周期点数 | **number of periodic points**（記号は $a_L$） | refs.bib の Lind–Schmidt–Verbitskiy の表題が "…, and periodic points of algebraic $\mathbb{Z}^d$-actions" であり、この分野の語が "periodic points" であることを表題で確認した |
| 簡約周期点数 | **reduced number of periodic points**（記号は $a^{\mathrm{red}}_L$） | 上の派生。`content/002_setup.ts` の定義（トーラス上の零点を除いた積）に対応する "reduced" |
| 対数順序群 Λ | **the logarithmic ordered group $\Lambda$** | 本プロジェクトの造語（`content/001_intro.ts` で $\Lambda=\bigoplus_p\mathbb{Z}\ell_p$ と定義される）。逐語訳。**"logarithmic order group" とはしない**（順序群 = ordered group が既成の語であるため） |
| 決定可能性の梯子 | **the ladder of decidability** | 本プロジェクトの造語（$\mathbb{N}\subset\mathbb{Z}\subset\mathbb{Q}\subset\Lambda\subset\overline{\mathbb{Q}}\subset\mathbb{R}$ の階層）。"hierarchy" ではなく "ladder" を採るのは、日本語が「段」を数える比喩で書かれており（`content/001_intro.ts`「決定不能な段」）、hierarchy にすると段の比喩が消えるため |
| 帰属（軸 1） | **membership** | `content/001_intro.ts` の定義は「対象量がどの集合に住むか」。集合論の "membership"（$\in$）そのもの |
| 計算可能性（軸 2） | **computability** | 標準語。`content/001_intro.ts` の用法（「有限・離散なら常に計算可能」）と一致 |
| 複雑性（軸 3） | **complexity** | 標準語。`content/001_intro.ts` の用法は「多項式時間か #P 困難か」＝計算複雑性。**注意**: 下の「全域木数」の項に、グラフ理論では complexity が別義で使われることを書いた。同一段落で両方を使わないこと |
| 可解性（軸 4） | **solvability** | `content/001_intro.ts` の定義は「熱力学極限に閉形式があるか」。統計力学の "exactly solvable" と同語根で選んだ。**未確認**（この訳語が可積分系の文献で標準かどうかは、本セッションでは一次情報を取得できていない） |
| 四軸 | **the four axes**（membership / computability / complexity / solvability） | 上の 4 語の総称。初出で 4 つを並べて示すこと |
| 住処（habitat） | **habitat** | 本プロジェクトの造語で、`structured-latex/schema.ts` の必須フィールド名がそのまま `habitat` である。**生成器が PDF に "Habitat:" と印字する**ので、本文の語もこれに揃える |
| ℝ 脱出 | **escape to $\mathbb{R}$** | 本プロジェクトの造語。`structured-latex/schema.ts` のフィールド名が `realEscape`、生成器の印字が "Escape to $\mathbb{R}$"。本文の語もこれに揃える |
| 再框（reframe） | **reframing**（動詞は reframe） | `content/001_intro.ts` が日本語の「再框」に括弧書きで "reframe" を併記している。すなわち**日本語版自身が英語表現を指定している**ので、それに従う |
| witness | **witness** | 日本語版が既に英語のまま使っている（`content/001_intro.ts`「具体的な決定手続きと witness をもつ命題」）。論理学・計算機科学の標準語 |
| 形式検証 | **formal verification**（Lean での作業は **formalisation**） | 標準語。refs.bib の Journal of Automated Reasoning の項に対応。本文では「Lean で形式化した」＝ "formalised in Lean" と「形式検証の到達点」＝ "what the formal verification achieves" を訳し分けること |

### 1.2 数論・力学系の語

| 日本語 | 英語 | 根拠 |
|---|---|---|
| Massieu 自由エントロピー | **Massieu free entropy** | 熱力学の Massieu 関数（Massieu potential）に由来する語。`content/002_setup.ts` の定義は $\Phi_N=\log Z_N(q)$ で、Massieu 関数の定義形と一致する。**未確認**（"Massieu free entropy" という語の標準性は、本セッションでは一次情報を取得できていない。造語に近い可能性があるので、初出で定義式を必ず添えること） |
| Mahler 測度 | **Mahler measure** | refs.bib の Lind–Schmidt–Ward の表題 "Mahler measure and entropy for commuting automorphisms of compact groups" で確認 |
| アルキメデス素点 | **the archimedean place** | 標準語（$p$ 進の "finite place" に対する "infinite/archimedean place"）。**小文字で書く**（Archimedes に由来するが、この語は慣用的に小文字） |
| 二素点 | **the two places** | 本プロジェクトの言い方（`content/005_duality.ts` 「同一の整数曲線の二素点」）。英語では "two places"（アルキメデス素点と $p$ 進素点）と書き、**"two primes" とはしない**（prime は素数と紛れる） |
| 終結式 | **resultant** | 標準語。`content/002_setup.ts` が既に記号 $\mathrm{Res}$ を使っている |
| 最終周期性 / 最終周期的 | **eventual periodicity** / **eventually periodic** | 標準語。`content/004_lambda_finite.ts` の定義（ある番号から先で周期的）と一致 |
| トレース列の周期 | **the period of the trace sequence**（記号 $\pi_{\mathrm{tr}}$） | 本文が定義する量。**行列冪列の周期 $\pi$（the period of the matrix power sequence）と絶対に混同しないこと。**`content/004_lambda_finite.ts` は「以前の版が 2 つを同じ記号で書いたため主張が偽になった」と本文に明記している。英訳でも両者を毎回言い分ける |
| Newton 多角形 | **Newton polygon** | 標準語。**"polygon" であって "polyhedron" ではない**（1 変数の特性多項式に対する 2 次元の下方凸包） |
| 最小傾き | **minimal slope** | `content/004_lambda_finite.ts` は「向きの規約」を本文で明示している。英訳でもこの規約の段落を落とさないこと（向きを変えると符号が反転する） |
| 全域木数 | **number of spanning trees** | refs.bib の Mednykh–Mednykh の表題 "Complexity of the circulant foliation over a graph" が、この量を **complexity** と呼ぶグラフ理論の慣用を示している。**本論文では "complexity" を使わない**（軸 3 の計算複雑性と衝突するため）。必要なら初出で「グラフ理論ではこの量を complexity とも呼ぶ」と一度だけ注記する |
| グラフ塔 | **tower of graphs**（$\mathbb{Z}_\ell^d$ 塔は **$\mathbb{Z}_\ell^d$-tower of graphs**） | refs.bib の DuBose–Vallières の表題 "On $\mathbb{Z}_\ell^d$-towers of graphs"、Vallières の "On abelian $\ell$-towers of multigraphs" で確認 |
| （塔が）非退化 / 退化 | **non-degenerate** / **degenerate** | 標準語。ハイフンつきの **non-degenerate** に統一する（nondegenerate と混在させない） |
| 消滅深度 | **vanishing depth**（記号 $\theta$） | 本プロジェクトの造語（`content/005_duality.ts` の (G6)）。逐語訳。初出で定義を必ず添える |
| 単因子 | **elementary divisor** | 標準語。`content/004_lambda_finite.ts` は Smith 標準形の最後の対角成分としてこれを使う。**Smith normal form** と併記すると読者が確実に分かる |
| 岩澤型漸近公式 | **Iwasawa-type asymptotic formula** | refs.bib の Kataoka の表題 "An Iwasawa-type asymptotic formula for multiple $\mathbb{Z}_p$-coverings of graphs" で確認 |
| Lehmer 問題 | **Lehmer's problem** | refs.bib の Lehmer 1933 の項。所有格の 's を付ける（Lehmer problem としない） |
| 決定可能 / 決定不能 | **decidable** / **undecidable** | refs.bib の Ax–Kochen の表題 "Diophantine problems over local fields III: Decidable fields" で確認 |
| 決定手続き | **decision procedure** | 標準語。上の decidable と対で使う |

### 1.2b 第 1〜3 章の英訳で新たに確定した語

第 1 章（梯子・四軸）・第 2 章（設定）・第 3 章（アルキメデス素点側）を訳す過程で必要になり、
上の表に無かった語である。根拠欄の約束は §0 と同じ（このセッションで確認した一次情報だけを書く）。

| 日本語 | 英語 | 根拠 |
|---|---|---|
| 分配関数 / 分配多項式 | **partition function** / **partition polynomial** | 統計力学の標準語。`content/002_setup.ts` の $Z_N(x)\in\mathbb{Z}[x]$ は多項式なので、後者は "partition polynomial" と訳し分ける |
| 多重度 | **multiplicity** | 標準語。`content/002_setup.ts` の $\Omega_N(m)\in\mathbb{N}$（状態数の重み）に対応 |
| 転送行列 | **transfer matrix** | 標準語 |
| 分配関数零点 | **the zeros of the partition function** | 標準語（Lee–Yang 零点の一般形）。**"partition zeros" と縮めない** |
| 位相的エントロピー | **topological entropy** | refs.bib の Lind–Schmidt–Ward の表題 "…entropy for commuting automorphisms of compact groups" が entropy の語を確認する。"topological" は `content/003_archimedean.ts` の本文が明示している修飾 |
| expansive（な作用） | **expansive** | 日本語版が既に英語のまま使っている（`content/003_archimedean.ts`「expansive な作用」）。訳さない |
| atoral | **atoral** | 同上。日本語版が英語のまま使っており、refs.bib の Lind–Schmidt–Verbitskiy の表題 "…, atoral polynomials, …" で確認した |
| 複素単位トーラス | **the complex unit torus** | `content/003_archimedean.ts` の $\mathsf U(P)=\{z\in\mathbb{S}^d:P(z)=0\}$ の定義域。逐語訳 |
| 周期成分の個数 | **the number of periodic components** | Lind–Schmidt–Verbitskiy の $\mathsf P_\Gamma$ を指す本文の説明。**「周期点数」(number of periodic points) と必ず言い分ける**（`content/003_archimedean.ts` は両者が因子 $c_\Gamma(f)$ だけずれることを本文で明示しており、訳で混ぜると規約の差の段落が意味を失う） |
| 増大率 | **growth rate** | 標準語。`content/003_archimedean.ts`「周期点の増大率」＝ "the growth rate of the periodic points" |
| 1 の冪根 | **root of unity** | 標準語 |
| 単項式倍 | **multiplication by a monomial** | `content/002_setup.ts` の「単項式倍は $a_L$ を変えない」。**"monomial multiple" と名詞化しない**（本文は操作を述べている） |
| Galois 不変な代数的整数 | **Galois-invariant algebraic integer** | 標準語。ハイフンつきの **Galois-invariant** に統一する |
| 入れ子の終結式 | **nested resultant**（動詞は "nest the resultant"） | `content/002_setup.ts` の $\mathrm{Res}_z(\dots,\mathrm{Res}_w(\dots))$ の形をそのまま指す。逐語訳 |
| モニック | **monic** | 標準語 |
| 素因数分解 / 指数ベクトル | **prime factorisation** / **exponent vector** | 綴りは §2.5 の英綴り（-isation）に従う。$\Lambda$ の等号・順序の定義で対にして使う |
| 有限手続きで決定できる | **is settled by a finite procedure** / **is determined by a finite procedure** | `content/001_intro.ts`・`002_setup.ts` の言い方。**"can be decided" は §1.2 の decidable と衝突しやすいので、量を求める場面では determine を使う** |
| 熱力学極限 | **the thermodynamic limit** | 標準語 |
| 閉形式 | **closed form** | 標準語。「閉形式をもつ」＝ "admits a closed form" |
| 自由フェルミオン | **free fermions** | 標準語 |
| Yang–Baxter | **the Yang–Baxter equation** | 標準語。日本語版は「Yang–Baxter」とだけ書くが、英語では equation を補わないと名詞句にならない |
| #P 困難 | **#P-hard** | 標準語 |
| 妥当性検査 | **sanity check** | `content/003_archimedean.ts`「枠組みの妥当性検査としてのみ使い」＝ "only as a sanity check on the framework"。**"validity check" にしない**（本文の含意は「枠組みが壊れていないことの確認」であって、正当性の証明ではない） |
| 全域木エントロピー | **spanning-tree entropy** | §1.2 の「全域木数 = number of spanning trees」の派生。**ここでも complexity を使わない**（軸 3 と衝突するため） |
| Catalan 定数 | **Catalan's constant** | 標準語。所有格の 's を付ける |
| 自由エネルギー密度 | **the free energy density** | 標準語。`content/001_intro.ts` の既訳が既にこの形である |
| 住処（英訳の言い回し） | **the habitat of $X$ is …** / **$X$ lives in …** | §1.1 の habitat の使い方。`content/002_setup.ts`「各量の住処は次のとおり」＝ "The habitats of the quantities involved are as follows" |

### 1.2c 第 4 章（命題 A・B・C・C′・N・L）の英訳で確定させた語

| 日本語 | 英語 | 根拠 |
|---|---|---|
| 切断（$p^k$ の $k$） | **truncation level** | `content/004_lambda_finite.ts` の用法（$\min(v_p(Z_N),k)$ の $k$）。「$p^k$ で打ち切る水準」であり、cut / truncation のうち水準を表す語を選んだ |
| 基準レベル | **base level** | 同ファイル 命題 C′ の「基準レベルを 1 のままにした補正は不可能である」。上界 $\pi_{\mathrm{tr}}(p,k)\mid p^{k-1}\pi_{\mathrm{tr}}(p,w^*+1)$ の右辺で参照される水準 $w^*+1$ を指す。**level だけにしない**（truncation level と紛れる） |
| 鳩の巣原理 | **the pigeonhole principle** | 標準語。命題 A の証明で使う |
| 指標の一次独立性（Artin） | **Artin's linear independence of characters** | 標準語。命題 B の証明で使う |
| 同伴行列 | **companion matrix** | 標準語。命題 C・C′ で使う |
| 根基（$\rho=\prod_i f_i$） | **the radical** | 命題 C′ の定義そのもの。初出で定義式を添える |
| Gram 行列 | **Gram matrix** | 標準語。命題 C′ の $G=(\operatorname{Tr}T^{i+j})$ |
| 上界 | **upper bound** | 標準語。「上界が破れる」は **the bound fails**（"is broken" にしない） |
| 例外集合 | **the exceptional set** | 命題 N。Skolem–Mahler–Lech 型の相殺で等号が崩れる $N$ の集合 |
| 相殺 | **cancellation** | 命題 N。"cancellation of Skolem–Mahler–Lech type" |
| 方法論上の注記 | **a methodological note** | 命題 C。0 件の観察を根拠にしてはならない、という教訓の見出し |
| 反例が破れる／等号が破れる | **equality fails** | 命題 C。「$X$ 例中 $Y$ 例で破れた」は "equality failed for $Y$ out of $X$ examples" |
| lifting-the-exponent（LTE） | **lifting the exponent (LTE)** | 命題 L。標準語（略号は本文でも LTE のまま） |

**記号の書き方（実測に基づく制約。推測ではない）**: 命題 C′ / C″ の**プライムは ASCII の `'` で書く**
（`Proposition C'` / `Proposition C''`）。**U+2032 `′` を地の文・タイトルへ書くと英語版の PDF から
無言で消える**（2026-08-01 に `structured-latex-en` で実測。`build:pdf` の「組めない文字」検査が
`′` を検出してビルドが落ちた。英語版は和文フォントを読み込まないため落とし先が無い）。
数式ノードの中では `^{\prime}` を使えるが、**日本語版の数式は 1 文字も変えられない**ので、
この制約は地の文とタイトルにのみ関わる。

### 1.3 訳し分けに注意する語

| 日本語 | 英語 | 注意 |
|---|---|---|
| 命題 A・B・… | **Proposition A, B, …** | 本文の環境は `theorem`（生成器が "Theorem" と印字する）だが、**本文中で参照するときの呼称は Proposition のまま**である（日本語版が「命題 A」と呼んでおり、記号 A・B・C・C′・N・L・D・F・G・T・V・W は本論文の内部ラベルだから）。相互参照は `ref()` が `\cref` を出すので "Theorem 4.1" のように出る。この二重呼称は日本語版と同じ状態であり、**英訳で勝手に統一しない**（後続の判断事項として §3 に挙げた） |
| 既知 | **known** | 「既知定理である」＝ "is a known theorem"。**"well-known" にしない**（本文は出典を命題番号で特定しており、well-known はその特定を弱める） |
| 既出性 | **prior art** | `content/006`・`007` の「既出性の調査結果」＝ "the result of the prior-art check" |
| 新規性を主張しない | **claims no novelty** | 本論文の中心的な宣言。`content/001_intro.ts` の "**新しい定理・新しい厳密解・新しい深い数論を一切主張しない**" を弱めても強めてもならない |
| 射程外 | **out of scope** | 標準語 |
| 但し書き / caveat | **caveat** | 日本語版が `content/004_lambda_finite.ts` で既に "caveat" を使っている |
| 限界 | **limitation** | `content/005_duality.ts`「命題 D に残る限界」＝ "the limitations that remain in Proposition D" |

---

## 2. 文体の方針

### 2.1 読者像（Expositiones Mathematicae の Survey Article）

同誌の公式サイト（`shop.elsevier.com`、2026-08-01 取得。調査は
`outputs/reports/paper001_submission_venue_survey.md` §3.1）が Survey Article を
**「研究を始めた学生や、その話題の専門家でない数学者が読んで得るところがあるように書かれた、
現代の研究についての解説」**と定義している。したがって:

- **どの分野の読者も専門家ではない前提で書く。** 本論文は数論・数理論理・力学系・統計力学・
  形式検証にまたがる。ある章の読者は他の章の分野の専門家ではない。分野固有の記号は初出で説明する。
- **造語（§1.1）は初出で必ず定義する。** integer spectral curve / logarithmic ordered group /
  ladder of decidability / habitat / escape to $\mathbb{R}$ / vanishing depth は、読者が知らない語である。
- 採否の基準として同誌が挙げているのは「**解説の明快さ・細部の正確さ**・研究結果の質・
  主題の関連性と興味深さ」である。**明快さと正確さの両方が採否に効く。**

### 2.2 時制

- 既知定理の内容を述べる: **現在形**（"Lind–Schmidt–Ward show that the entropy equals $\log m(P)$."）。
- この論文が何をするか: **現在形**（"We place the two quantities side by side."）。
  **"we will" を使わない**（数学論文の慣用は現在形）。
- この論文の作業として既に済んだこと（計算・形式化・文献確認）: **現在完了形**
  （"We have checked mechanically that the formalisation is free of `sorry`."）。
- 反例が見つかった等の観察の報告: **過去形**（"The hypothesis was refuted by 26 counterexamples."）。

### 2.3 人称

- **一人称複数 "we" を使う**（単著でも数学論文の慣用）。"the author" を使わない。
- **受動態への逃げを常用しない。** 誰が何をしたか（この論文が主張するのか、引用元が主張するのか）が
  読者に分かることが、この論文では特に重要である（本論文は「新規性を主張しない」ことを中心に据えている）。
  引用元の主張は "Monsky proves…"、本論文の作業は "We identify…" と主語を書き分ける。

### 2.4 定理の言い回し

- 環境の見出し語は生成器が出す（Definition / Claim / Theorem / Remark / Note）。**本文中で
  "Theorem 4.1 states that…" のように書かず、`ref()` を使う**（相互参照は `\cref` が採番して出す）。
- 仮定は文頭に置く: "Let $P\in\mathbb{Z}[z_1^{\pm1},\dots,z_d^{\pm1}]$ be nonzero." の形。
  日本語の「$P$ を〜とする」をそのまま "We set $P$ as…" と訳さない。
- 「〜が成り立つ」は **"holds"**。「〜が従う」は **"follows"**。「〜と同値である」は
  **"is equivalent to"**（"iff" は本文では使わず、数式の中でのみ許す）。
- 「一般には成立しない」は **"does not hold in general"**。
  **"is not always true" にしない**（本文は反例を具体的に挙げているので、より強い形が正しい）。

### 2.5 綴りの統一

- **イギリス綴りに統一する**（-ise / -isation）: formalisation, countabilisation, factorisation,
  characterise。同誌はドイツ発の誌で英綴りの投稿が通常であるが、**同誌の綴り指定は確認できていない**
  （Guide for Authors が ScienceDirect の 403 で取得できない）。**統一されていることが重要**であり、
  どちらに統一するかは編集部が直す範囲である。混在だけは避ける。

### 2.6 強調の書き方

日本語版の本文は強調を `**…**` と書いている。英語版の生成器はこれを `\textbf{…}` へ落とす
（日本語版はアスタリスクがそのまま PDF に出ている。英語版で直した）。したがって:

- 強調は **1 つのノードの中で開いて閉じる**。ノードをまたぐ `**` はビルドが落ちる（意図的な設計）。
- 強調は日本語版と同じ箇所に置く（強調の有無は主張の強さに関わる）。

---

## 3. 後続が判断する必要がある点（訳語では決まらない）

1. **「命題 A」の呼称**（§1.3）。生成器は Theorem 環境で組むので、本文で "Proposition A" と呼ぶと
   PDF 上は "Theorem 4.1 (Proposition A)" のような二重呼称になる。日本語版も同じ状態である。
   統一するなら生成器か本文のどちらかを変える必要があり、**内容の変更を伴うので独断で変えない**。
2. **要旨・表題・キーワード・MSC 2020**（`structured-latex-en/frontmatter.ts`）。
   現在の値はすべて暫定であり、MSC の番号は一次情報と照合していない。
3. **数式の中に日本語が入っているブロックが 1 つある**（第 1〜3 章の英訳で検出）。
   `paper_012_definition_ladder`（決定可能性の梯子）の `displayMath` が
   `\underbrace{...}_{\text{無条件に決定可能}}`、`\text{の非線形部}`、`\text{Schanuel 条件付き}`、
   `\text{決定不能}` を含む。英語版は和文フォントを読み込まないため、**このままでは
   `npm run build:pdf` が「PDF に組めない文字がある」で落ちる**（実測）。
   これは訳語の問題ではなく、**数式を書き換えるか対応検証の例外表へ登録するかという構成の判断**なので、
   翻訳担当は独断で直していない。選択肢は 2 つ:
   (a) `\text{}` の中身を英訳し、`structured-latex-en/tools/ja-en-exceptions.ts` へ
   `paper_012_definition_ladder` を理由つきで登録する（数式の多重集合が 1 件だけずれるため）。
   (b) 日本語版側で `\text{}` を記号・番号へ書き換える（**日本語版は正本なので独断で変更しない**）。
   なお `\text{}` の中身を英訳すれば PDF が通ることは実測で確認済み（4 ページ、組めない文字 0 件）。
4. **命題 B（`paper_042_theorem_pi_p1`）の別行立て数式にも日本語が入っている**（上と同じ種類の問題。第 4 章の英訳で検出）。
   日本語版の tex がそのまま `\text{は }\chi_T\bmod p\text{ の相異なる根}` を含むため、
   英語版でも同じ文字列を持っている（数式は 1 文字も変えない規約のため訳者は触っていない）。
   **この 1 箇所のせいで英語版の `npm run build:pdf` が落ちる**（英語版は和文フォントを
   読み込まないので「組めない文字」検査が `は・の・相・異・な・る・根` を検出する）。
   直すには数式を英語へ変え（例: `\text{ is a distinct root of }\chi_T\bmod p`）、
   その差を `structured-latex-en/tools/ja-en-exceptions.ts` へ理由つきで登録する必要がある。
   **数式の改変と共有ファイルの編集はどちらも訳者の権限を超えるので、統合側が判断する。**
   実測: この 1 箇所を英語へ差し替えた状態では PDF が 6 ページで通り、
   組めない文字 0 件・未解決参照 0 件・版面外の行 0 件だった。
