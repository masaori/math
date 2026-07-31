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

### 1.2d 第 4 章に後から増えた 2 ブロック（命題 C''・命題 W*）の英訳で確定させた語

日本語版 `content/004_lambda_finite.ts` の `paper_045_theorem_trace_ladder`（命題 C″）と
`paper_046_theorem_wstar_different`（命題 W*）を訳す際に決めた語である。
根拠欄の約束は §0 と同じ（このセッションで確認した一次情報だけを書く）。

| 日本語 | 英語 | 根拠 |
|---|---|---|
| （周期の）階段 | **ladder** | 命題 C″ の中心語（$t_{k+1}\mid p\,t_k$ で 1 段ずつ上がる比喩）。§1.1 の「決定可能性の梯子 = ladder of decidability」と同じ語を充てる。**staircase としない**（本論文はすでに段を数える比喩を ladder で通している）。「階段が 1 段止まる」＝ **the ladder stalls for one step** |
| しきい値 | **threshold** | 命題 C″ の $w^*+1$ / $2w^*+1$。標準語 |
| 最良である | **best possible** | 命題 C″「しきい値 $w^*+1$ は最良である」。**optimal としない**（本文は「これ以上下げられない」という否定形の主張であり、best possible がその形を保つ） |
| 閉形式の不存在 | **the absence of a closed form** | 命題 C″ の表題。§1.2b の「閉形式 = closed form」の派生。**"no closed form is known" にしない**（本文は反例で不存在を示しており、既知性の話ではない） |
| アフィン式 | **an affine expression** | 命題 C″「$e_k$ を $k$ のアフィン式 $k-c$ で書くことはできない」 |
| Wieferich 型の量 | **a quantity of Wieferich type** | 命題 C″。§1.2c の「Wall 型」と同じ "of … type" の形に揃えた |
| Wall 型等式 | **the identity of Wall type** | 既訳の `paper_043_theorem_bound` が「Wall 型の等号」を "equality (of Wall type)" と訳している。命題 C″ の $g_{m+1}=g_m+1$ は等式なので identity を使う |
| トレース直交性 | **trace orthogonality** | 命題 C″ の証明。$\operatorname{Tr}(xB)\equiv0$ を指す本文の言い方 |
| トレース双対 | **the trace dual** | 命題 W* の表題。$A^{\vee}=\rho'(\theta)^{-1}A$ を指す |
| 微分（命題 W* の表題） | **the derivative** | 命題 W* の表題「トレース双対と微分」。構成に現れるのは導関数 $\chi'$・$\rho'$ なので derivative と訳した。**下の「差積」と必ず訳し分ける**（同じブロックの証明に「差積指数」が別語として出る） |
| 差積（指数） | **the different (the different exponent)** | 命題 W* の証明「$d_{\mathfrak p}$ は差積指数」。Dedekind の different。**derivative と混ぜない** |
| 分岐指数 | **ramification index** | 標準語。命題 W* の $e_{\mathfrak p}$ |
| 従順分岐 | **tamely ramified** | 標準語。命題 W*「従順分岐なら $\lceil d_{\mathfrak p}/e_{\mathfrak p}\rceil\le1$」 |
| $p$ 極大 | **$p$-maximal** | 命題 W* の仮定（$A$ が $p$ において極大位数であること） |
| 重複度（$\chi=\prod f_i^{a_i}$ の $a_i$） | **multiplicity** | §1.2b の「多重度 = multiplicity」と同語。文脈が違うだけなので語を分けない |
| 双対基底公式（Euler の） | **Euler's dual basis formula** | 命題 W* の証明。所有格の 's を付ける（§1.2 の Lehmer's problem と同じ扱い） |
| 分離的 | **separable** | 標準語 |
| 余核 | **cokernel** | 標準語。記号は本文どおり $\operatorname{coker}$ |

**強調が数式をまたぐ箇所の扱い（命題 C″ の証明）**: 日本語版は
「**要点は、2 個以上ある $B$ のうち 1 個を…**」と、`**` の中に数式ノードを含めて書いている。
英語版の生成器はノードをまたぐ `**` を拒否する（§1.5）ので、
**強調文を数式なしで言い切り、その直後に記号を対応づける文を置いた**
（"…used as a power of the prime.**" のあとに "The factors in question are the copies of $B$, and the
prime is $p$." を続ける）。数式ノードの多重集合は日本語版と一致させてある。

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

### 1.4 第 6〜8 章（命題 T・V・W／決定可能性の非対称／スコープと限界）で追記した語

既出性の記述が集中する章なので、**主張の強さを変えない定型表現**をここで固定する。
後続はこの言い回しを別の語で言い換えてはならない（強めても弱めてもならない）。

