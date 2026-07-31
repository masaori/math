# 論文 001 英語版（Expositiones Mathematicae 投稿稿）の引用検証

作成日: 2026-08-01 / 対象: `integrable-lattice/structured-latex-en/`（本文）と
`integrable-lattice/outputs/papers/001_R_Lambda_duality/refs.bib`（書誌の正本、23 エントリ）

**担当範囲は引用の検証のみ**（数学的内容のレビューは別担当）。本レポートは読み取り専用の作業で、
このファイル以外は一切変更していない。

---

## 0. 結論（先に結論だけ）

**投稿稿として致命的な引用の問題は 1 件。** 参考文献 [13] の**著者が 1 名欠落している**
（Mednykh–Mednykh ではなく **Kwon–Mednykh–Mednykh** の 3 名。arXiv の著者メタデータで確認）。
これは書誌の欠落ではなく**著者の誤帰属**であり、地の文にも波及している（3 箇所）。

そのほかに、**投稿前に必ず直すべき（査読者・copy editor が確実に指摘する）問題が 4 件**、
**直すことを推奨する問題が 5 件**ある。いずれも修正案を §2 に具体化した。

**引用の内容的な正しさ（本題）については、瑕疵は検出されなかった。**
本文が「文献 X の命題 Y が Z を述べている」と書いている箇所を、リポジトリ内の一次記録
（cycle 13 / 16 / 17 / 18 の各レポートに残された原文の書き写し）と 1 件ずつ突合した結果、
**引用先の言明と食い違うものは 1 件も見つからなかった**（§3 の突合表）。とくに:

- **cycle 17 の「Monsky 1989 未取得」が英語版に残っていないこと**を確認した。
  英語版限定の先行研究章（`content/008_prior_art.ts`）を含む 4 箇所すべてが
  cycle 18 の判定（入手済み・$\alpha^*$ の明示式は無い・命題 W は既出にならない）と一致している。
- 「本文未読」と一次記録が言っている文献（Lehmer, Ferrero–Washington, Ax–Kochen, Ershov,
  Haskell, Viswanathan）を、本文が確認済みのように書いている箇所は無い。

**私自身の作業上の誤り**: Crossref が Lind–Schmidt–Ward の号を `issue: 1` と返したため、
一度は `refs.bib` の `number = {3}` を誤りと判断しかけた。zbMATH Open で
「Invent. Math. 101, No. 3, 593-629 (1990)」を確認し、**誤っているのは Crossref のメタデータ側**
だと訂正した。`refs.bib` は正しい。

---

## 1. 機械検証の結果（実行して貼る）

実行環境: Node v22.22.3、`npx --yes pnpm@9 install` を
`structured-latex/`・`integrable-lattice/structured-latex/`・`integrable-lattice/structured-latex-en/`
の 3 箇所で実行済み。

```
$ (cd integrable-lattice/structured-latex-en && npm run check)
generated .../structured-latex-en/build/document.tex
  ブロック 43 件（見出し 9、証明 16、TODO 0） / ラベル 36 件 / 相互参照 35 件（すべて解決）
  / 引用 59 件（.bib のキー 23 件、すべて実在）
no notes in output: ノート 0 件（本文サンプル 0 件）は いずれも build/document.tex に現れない
すべての負テストが期待どおり: 誤った入力は tsc が拒否する（6 件）
実行時検証テスト 11 件すべて期待どおり
```

```
$ (cd integrable-lattice/structured-latex-en && npm run build:pdf)
generated .../structured-latex-en/build/document.tex
  ブロック 43 件（見出し 9、証明 16、TODO 0） / ラベル 36 件 / 相互参照 35 件（すべて解決）
  / 引用 59 件（.bib のキー 23 件、すべて実在）
built .../structured-latex-en/build/document.pdf: 25 ページ、未解決参照 0 件、
  未定義引用 0 件、組めない文字 0 件、版面外へ出た行 0 件（軽微な overfull 1 件は余白内）、
  参考文献 18 件
no notes in output: ノート 0 件（本文サンプル 0 件）は いずれも build/document.tex に現れない
```

- **未定義引用 0 件**
- **参考文献 18 件**（`.bib` 23 件のうち、本文から引用された 18 件だけが出力される）
- 独立確認: `content/*.ts` の `cite(...)` に現れるキーを列挙すると 18 種類で、
  `build/document.bbl` の `\bibitem` 18 件と完全に一致した。

---

## 2. 問題の一覧（修正案つき）

### 【致命的】F-1. 参考文献 [13] の著者が 1 名欠落している（誤帰属）