| 日本語 | 英語 | 根拠・注意 |
|---|---|---|
| 調べた範囲では見つからなかった | **we could not find … in the literature we searched** | 「無い」ではなく「見つけられなかった」。**"there is no …" / "this is new" にしない**（`content/006`・`007` はこの区別を本文で明示している） |
| 無いとは言わない | **we do not claim that it does not exist** | 上とセットで必ず添える。落とすと主張が強まる |
| （原文・本文を）確認した | **we have checked … against the original text** / **we have read the text of …** | 現在完了（§2.2 の「済んだ作業」）。二次情報での確認と区別するための語なので落とさない |
| 既出である / 既出性 | **already appears in the literature** / **prior art**（§1.3） | 「既出」は "already appears in the literature"。**"is well known" にしない**（§1.3 の「既知」と同じ理由） |
| 本命題の差分 | **the only difference in the present proposition** | 差分が 1 点に限られる、という主張の形を保つ |
| その強化として位置づく | **is to be read as a strengthening of** | 「上位互換」等に言い換えない |
| 自認している | **acknowledges** | DuBose–Vallières が数値フィットであると自認している箇所（`content/006`） |
| 明記している | **states explicitly** | Kataoka が「本論文では追わない」と明記している箇所（`content/006`） |
| 形式化の範囲 | **scope of the formalisation** | 何を形式化し、何を形式化していないかの宣言。**未形式化の記述を落とさない** |
| 形式化していない | **is not formalised** | 理由（mathlib に無い／配線が要る）を必ず添える |
| 桁落ちする | **loses significance** | 浮動小数点で誤った結論が出るという注意（`content/006` の命題 T） |
| 厳密整数計算 | **exact integer computation** | 上と対で使う |
| voltage 割り当て | **voltage assignment** | refs.bib の Vallières／DuBose–Vallières の系列で使われる標準語 |
| 多重グラフ | **multigraph** | refs.bib の Vallières の表題 "…of multigraphs" で確認 |
| 単数（環の可逆元） | **unit** | 命題 T の証明。数の「単数」ではなく環の可逆元 |
| 不分岐 | **unramified** | 標準語 |
| 最低次斉次部分 | **lowest-degree homogeneous part** | 命題 W の ",H" の定義 |
| 有理零点 | **rational zero** | ",\mathbb{P}^1(\mathbb{F}_\ell)" 上の零点 |
| 地図（である、新しい定理ではない） | **a map** | 第 7 章の中心語。"framework" / "theory" に格上げしない（主張が強まる） |
| 注意（〜を〜と呼ばない） | **a caution (we do not call … a connection)** | スケールの偶然一致を接続と呼ばないという注意（第 7 章）。落とさない |
| 切断（付値体の言語） | **cross-section** | Ax–Kochen / Ershov の「正規化された切断つき」＝ "with a normalised cross-section" |
| 急収束 Cauchy 列 | **rapidly converging Cauchy sequence** | 逆数学の実数符号化 |
| 逆数学 / 構成的代数 | **reverse mathematics** / **constructive algebra** | 標準語 |
| 確立した標準手法 | **an established, standard technique** | 「可算符号で扱う」移動が標準であることの記述。弱めない |
| 残る未解決点 | **the open points that remain** | 第 8 章。「今後の課題」等に言い換えない |

**内部パスの扱い**: 本文がリポジトリ内部のパス（`lean/README.md` 等）を指している箇所は、
地の文なら "a table in the accompanying Lean development" のように言い換えてパス文字列を出さない。
ただし**日本語版が `math` ノード（`\texttt{...}`）で書いている箇所は数式の一致検査に掛かるので、
勝手に変えてはならない**（`paper_082_remark_formalization` が該当。呼び出し元の判断事項）。
### 1.4 第 5 章（命題 D・F・G と限界）で確定させた語

`content/005_duality.ts` の英訳で新たに訳語を決めた語。根拠は原則として
**日本語版本文の用法**（このセッションで確認できた一次情報）である。

| 日本語 | 英語 | 根拠 |
|---|---|---|
| 規約（$\mathrm{ord}\,0=0$ など） | **convention** | 標準語。Cuoco–Monsky p.237 の「通常とは異なる規約」を指す語であり、rule でも agreement でもない |
| 但し書き（命題 D の証明中） | **caveat** | §1.3 の既定に従った（`content/004` が既に "caveat" を使っている） |
| 補正（項）$\Delta$ | **correction (term)** | `content/005_duality.ts` (G1) の用法（定数項に付く有限和）。adjustment としない |
| ずれ指数 $\delta$ | **discrepancy exponent** | 本プロジェクトの造語。(G1′) の定義（$\min(\cdot)-k$）は「ずれ」の量なので discrepancy を採る。**同じ「ずれ」でも (ii) の「付値のずれ」は discrepancy of the valuation** と訳し、両者で語を揃えた |
| 退化点 / 退化方向 | **degenerate point** / **degenerate direction** | §1.2 の non-degenerate / degenerate の派生 |
| 帯（$\mathrm{Band}_n$） | **band** | 記号 `\mathrm{Band}` がそのまま英語である |
| 単項式正規化 | **monomial normalisation** | (G6) の $\tilde E$ の作り方の説明。英綴り（§2.5） |
| 型 II（の判定条件） | **type II** (criterion for type II) | 本文の分類名。そのまま |
| 素朴なレシピ | **naive recipe** | (F1) の用法。**「上限しか与えない」ことの主語**なので、method でも approach でもなく recipe を保つ |
| 停止問題（に還元される） | **the halting problem** (reduces to) | 標準語。(F2) の決定不能性の根拠 |
| 照合（する／済み） | **collation** / **collate** | (G) の証明の「照合の状況」。verification は `verification` フィールド（SageMath 検証）と衝突するので使わない |
| パラメータ 0 個の予言 | **a prediction with zero free parameters** | (G) の証明の言い回し。「自由パラメータが 0 個」の意なので free を補った |
| 残る限界 / 残る（未解決） | **what remains beyond reach** / **remains open** | §1.3 の limitation と対。「依然として未解決」は **still unresolved** |
| 既出性（(G4) の） | **prior art** | §1.3 の既定に従った |

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