| 項目 | 内容 |
|---|---|
| 該当 | `refs.bib` の `@article{MednykhMednykh2019}`、および地の文 3 箇所<br>`content/006_propositions_TVW.ts:308`（`paper_062_theorem_T` の proof）<br>`content/007_asymmetry_scope.ts:201`（`paper_remark_scope`）<br>`content/008_prior_art.ts:172`（`paper_093_remark_prior_art_propositions`） |
| 本文の記述 | 006: 「From Theorem 5.1 of **Mednykh–Mednykh**, *Complexity of the circulant foliation over a graph*, arXiv:1902.05681」<br>007: 「(**Mednykh–Mednykh** [13])」<br>008: 「**Mednykh and Mednykh** [13] show, for the circulant foliation over a graph, …」<br>PDF [13]: 「**A. D. Mednykh and I. A. Mednykh.** Complexity of the circulant foliation over a graph. arXiv preprint, arXiv:1902.05681, 2019.」 |
| 何が食い違うか | **著者は 3 名である。** arXiv:1902.05681 の著者は **Young Soo Kwon, Alexander Mednykh, Ilya Mednykh**。さらにこの論文は**査読誌に出版済み**であり、プレプリントとして引くのは投稿稿として不適切。 |
| 一次情報での正しい値 | arXiv API（`https://export.arxiv.org/api/query?id_list=1902.05681`）: title「Complexity of the circulant foliation over a graph」/ authors「Young Soo Kwon, Alexander Mednykh, Ilya Mednykh」/ 2019-02-15 / 14 pages。<br>Crossref（`api.crossref.org/works?query.bibliographic=...`）: **Kwon Y. S., Mednykh A. D., Mednykh I. A.**, *Journal of Algebraic Combinatorics* **53**(1), 115–129, DOI **10.1007/s10801-019-00921-7**。 |
| 修正案 | (a) `refs.bib` を次に差し替える。<br>`author = {Kwon, Young Soo and Mednykh, Alexander D. and Mednykh, Ilya A.}`<br>`title = {Complexity of the circulant foliation over a graph}`<br>`journal = {Journal of Algebraic Combinatorics}`, `volume = {53}`, `number = {1}`, `pages = {115--129}`, `year = {2021}`, `doi = {10.1007/s10801-019-00921-7}`, `eprint = {1902.05681}`, `archiveprefix = {arXiv}`<br>（キー名 `MednykhMednykh2019` は `content/*.ts` 3 箇所と `refs.bib` を同時に直せるなら `KwonMednykhMednykh2021` へ改名するのが望ましいが、キーは出力に出ないので**改名しなくても投稿稿の瑕疵にはならない**。）<br>(b) 地の文 3 箇所の「Mednykh–Mednykh」「Mednykh and Mednykh」を **「Kwon–Mednykh–Mednykh」「Kwon, Mednykh and Mednykh」** に直す。<br>(c) **注意**: 本文が引いている「Theorem 5.1」「§7.6」は**arXiv 版の番号**である（cycle 17 レポート §3.1 が arXiv:1902.05681 の本文を読んで記録した番号）。出版版に切り替える場合、番号が一致する保証がないため、**`eprint` を残したうえで地の文の番号引用は「Theorem 5.1 of the arXiv version (arXiv:1902.05681)」と限定するか、出版版で番号を再確認する**こと。**本レビューでは出版版の本文を取得しておらず、番号の一致は確認できていない。** |

なおこの誤帰属は本レビューで新たに生じたものではなく、**cycle 17 のレポート
（`cycle17_T1_prior_art_check.md` §1 の表・§3.1）が既に「Mednykh–Mednykh」と書いており、
そこから `refs.bib` と本文へ伝播している**。レポート側も直すのが筋だが、
本レビューは報告ファイル以外に触らない指示なので、**呼び出し元が判断されたい**。

---

### 【要修正】F-2. 参考文献の題名で固有名詞が小文字化されている（5 件）

| 項目 | 内容 |
|---|---|
| 該当 | `build/document.tex:828` が `\bibliographystyle{plain}` を使っているため、`plain.bst` の `change.case$` が題名を lowercase 化する。`refs.bib` の `title` に波括弧の保護が無いエントリが該当。 |
| 本文の記述（実際の PDF から） | [1] 「Elementary constructive theory of **henselian** local rings.」<br>[2] 「Diophantine problems over local fields **iii**: Decidable fields.」<br>[7] 「The **iwasawa** invariant …」<br>[9] 「An **iwasawa**-type asymptotic formula …」<br>[18] 「Mahler measures, elliptic curves, and **$l$**-functions for the free energy of the **ising** model.」 |
| 何が食い違うか | Henselian / III / Iwasawa / Ising は固有名詞であり、小文字化は明白な誤植。とくに [18] は**数式中の $L$ が $l$ になっている**（Hasse–Weil $L$ 関数を小文字 $l$ と書いてしまっている）ので、数学的にも誤り。 |
| 一次情報での正しい値 | Crossref/zbMATH の題名: 「Elementary constructive theory of **Henselian** local rings」/「Diophantine Problems Over Local Fields: **III**. Decidable Fields」/「The **Iwasawa** Invariant $\mu_p$ Vanishes for Abelian Number Fields」/ arXiv:2606.03579「An **Iwasawa**-type asymptotic formula …」/「Mahler measures, elliptic curves, and **$L$**-functions for the free energy of the **Ising** model」 |
| 修正案 | `refs.bib` の該当 5 エントリの `title` を波括弧で保護する（`TatenoUeki2025` が既に `{I}wasawa` としているのと同じ流儀に揃える）。<br>[1] `Elementary constructive theory of {H}enselian local rings`<br>[2] `Diophantine problems over local fields {III}: {D}ecidable fields`<br>[7] `The {I}wasawa invariant $\mu_p$ vanishes for abelian number fields`<br>[9] `An {I}wasawa-type asymptotic formula for multiple $\mathbb{Z}_p$-coverings of graphs`<br>[18] `Mahler measures, elliptic curves, and {$L$}-functions for the free energy of the {I}sing model` |

---

### 【要修正】F-3. 参考文献 [8]（Haskell）に巻・号・頁が無い

| 項目 | 内容 |
|---|---|
| 該当 | `refs.bib` の `@article{Haskell1992}` |
| 本文の記述（PDF） | 「[8] Deirdre Haskell. A transfer theorem in constructive p-adic algebra. **Annals of Pure and Applied Logic, 1992.**」 |
| 何が食い違うか | 巻・号・頁が欠落しており、書誌として不完全。Elsevier の投稿稿では確実に copy editor に差し戻される。 |
| 一次情報での正しい値 | Crossref（DOI 10.1016/0168-0072(92)90033-V）: *Annals of Pure and Applied Logic* **58**(1), **29–55**, 1992。 |
| 修正案 | `refs.bib` の `Haskell1992` に `volume = {58}`, `number = {1}`, `pages = {29--55}` を追加する。 |

---

### 【要修正】F-4. 参考文献 [9]（Kataoka）に arXiv ID が印字されていない