### 1.4 フロントマターと「先行研究との関係」の節で使った語（2026-08-01 追記）

`structured-latex-en/frontmatter.ts`（要旨）と `content/008_prior_art.ts`（先行研究の節）、
`content/001a_reader_guide.ts`（Survey としての枠づけ）を書いた際に確定させた語。
**後続はここにある語を別の語で訳さないこと。**

| 日本語 | 英語 | 根拠・注意 |
|---|---|---|
| 本論文 | **this paper** | 既定はこれ（既訳 `001_intro.ts` が "This paper is a reframing…" と書いており、そこに合わせる）。**"this survey" は、記事種別としてのサーベイそれ自体が主語のときだけ**使う（「この解説が何を概観するか」を述べる箇所と要旨）。両者を無差別に混ぜない |
| （記事種別としての）解説・概観 | **survey** | Expositiones の記事種別 Survey Article の語。「何を概観として与えるか」＝ "what this survey gives an overview of" |
| 概観する | **give an overview of** | "overview" は名詞で使う。"to survey" という動詞は使わない（記事種別の名詞 survey と紛れる） |
| おおむね既出 | **broadly known** | `outputs/reports/cycle17_T1_prior_art_check.md` §0 の判定「おおむね既出」。**"mostly not new" のような否定形にしない**（判定を強めても弱めてもならない） |
| 調べた範囲では見つからなかった | **we did not find** | **これ以上の意味にしてはならない。** "there is no…"、"this is new"、"to the best of our knowledge"（網羅を含意する）へ言い換えることを禁じる。本論文は 0 件を新規性の根拠にしない |
| 先行研究との関係 | **relation to the literature** | 節の見出し。§1.3 の「既出性 ＝ prior art」と併用してよい（節見出しは前者、調査そのものは後者） |
| 逆数学 | **reverse mathematics** | §1.3 の既出の用法どおり。標準語 |
| 可算符号 | **countable code**（符号化する＝**to code**） | 逆数学の標準語。SEP の記述（実数を急収束 Cauchy 列で符号化する）に対応 |
| 急収束 Cauchy 列 | **rapidly converging Cauchy sequence** | 同上 |
| 完備可分距離空間 | **complete separable metric space** | 標準語 |
| 構成的代数 | **constructive algebra** | Alonso García–Lombardi–Perdry の枠組みを指す |
| Henselization | **Henselisation** | **-ise に統一する**（§2.5 の英綴り規則。原論文の表題は "Henselian local rings" なので、**表題を引用するときは原綴りのまま**にする） |
| 数値フィット | **a fit**（「フィットであって証明ではない」＝ **a fit and not a proof**） | DuBose–Vallières が自認している性格。**"numerical evidence" と訳さない**（彼らの自認より弱くなる） |
| 明示式 | **explicit formula** | Monsky の $\alpha^*$ に明示式が無いことの記述で使う |
| 存在しか主張していない | **asserts only its existence** | Monsky 1989 Theorem 3.12 / 3.13 の "there is a real number …" の形に対応 |
| 弱い形 | **a weaker form** | 命題 T の既出性（$v_2$ が偶数）の言い方 |
| 強化 | **a strengthening** | 同上。命題 T は既出の弱い形の強化である |
| 住処（ブロックの宣言としての） | **habitat** | §1.1 のとおり。**本文で言及するときイタリック等の強調を付けない**（生成器は `**太字**` しか解さず、`*斜体*` はアスタリスクがそのまま PDF に出る。実際に一度出した） |

### 1.5 生成器の制約（訳語ではないが、書くときに必ず効く）

- **強調は `**…**` だけである。`*…*`（斜体）は解釈されず、アスタリスクがそのまま PDF に出る。**
- **`**…**` は 1 つのノードの中で開いて閉じること。** ノード（＝配列の 1 要素の文字列）をまたぐと
  ビルドが落ちる。数式 `math(...)` を挟んで強調したくなったら、**強調の範囲を数式の手前で閉じる**
  ように文を組み替える（例:「**命題 V は $d=1$ で既出**」→ "**Proposition V is known in the
  one-variable case.** For $d=1$, …"）。
- **引用は `cite(keys, note?)`。第 2 引数が locator である。**
  `cite(["Key"], "Theorem 5.1")` と書く。`cite(["Key", "Theorem 5.1"])` は
  「そんな BibTeX キーは無い」で生成が落ちる。

---

## 3. 後続が判断する必要がある点（訳語では決まらない）

1. **「命題 A」の呼称**（§1.3）。生成器は Theorem 環境で組むので、本文で "Proposition A" と呼ぶと
   PDF 上は "Theorem 4.1 (Proposition A)" のような二重呼称になる。日本語版も同じ状態である。
   統一するなら生成器か本文のどちらかを変える必要があり、**内容の変更を伴うので独断で変えない**。
2. ~~**要旨・表題・キーワード・MSC 2020**（`structured-latex-en/frontmatter.ts`）。
   現在の値はすべて暫定であり、MSC の番号は一次情報と照合していない。~~
   → **2026-08-01 に解消した。** 表題・要旨・キーワードを Survey Article 向けに書き直し、
   MSC 2020 は zbMATH 配布の公式分類表 <https://zbmath.org/static/msc2020.pdf> と照合して確定した
   （primary 11R06 / secondary 03B25, 03B30, 05C30, 11R23, 37B40, 37P35, 68V20, 82B20）。
   **残る未確定は著者の所属と連絡先だけである**（リポジトリに一次情報が無いので空にしてある。
   投稿前に著者本人が埋めること）。
3. ~~**数式の中に日本語が入っているブロックがある**（第 1〜3 章の英訳で検出）。
   `paper_012_definition_ladder`（決定可能性の梯子）の `displayMath` が
   `\underbrace{...}_{\text{無条件に決定可能}}` 等を含み、英語版は和文フォントを読み込まないため
   `npm run build:pdf` が「PDF に組めない文字がある」で落ちる。~~
   → **2026-08-01 に統合担当が (a) の方針で解消した。** すなわち `\text{}` の**中身だけ**を英訳し、
   `structured-latex-en/tools/ja-en-exceptions.ts` へ理由つきで登録した。
   **日本語版は正本なので変更していない。** `\text{}` の外側の数式記号は 1 文字も変えていない。
   同種の箇所が他章にもある（`004_lambda_finite.ts` に 2 件、`005b_theta_infinity.ts` に 2 件）。
   **以後この型の箇所は同じ方針で処理する**（英訳 ＋ 例外表へ理由つき登録）。
4. **本文が「第 N 章」と書き、`\cref` が "Section N" と出す二重の言い方**（2026-08-01 に気づいた）。
   生成器は `level: 1` を `\section` に落とし、`\crefname{section}{Section}{Sections}` を出す。
   一方で本文の地の文は「第 3 章」＝ "Chapter 3" と書いており、日本語版も同じ状態である。
   どちらへ寄せるかは生成器か本文のどちらかを変える判断であり、**独断で変えていない**。
   なお**章番号そのものは、序論より前に `level: 1` の見出しを足すと全部ずれる**ので、
   英語版限定の節を足すときは末尾へ足すこと（`content/001a_reader_guide.ts` の冒頭コメントを見よ）。
2. **要旨・表題・キーワード・MSC 2020**（`structured-latex-en/frontmatter.ts`）。
   現在の値はすべて暫定であり、MSC の番号は一次情報と照合していない。
3. **他章のラベルへの `ref()`**（第 5 章の英訳で暫定的に地の文にしてある）。
   `ref()` は英語版 `content/` に実在しないラベルを型で落とすため、まだ英訳されていない章の
   ラベル（`paper_def_curve` / `paper_thm_archimedean` / `paper_claim_resultant` /
   `paper_prop_V` / `paper_prop_W`）は指せない。`content/005_duality.ts` では
   "the resultant claim of Chapter 2" のような地の文で書き、該当箇所に `TODO(ref)` を付けた。
   **第 2・3・6 章の英訳が入ったら `ref()` へ戻すこと。** 戻し忘れると、章番号を手書きした
   参照が残り、組版で番号が動いたときに黙って壊れる。
4. **内部レポートのパス**（`\texttt{outputs/reports/...}`）。第 5 章の 3 箇所にある。
   これらは `math` ノードなので、対応検証（数式の多重集合一致）の対象であり、英訳側で
   勝手に書き換えられない。投稿稿にリポジトリ内部のパスを出すのは不適切なので、
   **日本語版と英語版の両方を同時に直すか、`ja-en-exceptions.ts` に理由つきで登録するかを
   呼び出し元が決める必要がある。** 加えて、生成器はこれを `\path{...}` へ落とすため、
   本文が `\_` とエスケープしている分がそのまま PDF に**バックスラッシュ付きで出ている**
   （実測: `cycle16\_T1\_lambda\_l0\_computability.md`）。
5. **`(G1′)` の PRIME 記号**。英語版は和文フォントを読み込まないので U+2032 が PDF から
   無言で消える（生成器の「組めない文字」検査が落ちる）。第 5 章では ASCII の `'` で組んだ。
   日本語版は U+2032 のままである。

---

## 追記: 命題 G′（`content/005b_theta_infinity.ts`）の語

この節は 005b（消滅深度が無限大になる退化塔）の英訳作業中に追記した。**§1 の表と同じ拘束力を持つ**
（後続がここにある語を別の語で訳してはならない）。根拠は §0 の約束どおり、
**このセッションで実際に読んだ日本語版本文だけ**である。英語圏の教科書は取得できていない。