| 項目 | 内容 |
|---|---|
| 該当 | `refs.bib` の `@article{Kataoka2026}` と、生成器 `tools/build-latex.ts` の `stripNoteFields` の設計 |
| 本文の記述（PDF） | 「[9] Takenori Kataoka. An iwasawa-type asymptotic formula for multiple $\mathbb{Z}_p$-coverings of graphs. **2026.**」 |
| 何が食い違うか | 本論文で**最も多く引用されている文献（9 箇所）**であるにもかかわらず、参考文献リストからは所在が分からない。`plain.bst` は `eprint` / `archiveprefix` を印字しないため、`refs.bib` に arXiv ID があっても出力に出ない。さらに、所在を書く自然な場所である `note` フィールドは**生成器が投稿稿から意図的に落としている**ので、`note` に書いても出ない。<br>（緩和事情: 地の文 `005_duality.ts:152` と `006_propositions_TVW.ts:485` は「arXiv:2606.03579」と明記しているので、読者が完全に辿れなくなるわけではない。） |
| 一次情報での正しい値 | arXiv API: arXiv:2606.03579、2026-06-02 投稿、28 ページ、**journal_ref / DOI はいずれも無し**（未出版であることを確認した）。 |
| 修正案 | 二択。**(a) 推奨**: `refs.bib` の `Kataoka2026` に `journal = {Preprint, arXiv:2606.03579}` を足す（`plain.bst` は `journal` を印字する。`note` は落とされるので使えない）。同じ処置を `TatenoUeki2025`（[16] も巻・頁・DOI が無い）にも施すなら、`doi = {10.1112/jlms.70183}` を足したうえで `journal = {Journal of the London Mathematical Society (to appear)}` 等にする。<br>**(b)**: `tools/build-latex.ts` の書誌導出を「`note` を全部落とす」から「日本語を含む `note` だけ落とす／投稿稿用の英語 `note` は残す」へ変え、`Kataoka2026` に `note = {Preprint, arXiv:2606.03579}` を置く。**ただし (b) は生成器の変更を伴い、「非 ASCII が 1 文字でも残れば落とす」という現在の安全弁を弱めるので、(a) を推奨する。** |

---

### 【要修正】F-5. Lind–Schmidt–Verbitskiy の Theorem 1.2 / 1.3 から仮定 $d\ge2$ が落ちている

| 項目 | 内容 |
|---|---|
| 該当 | `content/003_archimedean.ts:66–81`（ブロック `paper_030_theorem_archimedean` の項目 (iii)(iv)） |
| 本文の記述 | 「**(iii)** It holds if $\mathsf U(P)$ is a **finite set** (Lind–Schmidt–Verbitskiy, arXiv:1108.4989, Theorem 1.2)．」<br>「**(iv)** More generally, it holds if $\dim\mathsf U(P)\le d-2$, that is, if $P$ is **atoral** (op. cit., Theorem 1.3)．」 |
| 何が食い違うか | 原論文の Theorem 1.2 / 1.3 はいずれも **"Let $d\geqslant 2$ and …"** で始まる。本文はこの仮定を落としており、$d$ に制限のない主張として引用している（直前の記述で $P\in\mathbb{Z}[z_1^\pm,\dots,z_d^\pm]$ とだけ置き、$d$ の範囲を絞っていない）。**引用先が述べていない一般性で引用している**ことになる。 |
| 一次情報での正しい値 | `outputs/reports/cycle13_T1_padic_entropy_generality.md:65–67` に原文が書き写されている。<br>「**[B] Theorem 1.2**: "Let $d\geqslant2$ and $\mathfrak a$ be an ideal in $R_d$ whose unitary variety $\mathsf U(\mathfrak a)$ is a *finite set*. Then (1.3) holds."」<br>「**[B] Theorem 1.3**: "Let $d\geqslant2$ and let $\mathfrak a$ be an ideal in $R_d$. If the dimension of $\mathsf U(\mathfrak a)$ is at most $d-2$, then (1.3) holds."」 |
| 修正案 | (iii)(iv) に $d\ge2$ を明記する。例:<br>(iii)「It holds **for $d\ge2$** if $\mathsf U(P)$ is a finite set」<br>(iv)「More generally, it holds **for $d\ge2$** if $\dim\mathsf U(P)\le d-2$」<br>**この瑕疵は日本語版 `structured-latex/content/003_archimedean.ts:55,62` にも同じ形で存在する**（英語化で生じたものではない）。日英対応検証があるので、両方を同時に直すこと。 |

---

### 【推奨】F-6. Viswanathan [18] が「本文未読」と明示されていない

`refs.bib` の `Viswanathan2024` の note は「**この論文の本文は未読**（arXiv abstract のみ確認）」と書いている。
一方 `content/008_prior_art.ts:282–284` は
「Several papers were located but not read in full and are cited only from their reviews or abstracts;
**these are marked as such where they occur**」と約束している。
Haskell については `008_prior_art.ts:101` で「we have not read this paper; we know it from its review only」と
実際に明示されているが、**Viswanathan にはその印が無い**（`003_archimedean.ts:128–137`）。

ただし、本文が Viswanathan に帰している内容
（特殊温度で自由エネルギーが楕円曲線の Hasse–Weil $L$ 関数で書ける／臨界点では Dirichlet $L$ 関数）は、
**arXiv abstract がそのまま述べている**ことを一次情報で確認した
（"at specific temperatures we express the free energy in terms of a Hasse-Weil $L$-function of an elliptic curve.
At the critical point … in terms of a Dirichlet $L$-function."）。したがって**内容の誤りではない**。
約束との不整合だけが問題である。

**修正案**: `003_archimedean.ts` の当該段落末尾に
「(we know this result from the abstract; we have not read the paper in full)」を足す。

---

### 【推奨】F-7. `refs.bib` 冒頭の「本文との対応表」が古い

`refs.bib` の 14–22 行目にあるコメントは「本文が引用している文献 / していない文献」を列挙しているが、
これは**日本語版を grep した 2026-07-31 時点のもの**で、英語版の現状と食い違う。

- 「引用していない」側に挙がっている `Vallieres2021` と `DuBoseVallieres2023` は、英語版では**引用されている**。
- 英語版で引用されている `ByszewskiGraffWard2021` / `MednykhMednykh2019` / `Monsky1989` /
  `TatenoUeki2025` / `AlonsoLombardiPerdry2008` / `Haskell1992` の 6 件が、この表に**一切載っていない**。

コメント自体は導出時に落とされるので**投稿稿の瑕疵ではない**が、
コメント末尾が「※ この対応表は本文側の記述を変えれば古くなる。本文を触ったら引き直すこと」と
自ら要求している以上、引き直すべきである。**修正案**: §4 の表をそのまま貼り直す。

---

### 【推奨】F-8. `refs.bib` にあって印字されない DOI（`plain.bst` は DOI を出さない）

`refs.bib` は 15 件に DOI を持っているが、`plain.bst` は `doi` フィールドを印字しないため、
**PDF の参考文献に DOI は 1 件も出ていない**（実際の PDF で確認した）。
Expositiones Mathematicae（Elsevier）は DOI を求めるのが通例なので、
投稿時に `elsarticle-num` 等へ切り替えると DOI が出るようになる。
そのとき **DOI が無いエントリ 4 件が目立つ**ので、いま埋めておくとよい。

| エントリ | 現状 | 一次情報で確認した DOI |
|---|---|---|
| `ByszewskiGraffWard2021` | DOI 無し | **10.1112/blms.12531**（Crossref で著者・巻 53(5)・頁 1263–1298・2021 まで一致確認） |
| `AlonsoLombardiPerdry2008` | DOI 無し | **10.1002/malq.200710057**（Crossref・zbMATH で MLQ 54(3) 253–271 (2008) を一致確認） |
| `TatenoUeki2025` | DOI 無し | **10.1112/jlms.70183**（arXiv:2401.03258 の `arxiv:doi` フィールド） |
| `MednykhMednykh2019` | DOI 無し | **10.1007/s10801-019-00921-7**（F-1 参照） |
| `Ershov1965` | DOI 無し | **確認できなかった**（zbMATH に DOI の登録が無い）。`refs.bib` の note が「未確認（推測で埋めていない）」と書いているのは正しい。 |

---

### 【推奨】F-9. 導出書誌 `build/refs.generated.bib` の**ヘッダ 2 行だけ**日本語が残っている

生成器は「note を落とした後に非 ASCII が 1 文字でも残っていれば例外を投げる」検査を持っているが、
その検査は**ヘッダを付ける前**に走る。実際の `build/refs.generated.bib` の先頭 2 行は

```
% 自動生成ファイル — 直接編集しない。
% 正本: ../../outputs/papers/001_R_Lambda_duality/refs.bib（note フィールドと %% コメントだけを落としてある）
```

で、日本語（と em dash）を含む。**BibTeX はエントリ外を無視するので PDF には影響しない**
（実測: PDF の参考文献は正常、`Missing character` 0 件）。ただし**投稿時にこの `.bib` を
出版社へ提出する場合、非 UTF-8 前提のツールチェーンで事故りうる**ので、英語に直すのが安全である。

**修正案**: `tools/build-latex.ts:227–228` のヘッダ文字列を英語にする。
例: `% Generated file - do not edit. Source: ../../outputs/papers/001_R_Lambda_duality/refs.bib
(note fields and %-comments removed).`

---

### 未引用エントリ 5 件の判定（引用漏れではないか）

`refs.bib` 23 件のうち、本文から引用されていないのは次の 5 件で、**いずれも引用漏れではない**と判定した。

| キー | 未引用でよいと判断した根拠 |
|---|---|
| `MonskySomeInvariants1981` | note 自身が「**本文で引用していない。誤同定を防ぐためだけに置いてある控えである**」と明記。プロジェクト内部の記録であり、投稿稿に出す必要はない。 |
| `Deninger2009` / `Ueki2020` | $p$ 進 Mahler 測度・$p$ 進エントロピー（Besser–Deninger 系）の文献。**英語版・日本語版とも、この主題を本文で扱っていない**（`grep -n "Deninger\|Ueki\|p-adic entropy\|p-adic Mahler"` で本文中の言及 0 件。唯一のヒットは Tateno–Ueki への言及）。扱っていない主題の文献を引く必要はない。 |
| `McGownVallieres2024` | 命題 W の既出性は Vallières 2021 Cor 5.7 と DuBose–Vallières §7 で足りており、本文はこの論文の内容に依存した主張をしていない。 |
| `Wan2017` | Monsky 1989 の二次引用源。本文は同じ役割で `TatenoUeki2025` を使っている（`008_prior_art.ts:235`「The same reading is confirmed independently by Tateno and Ueki」）。**任意**: cycle 18 レポート §2.4 は Wan の引用形も原典に忠実だと確認しているので、独立確認を 2 本にしたいなら足してもよいが、**足さなくても瑕疵ではない**。 |

---

## 3. 引用の内容的な正しさ — 一次記録との突合

「本文が文献 X の命題 Y に帰している内容」を、**リポジトリ内に残された原文の書き写し**と 1 件ずつ照合した。
一次情報は次の 4 本（いずれも、その文献の本文を実際に読んだ記録である）。

- `outputs/reports/cycle13_T1_padic_entropy_generality.md`（Lind–Schmidt–Ward / Lind–Schmidt–Verbitskiy）
- `outputs/reports/cycle16_T1_monsky_primary_sources.md`（Monsky 1981 / Cuoco–Monsky 1981。**原文の逐語引用あり**）
- `outputs/reports/cycle17_T1_prior_art_check.md`（Vallières / DuBose–Vallières / Kataoka /
  Byszewski–Graff–Ward / Mednykh 系 / Alonso García–Lombardi–Perdry）
- `outputs/reports/cycle18_T1_monsky1989_acquisition.md`（Monsky ASPM 17 (1989)。**原文の逐語引用あり**）
- 補助: `outputs/reports/cycle14_T3_two_variable_criterion.md`・`cycle17_T3_degenerate_torus_odd_ell.md`
  （DuBose–Vallières §7 の例番号）