| 日本語 | 英語 | 根拠 |
|---|---|---|
| 消滅深度が無限大（$\theta=\infty$） | **infinite vanishing depth** | §1.2 の「消滅深度 = vanishing depth」の派生。$\theta$ が有限値を取らない場合を指す |
| 段階的処理 | **the stagewise treatment** | 本プロジェクトの言い方。日本語版の中身は「$\ell$ 進の内容を 1 回割ってから深さを読む」という 2 段構えであり、"stagewise" はその段を指す。**未確認**（この語が文献の標準語かは一次情報を取得できていない）ので、初出で「内容を割る／深さを読む」の 2 段であることが本文から読めるように訳した |
| 消滅深度が無限大になる軌跡 | **the locus of infinite vanishing depth** | 「軌跡」＝ locus（代数幾何の標準語）。日本語版はこれが「原点を通る有限本の直線の合併」だと述べる |
| 例外直線 | **exceptional line** | 日本語版の造語（$\theta=\infty$ となる直線 $\mathbb{Z}u$）。逐語訳。**$\mathbb{P}^1(\mathbb{F}_\ell)$ の「方向」とは別物**（直線は $\mathbb{Z}^2$ の中の部分群）なので訳し分ける |
| 型 II / 型 III | **type II** / **type III** | 日本語版が `content/005_duality.ts` と `005b` で使う塔の分類（$n\ell^n$ 項を持たない／持つ）。**日本語版本文にも定義は無く**、括弧書きの説明（「$n\ell^n$ 項を持つ」）だけが根拠である。英訳でもその括弧書きを必ず残す |
| Newton 多面体 | **Newton polytope** | 2 変数 Laurent 多項式 $\bar{\tilde E}$ に対する平面内の凸包。**§1.2 の Newton polygon（1 変数特性多項式の下方凸包）と別物**なので、同一文書で語を使い分ける。日本語版も「多角形」と「多面体」を書き分けている |
| Minkowski 分解 | **Minkowski decomposition** | 標準語。日本語版が $\mathrm{Newt}(fg)=\mathrm{Newt}(f)+\mathrm{Newt}(g)$ を明示している |
| 原始ベクトル | **primitive vector** | 標準語（成分の最大公約数が 1）。日本語版の $u=(a,b)\in\mathbb{Z}^2$ |
| 1 径数部分群 | **one-parameter subgroup** | 標準語。日本語版の $y\mapsto(y^a,y^b)$ |
| 恒等的に消える | **vanishes identically** | 標準語。「ある点で消える」との訳し分けを必ず保つ |
| （多項式の）内容 | **content** | 標準語（係数の最大公約数）。日本語版が既に記号 $\mathrm{content}$ を使っている |
| レベルちょうど $M$ の点 | **points of exact level $M$** | 日本語版の「ちょうど」は「レベルが $M$ 以下」ではなく「ちょうど $M$」の意。**"of level $M$" だけにすると主張が弱まる**ので exact を落とさない |
| （点の）代表 | **representative** | 標準語。日本語版は「同じ点の別の代表では値が違いうる」と明記しており、この caveat を落とすと主張が強まる |
| 寄与 | **contribution** | 標準語（$\Sigma_n$ への寄与） |
| 射程の限界 | **the limits of the scope** | §1.3 の「限界 = limitation」「射程外 = out of scope」の合成。日本語版はこれを「誇張しないために明記する」と書いており、**この一文ごと落としてはならない** |
| 実測（値） | **the measured values** | 日本語版の反例が挙げる実際に計算した $\mathrm{ord}_\ell$ の値。予言値（右辺）と訳し分ける |
| bouquet / voltage | **bouquet** / **voltage** | 日本語版が既に英語のまま使っている（`content/006_propositions_TVW.ts` も同じ） |

### 記号 $\Lambda$ の衝突（訳語ではなく読者への注意）

`content/005b_theta_infinity.ts` は $\Lambda:=\sum_{\text{例外直線}}\lambda$ と置く。これは
**§1.1 の「対数順序群 $\Lambda$」とは無関係な別の量**である（例外直線にわたる指数の和）。
記号は日本語版と同じでなければならない（数式は翻訳の対象ではない）ので、
**英訳では地の文で「この記号はこの命題に限った局所的なもので、序章の対数順序群とは無関係である」と
断ってある**。後続がこの命題の周辺を訳すときも、$\Lambda$ の二義性を読者に隠さないこと。

---

## 追記: 命題 J（`content/008_theta_padic.ts` — 第 9 章「消滅深度の p 進化」）の語

日本語版に後から入った第 9 章（命題 J）の英訳作業中に確定させた語。**§1 の表と同じ拘束力を持つ**
（後続がここにある語を別の語で訳してはならない）。根拠は §0 の約束どおり、
**このセッションで実際に読んだ日本語版本文だけ**である。英語圏の教科書は取得できていない。