| # | ブロック id | 本文の主張 | 一次記録 | 判定 |
|---|---|---|---|---|
| 1 | `paper_030_theorem_archimedean` (i) | LSW Thm 3.1: エントロピー＝Mahler 測度、**仮定なし** | cycle13 §2.1: [A] Thm 3.1、「$f$ に零点条件は課されていない」。**出版版 PDF（UEA リポジトリ）で確認** | **一致** |
| 2 | 同 (ii) | LSW Thm 7.1: 周期点の増大率＝エントロピーは一般には不成立、expansive（$\mathsf U(P)=\varnothing$）で成立 | cycle13 §2.2 が p.595 の原文を引用: "Although examples show that this fails to hold in general, we show in Theorem 7.1 that it holds for all expansive actions." | **一致** |
| 3 | 同 (iii)(iv) | LSV Thm 1.2（$\mathsf U$ 有限）/ Thm 1.3（atoral） | cycle13 §65–67 の原文書き写し | **内容は一致。ただし仮定 $d\ge2$ が落ちている → F-5** |
| 4 | `paper_030_...` proof | LSV の $\mathsf P_\Gamma$ と本論文の $a^{\mathrm{red}}_L$ は $c_\Gamma(f)$ だけずれ、$\frac1{|\mathbb Z^d/\Gamma|}\log c_\Gamma(f)\to0$ なので漸近的に一致 | cycle13 §191 が同じ差（$c_\Gamma(f)$ 因子）を明示 | **一致** |
| 5 | `paper_032_remark_ising_known` | Viswanathan: 特殊温度で Hasse–Weil $L$、臨界点で Dirichlet $L$ | arXiv abstract（本レビューで再取得）が逐語でそう述べている | **一致**（ただし本文未読の印が無い → F-6） |
| 6 | `paper_05x`（命題 D の proof） | Monsky *On p-adic power series* **Theorem 5.6** | cycle16 §3.1 の原文書き写し（p.226）: 「… is a polynomial with rational coefficients in $n$ and $p^n$, having degree $\le1$ in $n$, and total degree $\le d$」 | **一致** |
| 7 | 同 | Cuoco–Monsky **Theorem 1.7** | cycle16 §3.2 の原文書き写し（p.238）: 「$\Sigma_n(F)=(m_0p^n+l_0n+O(1))p^{(d-1)n}$」 | **一致** |
| 8 | 同 | Cuoco–Monsky **p.237 の規約 $\mathrm{ord}\,0=0$**（「usual ではない」） | cycle16 §3.2 の原文: 「It is convenient to make the **unusual convention** that $\mathrm{ord}\,0=0$.」 | **一致**（「which is not the usual one」まで原文どおり） |
| 9 | 同 | 「Monsky の定理はグラフに限定されない」（任意の $f\in\mathbb{Z}_p[[\Gamma]]$ と半代数的 $S$） | cycle16 の Thm 5.6 原文（$X\subset W^d$ semi-algebraic、$F\in\mathcal O[[X_1,\dots,X_d]]$）と Def 3.1 | **一致** |
| 10 | 同 | Kataoka **Thm 2.1 / Thm 2.3** が Monsky Thm 5.6 / Cuoco–Monsky Thm 1.7 の引用形であり、原典と一致する | cycle16 §3.3 の突合表（4 行すべて「一致」） | **一致** |
| 11 | 同 | グラフとして実現できる $P$ は $P=h+\iota(h)$ で $h$ が **Kataoka Definition 6.1** の意味で admissible なもの | `refs.bib` の `Kataoka2026` note: 「グラフの $\kappa$ として実現できる $P$ には **Definition 6.1** の制約があることを確認した」（§4–§6 全 28 ページ読了） | **一致** |
| 12 | `paper_054_remark_limits` (i) | Monsky *On p-adic power series* **p.227, Remark 2** が「$m_0$ と $l_0$ 以外の係数は mysterious」と明記 | cycle16 §3.1 の原文（p.227, Remark 2 末尾）: 「**The other coefficients remain mysterious.**」 | **一致** |
| 13 | `paper_05x`（命題 G の proof, (G3)） | (G3) の値は DuBose–Vallières 既出 | cycle17 §5.4: §7 例 (1)（$\ell=2$、$2^n\times2^n$ トーラス塔）に $\mathrm{ord}_2(\kappa_n)=2n2^n+4\cdot2^n-6n-1$（$1\le n\le10$）を原文で確認 | **一致** |
| 14 | 同（(G4) の prior art） | $\ell=3$ の値は DuBose–Vallières **§7, Example (4)** に既出、そこは 5 層からの数値フィットで著者自身が証明でないと明言 | `cycle17_T3_degenerate_torus_odd_ell.md:275,463`: 「DuBose–Vallières §7 例 (4)（本文取得済み）は $\ell=3$ のトーラスについて … $4\cdot3^n-2n-4$（$1\le n\le7$）」。フィット自認は cycle17 §5.2 の原文引用「we have not tried to prove that those numbers are the Greenberg coefficients」 | **一致**（例番号 (1) と (4) の使い分けも正しい） |
| 15 | `paper_061`（命題 V の proof） | **Byszewski–Graff–Ward Definition 2.1** で $n=p$ と取ると $a_p\equiv a_1\pmod p$ | cycle17 §4.1 の原文引用（Def 2.1 と直後の記述） | **一致** |
| 16 | 同 | 差分は「$a_L=0$ を許し、$d$ 任意で無条件」の一点だけ | cycle17 §4.2 / §7-2（敵対的レビューで「完全に既出」から弱めた記録） | **一致**（弱めた結論のまま書かれている） |
| 17 | `paper_062_theorem_T` の proof | **Mednykh 系 Theorem 5.1**（奇 $n$ で $\tau(n)=n\tau(H)a(n)^2$）、**§7.6** が離散トーラス $C_L\times C_L$、ゆえに $v_2(\tau(L))$ は偶数 | cycle17 §3.1 の原文書き写しと導出（$H=C_m$、$\tau(H)=m$、$n=m=L$） | **内容は一致。著者名が誤り → F-1** |
| 18 | 同 | 等号 $2(L-1)$ 自体は見つからなかった／$L=3,\dots,13$ で厳密整数計算により整合確認 | cycle17 §3.2 と §3.1 の表（$L=3,5,7,9,11,13$） | **一致** |
| 19 | `paper_063`（命題 W の proof） | **Vallières Corollary 5.7** が $d=1$ で「非退化⇒閉形式」 | cycle17 §5.1（arXiv:2006.14012 §5.5–5.6 を読了） | **一致** |
| 20 | 同 | **Kataoka §4.3** が $\lambda_1,\mu_1,\nu$ の同定を「本論文では追わない」と明記 | cycle17 §5.2 の原文引用: 「… **which we do not pursue in this paper**.」 | **一致** |
| 21 | 同 | **Monsky 1989 Theorem 3.13**: $e_n=(m_0p^n+\ell_0n+\alpha^*)p^{(d-1)n}+O(np^{(d-2)n})$、$\alpha^*$ は**存在と（$d=2$ での）有理性のみ** | cycle18 §2.2 の原文書き写し（p.330）: 「Then there is a real number $\alpha^*$ such that … **When $d=2$, $\alpha^*$ is rational.**」 | **一致** |
| 22 | 同 | Monsky が Introduction で「$\alpha^*$ に easy な記述は無く、常に有理数かどうかも分からない」と書いている | cycle18 §2.1 の原文: 「**There is no easy description of $\alpha^*$ and in particular we do not know if it is always rational.**」 | **一致** |
| 23 | 同 | 明示的に同定されている係数は $p^{dn}$ と $np^{(d-1)n}$ の 2 つだけ（**Theorem 1.20**） | cycle18 §0 の表・§2.3: 「**Theorem 1.20 が明示的に同定しているのは $p^{dn}$ の係数 $m_0(F)$ と $np^{(d-1)n}$ の係数 $\ell_0(F)$ の 2 つだけ**」 | **一致** |
| 24 | 同 | **Tateno–Ueki Theorem 2.3** が Monsky を Thm 3.13 と番号指定で引用し、存在と $d=2$ の有理性だけを記録している | cycle18 §2.5 の原文引用（当該定数を文字どおり $\mu_1$ と呼んでいる） | **一致** |
| 25 | `paper_072_remark_qp_motivation` | $\mathbb{Q}_p$ の一階理論は**決定可能**（Ax–Kochen / Ershov）。動機は決定不能性ではない | cycle17 §2.2-5。Ax–Kochen 第 III 部の題名が "Decidable Fields" であることは Crossref で確認 | **一致**（本文未読を装った記述は無い） |
| 26 | 同 | **Alonso García–Lombardi–Perdry** が完備化を経由せず Henselization を構成する | cycle17 §2.2-2（Introduction を確認） | **一致**（本文は Introduction までしか読んでいないが、帰している内容も Introduction の宣言部に収まる） |
| 27 | `paper_092_remark_prior_art_countabilisation` | Haskell について「we have not read this paper; we know it from its review only」 | cycle17 §1 の表: Haskell は「**本文未確認**（zbMATH のレビュー文のみ確認）」 | **一致**（未読であることを本文が正しく明示している） |