| 日本語 | 英語 | 根拠 |
|---|---|---|
| （消滅深度の）p 進化 | **the p-adic refinement (of the vanishing depth)** | 章の表題。日本語版の中身は「θ を $\mathbb{P}^1(\mathbb{F}_\ell)$ の方向の関数から $\mathbb{P}^1(\mathbb{Z}_\ell)$ の点の関数へ延ばす」ことなので、"p-adic refinement" を採った。**"p-adicization" のような造語にしない** |
| 桁定理 | **the digit theorem** | (J1) の呼称。主張は「$A_m\bmod\ell$ が $(a,b)\bmod\ell^L$ だけで決まる」＝ $\ell$ 進展開の有限個の桁だけで決まる、である。逐語訳 |
| 桁安定性 | **the stability of the digits** | (J6) の証明が (J1) を指して使う語。上の digit theorem と同語根で揃えた |
| ファイバー Newton 公式 | **the Newton formula along a fibre** | (J2) の呼称。「ファイバー」は $\mathbb{P}^1(\mathbb{Z}_\ell)\to\mathbb{P}^1(\mathbb{F}_\ell)$ の $P_0$ 上のファイバーである。**"fibre Newton formula" と名詞を積み重ねない**（読者が「ファイバー Newton 多角形」という既成語と誤読する） |
| （型の）判別 | **the criterion distinguishing … from …** | (J4) の表題「型 II / 型 III の判別」。**"discriminant" にしない**（代数の判別式と紛れる） |
| 閾値の鋭さ／閾値は鋭い | **the threshold is sharp** | (J1′) の表題。§1.2d の「しきい値 = threshold」の派生。**"optimal" にしない**（§1.2d の「最良である = best possible」と同じ理由で、否定形の主張を保つ） |
| 破れ（閾値を超えた所での） | **failure** | (J1′)。「$m=\ell^L+1$ での破れ」＝ "the failure at $m=\ell^L+1$"。§1.2c の「上界が破れる = the bound fails」と同語 |
| 極形式 | **the polar form** | (J1′) の $\bar B(x,y)$（2 次形式 $\bar A_2$ に対応する対称双線型形式）。標準語 |
| レベル分解 | **decomposition by level** | (J3) の表題。$\Sigma_n$ をレベル $M$ ごとの和へ分けることを指す |
| 一般の予言 | **the prediction in general** | (J3) の表題。§1.4（第 5 章）の「パラメータ 0 個の予言 = a prediction with zero free parameters」と同じ predict を使う |
| 最小点が一意（である） | **the minimum is attained at a single index** | (J2)・(J3)・限界の 3 箇所に出る条件。**"the minimizer is unique" と縮めない**（本文が指しているのは添字 $j$／$m$ が一意であることであり、点ではない） |
| 打ち消し（が起きる） | **cancellation (occurs)** | (J2)・(J4)・限界。§1.2c の「相殺 = cancellation」と**同じ語を充てる**（日本語版は「相殺」と「打ち消し」を書き分けているが、どちらも係数が消えることであり、英語で語を分ける根拠が本文に無い） |
| 相互検証（になる） | **a mutual check** | (J5)。(J4) と命題 G′ が別経路で同じ値に達することを指す。**"cross-validation" にしない**（統計の語と紛れる） |
| 基点 | **base point** | (J4) の「$e_j$ は $P$ 自身を基点として取る」 |
| 引き戻し | **the pull-back** | 限界の最終項。$\hat{\mathbb{G}}_m$ の 1 径数部分群への引き戻し |
| 形式群 | **the formal group** | 同上。標準語。$\hat{\mathbb{G}}_m$ は乗法形式群 |
| 候補（を絞る） | **candidate** | (J6) と限界。「候補を有限個へ絞る」＝ "narrows the candidates down to finitely many" |
| 至る所有限 | **finite everywhere** | (J4) の仮定。$\mathbb{P}^1(\mathbb{Z}_\ell)$ 上の各点で θ が有限であること |

### 記号 $\Lambda$ の衝突（三度目。読者への注意）

(J2) は $\Lambda(r):=\min_{j\ge0}(e_j+j\ell^r)$ と置く。これは
**§1.1 の「対数順序群 $\Lambda$」とも、命題 G′ が例外直線の和として置く $\Lambda$ とも無関係な
第 3 の量**である。数式は翻訳の対象ではないので記号は変えられない。したがって
**英訳では地の文で「この記号はこの命題に限った局所的なもので、序章の対数順序群とも
前命題の $\Lambda$ とも無関係である」と断ってある**（命題 G′ の英訳と同じ処置）。

### プライムの書き方（§1.2d の実測ルールの適用）

本章の地の文には (J1′) と (G1″) が出る。**U+2032 `′` / U+2033 `″` は英語版の PDF から無言で消え、
`build:pdf` の「組めない文字」検査が落ちる**ので、**ASCII で `(J1')` / `(G1'')` と書く**。
日本語版は U+2032 / U+2033 のままでよい（和文フォントを読むため）。

---

## 追記: 2026-08-01 の専門校閲で確定・統一した語と書き方

英語版全 11 ファイル（日本語版由来 38 ブロック ＋ 英語版限定 7 ブロック）を通して校閲し、
章ごとにばらついていた語・書き方を次のとおり統一した。**§1 の表と同じ拘束力を持つ。**
根拠欄の約束は §0 と同じ（このセッションで確認した一次情報だけを書く）。

### 3.1 語の統一