### cycle 18 の最新判定との一致（検証項目 4）

英語版限定の先行研究章 `content/008_prior_art.ts` を含め、**Monsky 1989 に言及する 4 箇所すべて**が
cycle 18 の判定になっている。cycle 17 の「未取得」が残っている箇所は **0 件**である。

| ブロック id | 記述 |
|---|---|
| `paper_093_remark_prior_art_propositions`（008, 英語版限定） | 「Monsky [15] **was obtained and read** (the Project Euclid copy is Open Access; an earlier check had **misdiagnosed a bot-blocking page as a subscription wall**)」 |
| `paper_063`（命題 W の proof, 006） | 「(iii) We have **read the text** of Monsky … (in the Open Access version on Project Euclid)」 |
| `paper_remark_scope`（007） | 「**we have read the text of Monsky (ASPM 17, 1989) in the Open Access version**」 |
| `paper_05x`（命題 G の proof, (G4), 005） | 「we have read the text of Monsky (ASPM 17, 1989) … in the Open Access version」 |

`008_prior_art.ts` のファイル冒頭コメント（21–23 行目）も
「**cycle 18 の判定が最新である。** cycle 17 の『Monsky 1989 は未取得』は … で解消済み」と明記しており、
実装と一致している。さらに `paper_094_remark_prior_art_limits` が調査手段の限界
（MathSciNet 未使用・arXiv は abstract 検索）を落とさずに書いており、cycle 17 §1・§2.3 と整合する。

**逆方向（確認済みなのに過度に慎重）の箇所も探したが、該当は無かった。**
「we did not find」「we do not conclude that none exists」という書き方は、
cycle 17 §7-4 が明示した方針（0 件を新規性の根拠にしない）を意図的に反映したものであり、
過度な慎重さではなく方針の実装である。

---

## 4. `refs.bib` 全 23 エントリの状態

「引用」= 英語版本文の `cite` ノードから引かれているか（＝ PDF の参考文献に出るか）。
「書誌の一次照合」= 本レビューで Crossref API / arXiv API / zbMATH Open API を叩いて突合した結果。