| 対象 | 決めた形 | 根拠・注意 |
|---|---|---|
| Henselization / Henselisation | **Henselisation** | §2.5 の英綴り（-ise）。`content/007_asymmetry_scope.ts` が -ization のままだったので直した。**原論文の表題 "Henselian local rings" は原綴りのまま**（§1.4 の既定どおり） |
| 既出性（名詞） / 既出性の調査（修飾） | **prior art**（名詞） / **prior-art check**（修飾語） | 名詞は無ハイフン、名詞を修飾するときだけハイフン。現状の全 9 箇所がこの形になっていることを確認した |
| Mednykh 系の著者名 | **Kwon–Mednykh–Mednykh** | 引用検証 F-1（arXiv:1902.05681 の著者メタデータは 3 名）。`content/006`・`007`・`009` の 3 箇所を en ダッシュ連結の同一形へ揃えた。**"Kwon, Mednykh and Mednykh" と書き分けない** |
| DuBose–Vallières を主語にした動詞 | **複数扱い**（acknowledge / state） | 著者 2 名の連名を主語にしているので単数の -s を付けない（`content/006` が acknowledges になっていたので直した） |
| 引用符 | **`“…”`（U+201C / U+201D）** | ASCII の `'…'` は LaTeX で開き引用符が右向きに組まれる。`content/006`・`007` の 2 箇所を直した。実測で PDF の「組めない文字」検査は `“ ”` を通す |

### 3.2 散文の書誌の書き方（投稿稿の体裁）

**地の文の書誌は「著者名 ＋ `cite`」に寄せ、巻・号・頁・掲載年は参考文献表に任せる。**
校閲前は "Lind–Schmidt–Ward, Invent. math. **101** (1990) 593–629, Theorem 3.1; [LSW1990, Theorem 3.1]"
のように同じ情報が 2 度出ていた。読者が本文で必要とするのは**著者名とどの定理か**だけである。

- locator（Theorem 5.6 / §4.3 / p. 227, Remark 2 等）は **`cite` の第 2 引数**へ入れる。地の文へ重ねて書かない。
- 節番号の書き方は **`§`** に統一する（"Section 7" と混ぜない）。
- **例外: プレプリント版の番号で定理を引いている箇所は arXiv ID を地の文に残す。**
  出版版で番号が一致する保証が無く（引用検証 §4「照合できなかったもの」）、
  参考文献表が出版版を指す以上、arXiv ID が無いと読者が照合できなくなるためである。
  該当は Lind–Schmidt–Verbitskiy（arXiv:1108.4989）・Kwon–Mednykh–Mednykh（arXiv:1902.05681）・
  Vallières（arXiv:2006.14012）の 3 件。加えて `paper_104_remark_prior_art_limits` に
  「プレプリントから番号で引いた箇所は、出版版で同じ番号かを確認していない」と一度だけ明記した。

### 3.3 リポジトリ内部のパスを本文に出さない

補助レポートや Lean の README を `\texttt{outputs/reports/...}` の **math ノード**で書いていた箇所は、
**投稿稿の読者がそのファイルを開けない**ので落とし、"the supporting report for this proposition" /
"a table in the accompanying Lean development" のような言い方へ置き換えた。

数式の多重集合が日本語版とずれるので、対象ブロックは `structured-latex-en/tools/ja-en-exceptions.ts`
へ理由つきで登録する。**落としてよいのは参照先の「名前」だけであり、主張・限界・caveat は落とさない。**

### 3.4 数学英語の言い回し（校閲で直した型）

- 仮定の明示: 引用先が課している仮定は落とさない。数式ノードを増やせない場面では
  **地の文の言い回しで書く**（例: `d\ge2` を "Provided the number of variables is at least two"）。
- realEscape・タイトルは**数式ノードを持てない**ので、`L → ∞` のような記号の羅列を避け、
  "the limit in which L tends to infinity" のように語で書く（記号だけがイタリックにならず、
  地の文の中で字体が割れるため）。

---

## 追記: 命題 K（`content/009_s_infinity_decision.ts`）と命題 R（`content/009_theta_recursion.ts`）の語

日本語版に後から入った第 10 章（命題 K）・第 11 章（命題 R）の英訳作業中に確定させた語。
**§1 の表と同じ拘束力を持つ**（後続がここにある語を別の語で訳してはならない）。
根拠は §0 の約束どおり、**このセッションで実際に読んだ日本語版本文だけ**である。
英語圏の教科書は取得できていない。