| # | キー | 引用 | 書誌の一次照合 | 照合に使った一次情報と結果 |
|---|---|---|---|---|
| 1 | `LindSchmidtWard1990` | ✅ | ✅ 一致 | zbMATH「Invent. Math. **101**, No. **3**, **593-629** (1990)」/ 著者 Lind, Schmidt, Ward。DOI 10.1007/BF01231517 は Crossref で解決。**注: Crossref は issue を 1 と返すが、これは Crossref 側のメタデータ誤り**（zbMATH と Springer の頁割りが No. 3 を支持）。`refs.bib` の `number = {3}` が正しい |
| 2 | `LindSchmidtVerbitskiy2013` | ✅ | ✅ 一致 | Crossref（DOI 10.1017/S014338571200017X）: ETDS **33**(4), **1060-1081**。arXiv:1108.4989 の journal_ref「Ergodic Theory & Dynam. Systems 33 (2013), No. 4, 1060-1081」 |
| 3 | `Viswanathan2024` | ✅ | ✅ ほぼ一致 | Crossref（DOI 10.1103/PhysRevE.110.054134）: Phys. Rev. E **110**(5), 2024, 著者一致。**論文番号 054134 は Crossref の `page` が空**なので DOI の末尾でのみ確認（PRE の慣行として整合） |
| 4 | `Kataoka2026` | ✅ | ✅ 一致 | arXiv API: arXiv:2606.03579、題名・著者一致、2026-06-02、28 pages、**journal_ref / DOI ともに無し**（未出版であることを確認） |
| 5 | `Monsky1981` | ✅ | ✅ 一致 | Crossref（DOI 10.1007/BF01450672）: Math. Ann. **255**(2), **217-227**, 1981, Monsky Paul |
| 6 | `CuocoMonsky1981` | ✅ | ✅ 一致 | Crossref（DOI 10.1007/BF01450674）: Math. Ann. **255**(2), **235-258**, 1981, Cuoco & Monsky |
| 7 | `MonskySomeInvariants1981` | ❌ 未引用（意図的） | ✅ 一致 | zbMATH「Math. Ann. **255**, **229-233** (1981)」。**号と DOI は依然として未確認**（zbMATH に登録が無い。`refs.bib` の note が「未確認」と書いているのは正しい） |
| 8 | `Deninger2009` | ❌ 未引用 | ✅ 一致 | Crossref（DOI 10.1007/978-0-8176-4745-2_10）: Progress in Mathematics, **423-442**, 2009。**シリーズ巻 269 は Crossref が返さない**ので未照合 |
| 9 | `Ueki2020` | ❌ 未引用 | ✅ 一致 | Crossref（DOI 10.1017/etds.2018.35）: ETDS **40**(1), **272-288**（Crossref の issued は online first の 2018。掲載年 2020 は arXiv journal_ref と zbMATH による、と note が明記） |
| 10 | `Vallieres2021` | ✅ | ✅ 一致 | Crossref（DOI 10.1007/s40316-020-00152-4）: Ann. math. Québec **45**(2), **433-452**, 2021, Vallières Daniel |
| 11 | `McGownVallieres2024` | ❌ 未引用 | ✅ 一致 | Crossref（DOI 10.1007/s40316-022-00194-w）: Ann. math. Québec **48**(1), **1-19**。Crossref の issued は online first の 2022。掲載年 2024 は zbMATH による、と note が明記 |
| 12 | `DuBoseVallieres2023` | ✅ | ✅ 一致 | Crossref（DOI 10.5802/alco.304）: Algebraic Combinatorics **6**(5), **1331-1346**, 2023, DuBose & Vallières |
| 13 | `Lehmer1933` | ✅ | ✅ 一致 | zbMATH「Ann. Math. (2) **34**, **461-479** (1933)」。Crossref（DOI 10.2307/1968172）も 34(3), 1933 |
| 14 | `FerreroWashington1979` | ✅ | ✅ 一致 | Crossref（DOI 10.2307/1971116）: Ann. of Math. **109**(2), 1979, 先頭頁 377（頁範囲 377–395 は zbMATH による、と note が明記） |
| 15 | `AxKochen1966` | ✅ | ✅ 一致 | Crossref（DOI 10.2307/1970476）: Ann. of Math. **83**(3), 1966, 先頭頁 437, 題名「Diophantine Problems Over Local Fields: III. Decidable Fields」。**巻・年・著者・第 III 部であることまで一致** |
| 16 | `Ershov1965` | ✅ | ✅ 一致 | zbMATH「**Algebra Logika 4, No. 3, 31-70 (1965)**」。note が併記する「Sov. Math., Dokl. **6**, **1390-1393** (1965)」も zbMATH で確認。**DOI は zbMATH に登録が無く、依然として未確認**（推測で埋めていないのは正しい） |
| 17 | `ByszewskiGraffWard2021` | ✅ | ✅ 一致 | Crossref（DOI 10.1112/blms.12531）: Bull. LMS **53**(5), **1263-1298**, 2021, Byszewski/Graff/Ward。**`refs.bib` に DOI が無い → F-8** |
| 18 | `MednykhMednykh2019` | ✅ | ❌ **不一致** | arXiv API: 著者は **Young Soo Kwon, Alexander Mednykh, Ilya Mednykh**（3 名）。Crossref: **J. Algebraic Combin. 53(1), 115-129, DOI 10.1007/s10801-019-00921-7**（出版済み）。**→ F-1（致命的）** |
| 19 | `TatenoUeki2025` | ✅ | ✅ 一致 | arXiv:2401.03258 の journal_ref「**J. Lond. Math. Soc. 2025**」と `arxiv:doi` **10.1112/jlms.70183**。**巻・頁・DOI が `refs.bib` に無い → F-8** |
| 20 | `Wan2017` | ❌ 未引用 | ✅ 一致 | arXiv API: arXiv:1712.02906、題名・著者（Daqing Wan）一致、**journal_ref / DOI は無し**（未出版のまま。`refs.bib` が「arXiv preprint」としているのは正しい）。**注: cycle 17 §6 の表が「Wan (J. Number Theory 203 (2019) 139–154)」と書いているが、arXiv には journal_ref が無く、本レビューでは出版を確認できなかった。`refs.bib` の現状（プレプリント扱い）のほうが安全側である** |
| 21 | `Monsky1989` | ✅ | ✅ 一致 | Crossref（DOI 10.2969/aspm/01710309）: 題名「Fine Estimates for the Growth of $e_n$ in $Z_p^d$-Extensions」/ Adv. Stud. Pure Math. / **pages 309-330** / Monsky P.。**シリーズ巻 17 は Crossref が返さない**ため、cycle 18 が取得した PDF（22 ページ = 309–330）と `refs.bib` の note で確認 |
| 22 | `AlonsoLombardiPerdry2008` | ✅ | ✅ 一致 | Crossref・zbMATH ともに MLQ **54**(3), **253-271**, 2008。**著者名の姓「Alonso García」は arXiv:2202.06595 の著者自身のメタデータ（"Alonso García, M. Emilia"）で確認**（Crossref/zbMATH は索引の都合で "Alonso, María E." と短縮している）。arXiv の journal_ref も「Mathematical Logic Quarterly. Vol 54, No 3, p. 253--271. (2008)」で一致。**DOI 10.1002/malq.200710057 が `refs.bib` に無い → F-8** |
| 23 | `Haskell1992` | ✅ | ⚠️ 一部不一致 | Crossref（DOI 10.1016/0168-0072(92)90033-V）: APAL **58**(1), **29-55**, 1992, Haskell Deirdre。**`refs.bib` に巻・号・頁が無い → F-3**（書いてある年・誌名・DOI は一致） |

### 照合できなかったもの（推測で埋めていない）

本レビューではネットワークへ出られたので、Crossref API・arXiv API・zbMATH Open API を実際に叩いて照合した。
そのうえで、**次の項目は照合できなかった**。

| 項目 | なぜ照合できなかったか |
|---|---|
| `Ershov1965` の DOI | zbMATH に DOI の登録が無い。Crossref でも該当が引けない（1965 年のソ連誌）。**`refs.bib` が「未確認」と書いているのが正しい** |
| `MonskySomeInvariants1981` の号（issue）と DOI | zbMATH が「Math. Ann. 255, 229-233 (1981)」までしか返さず、DOI が無い。未引用エントリなので投稿稿には影響しない |
| `Deninger2009` のシリーズ巻 269 / `Monsky1989` のシリーズ巻 17 | Crossref が書籍シリーズの巻番号を返さない。前者は zbMATH（note の記載）、後者は cycle 18 が取得した PDF の頁範囲で間接的に整合を確認したにとどまる |
| `Viswanathan2024` の論文番号 054134 | Crossref の `page` が空。DOI 末尾（`PhysRevE.110.054134`）との整合でしか確認していない |
| **Lind–Schmidt–Verbitskiy の Theorem 1.2 / 1.3、Vallières の Corollary 5.7、Mednykh 系の Theorem 5.1 / §7.6 の番号が、出版版でも同じ番号かどうか** | **これらの番号は、いずれも一次記録が arXiv 版を読んで取ったものである**（cycle 13 表 B は arXiv:1108.4989v2、cycle 17 表は arXiv:2006.14012 と arXiv:1902.05681）。本レビューは出版版の本文を取得しておらず、**出版版で番号が一致するかは確認できていない。** 地の文はいずれも arXiv ID を明記して引いている（`003_archimedean.ts:69`、`006_propositions_TVW.ts:499,309`）ので現状でも辿れるが、参考文献リストは出版版を指しているため、**番号だけを見た読者が出版版で照合すると食い違う可能性が残る** |
| Monsky 1981 の §1・§2・§4、Cuoco–Monsky の §3–§7 の内容 | 一次記録（cycle 16 §5）自身が「未読」と明記している。本文はこれらに依存した主張をしていない（Thm 5.6 / Thm 1.7 の**言明**のみを使っている）ので、投稿稿の瑕疵ではない |

---

## 5. `refs.bib` の note の扱いと、投稿時に提出する `.bib` の評価（検証項目 2 後半）

### 現状の導出方式

`tools/build-latex.ts:44–110, 209–231` が、正本 `refs.bib` から
**`note` フィールドと `%` 行だけを落とした** `build/refs.generated.bib` を毎ビルド生成する
（正本には書き込まない。`build/` は gitignore 済み）。

### 実測した結果

- `build/refs.generated.bib`: **23 エントリすべてが残り、`note` フィールドは 0 件**（`grep` で確認）。
- 生成器は「`note` を落とした後に非 ASCII が 1 文字でも残れば例外を投げる」検査を持ち、実際に通っている。
- PDF 側: `Missing character` 警告 0 件、参考文献 18 件が正常に組まれている。

**したがって「日本語の内部来歴メモが投稿稿へ漏れる」問題は起きていない。導出方式は目的を達している。**

### それでも投稿前に決めるべきこと

1. **提出する `.bib` は `build/refs.generated.bib`（または `build/document.bbl`）であって、正本 `refs.bib` ではない。**
   正本には日本語の note が入っているので、**間違って正本を提出しないこと**。
   投稿手順書（`outputs/papers/001_R_Lambda_duality/` 配下）にこれを明記するのが安全である。
   Elsevier は `.bbl` の同梱を受け付けるので、`build/document.bbl` を出すのが最も事故が少ない。
2. **導出物のヘッダ 2 行に日本語が残っている**（F-9）。PDF には影響しないが、英語に直すのが安全。
3. **`note` を落とす方式の副作用**: 投稿稿で `note` に書きたい情報（プレプリントの arXiv ID 等）も
   一緒に落ちる。これが F-4（Kataoka の arXiv ID が印字されない）の原因である。
   `note` を「日本語メモ専用」と決めているなら、**投稿稿向けの情報は `journal` / `howpublished` /
   `doi` フィールドに置く**という規約を明文化すべきである。

**総合評価: 現状の導出方式に投稿を妨げる欠陥は無い。** ただし上記 3 点（とくに 1 と 3）を
運用ルールとして固定しないと、次に `refs.bib` を触った人が同じ罠を踏む。

---

## 6. 呼び出し元への引き継ぎ

本レビューは**報告ファイル 1 本のみ**を作成し、他は一切変更していない
（`git status` で確認済み。`build/` は gitignore 対象）。

修正の適用は後続の校閲担当が行う想定で、優先順は次のとおり。

1. **F-1**（Kwon の欠落。`refs.bib` 1 エントリ + 地の文 3 箇所）— **投稿前に必須**
2. **F-2**（題名の小文字化。`refs.bib` の title 5 件に波括弧）— **投稿前に必須**
3. **F-3**（Haskell の巻・号・頁）— **投稿前に必須**
4. **F-5**（LSV Thm 1.2/1.3 の $d\ge2$。英語版と日本語版の両方）— **投稿前に必須**
5. F-4（Kataoka の arXiv ID）/ F-6（Viswanathan の未読明示）/ F-8（DOI 4 件）— 推奨
6. F-7（`refs.bib` 冒頭コメントの引き直し）/ F-9（導出物ヘッダの英語化）— 推奨

修正後は `(cd integrable-lattice/structured-latex-en && npm run check && npm run build:pdf)` を
再実行し、「未定義引用 0 件」と参考文献件数を再確認すること。

なお `refs.bib` を読んでいるのは**英語版の生成器だけ**である
（日本語版 `structured-latex/tools/build-latex.ts` は書誌を地の文で持ち、`refs.bib` を読まない。
同ファイル 407 行のコメントがそう述べており、`grep` でも参照が無いことを確認した）。
したがって `refs.bib` の修正は日本語版のビルドに影響しない。
ただし **F-5 は英語版と日本語版の両方の本文に存在する**ので、そちらを直す場合は
`(cd integrable-lattice/structured-latex && npm run check)` も併せて通すこと
（英語版には日英対応検証があるため、片方だけ直すと落ちる可能性がある）。