| 日本語 | 英語 | 根拠 |
|---|---|---|
| 判定手続き | **decision procedure** | §1.2 の既定どおり（"decidable" と対で使う標準語）。命題 K の (K3) は文字どおり有限の判定手続きである |
| 判定条件の同一性 | **the two criteria agree** | (K2) の表題。命題 G′ の (iii) と命題 J の (iv) が同じ判定であるという主張なので、"equivalence of criteria" ではなく「一致する」を主語述語で書く |
| 対応（(K1) の表題） | **the correspondence** | 原始ベクトルの類と $\mathbb{P}^1(\mathbb{Z}_\ell)$ の点の間の写像 $\iota$ を指す。**"identification" にしない**（本文は単射性と像を別々に主張しており、同一視と言い切ると主張が強まる） |
| 非同伴 | **non-associate** | 標準語（UFD の素元が単数倍で移り合わないこと）。§1.2 の non-degenerate と同じくハイフンつきに統一する |
| 素元 | **prime (element)** | 標準語。既約元ではなく素元である（本文は UFD と明示している） |
| 増大イデアル（$(\chi^v-1)$） | **augmentation-type ideal** | (K5 の限界) の「増大イデアル」。群環の augmentation ideal そのものではなく、方向ごとの $(\chi^v-1)$ を指すので **-type** を付けた。**未確認**（この語が文献の標準形かは一次情報を取得できていない） |
| 擬同型分解 | **pseudo-isomorphism decomposition** | 岩澤加群の構造定理の標準語 |
| 格子周長 | **lattice perimeter** | (K7) の $\mathrm{per}$。「各辺の格子長の和」という定義を初出で必ず添える（造語に近いため） |
| 格子多角形 | **lattice polygon** | 標準語。§1.2 の Newton polygon（1 変数）とも §1.5 追記の Newton polytope（2 変数）とも別語なので混ぜない |
| 仮定の解消 | **the hypothesis is discharged** | (K5) の表題「仮定 (N) の解消」。**"removed" にしない**（本文は仮定が自動的に満たされることを示しており、消したのではない） |
| 数値支持どまり | **numerical support only** | (K6 の限界)。§1.4 の「数値フィット = a fit」と同じ扱いで、**"evidence" と訳して強めない** |
| 桁枝再帰 / 桁枝分解 | **the digit-branch recursion** / **the digit-branch decomposition** | 命題 R の中心語。$\ell$ 進展開の第 0 桁で枝分けする再帰。§1.5 追記の「桁定理 = the digit theorem」と同語根で揃えた |
| 打ち消しは起きない | **no cancellation occurs** | 第 11 章の表題。§1.5 追記の「打ち消し = cancellation」の派生。**"cancellation is impossible" にしない**（本文が示すのはこの分解では構造的に起こらないことで、任意の分解での不可能性ではない） |
| 構造的に起こらない | **cannot occur, for structural reasons** | 上と対で使う。理由が構造にあることを落とさない |
| 有効（上界が有効である） | **effective** | (R3)。計算可能な明示上界を与えるという意味の標準語。**"efficient" と混ぜない** |
| 終結式による付値 | **the valuation as a resultant** | (R4) の表題。付値が終結式ひとつの $\ell$ 進付値として書けるという主張。**"valuation by resultants" と複数形にしない** |
| 完全分岐 | **totally ramified** | 標準語。§1.2d の「従順分岐 = tamely ramified」と対 |
| 剰余次数 | **residue degree** | 標準語 |
| 無仮定化 | **removing the hypotheses** | (R5) の表題。**"unconditional" と一語で言い換えない**（本文は「(J3) が置いていた仮定を外す」という具体的な操作を述べている） |
| 最小点の tie | **the tie between minimising indices** | (R2 の限界)。日本語版が英語のまま "tie" を使っている。§1.5 追記の「最小点が一意 = the minimum is attained at a single index」と同じく、**点ではなく添字**であることを保つ |
| 型 III の項（$n\ell^n$ 項） | **the type III term** | 見出し・タイトルで $n\ell^n$ を語で言う必要があるときの言い方（タイトルは数式ノードを持てない。§3.4）。本文では従来どおり数式ノード $n\ell^n$ を使う |

### 記号 ℓ を地の文へ書けないこと（実測に基づく制約）

**U+2113 `ℓ` は日本語版 `tools/unicode-math.ts` の対応表に無い。** 地の文へ書くと LaTeX へ写されず、
英語版の PDF から無言で消える（`build:pdf` の「組めない文字」検査が落ちる）。
既訳が「p 進」を "p-adic" と一般名として使っている（§1.5 追記の「p 進化 = the p-adic refinement」）ので、
**地の文で素数を名指しする必要がない箇所は "p-adic" と書く**。素数が $\ell$ であることを言う必要がある
箇所は、$\ell$ を数式ノードとして置き、その直後に地の文で "-adically" と続ける（命題 R (R3) がその形）。

### `\text{}` の中の日本語が後置修飾である場合（命題 K・R で新たに生じた型）

§3（判断事項）3 の方針は「`\text{}` の中身だけを英訳する」であった。命題 K・R には、
**`\text{}` の中身が日本語の後置修飾**である箇所がある（`(=\ \bar{\tilde E}\ \text{の原始二項式部分の次数})`、
`\text{の元が}…\text{で相異なる}`、`\text{max は}…\text{なる }\delta\text{ 上}`）。
中身だけを同じ位置で英訳すると英語として読めず、1 つ目は **`b = \bar{\tilde E}` と読める偽の等式**になる。
そこで **`\text{}` の前後にある記号の順序だけ**を英語の語順へ直した。
**記号は 1 つも足していないし、1 つも消していない。** 対象ブロックは
`structured-latex-en/tools/ja-en-exceptions.ts` へ、この事情を明記した理由つきで登録した。
