# cycle 16 step 4（運用）— refs.bib の整備と Lean 形式化の拡張

- 日付: 2026-07-31
- 対応する step: `auto-loop-state.md` cycle 16 #4 `refs_bib_and_lean_extension`
- 閉じる対象: `outputs/papers/001_R_Lambda_duality/notes.md` の「未完了作業」2（Lean 形式化の完了範囲）と 3（refs.bib）
- 位置づけ: **運用 step であって、新しい数学的主張はしていない。** 形式化した命題はいずれも既知内容の再框であり、
  新規性は主張しない。

---

## 0. 結論（先に）

| 項目 | 結果 |
| --- | --- |
| `lake build` | **成功**。`Build completed successfully (8663 jobs).` / `BUILD_EXIT=0`（`lean/logs/build-cycle16-final.log`） |
| `scripts/check-no-sorry.sh` | **成功**。ソース中に `sorry`/`admit` 無し、列挙した **46 個**の定理がいずれも `sorryAx` 非依存 / `CHECK_EXIT=0`（`lean/logs/check-no-sorry-cycle16.log`） |
| 命題 C | **部分的 → 完了（整除方向）** へ前進。`PropCPeriod.lean` を追加 |
| 命題 B | **未着手 → 部分的**（片方向のみ）へ前進。`PropB.lean` を追加 |
| 命題 N・T・W | **未着手のまま**。mathlib 欠落を 3 段 grep で再確認した |
| refs.bib | 16 エントリで整備。**書誌の推測補完は 0 件**。未確認項目はコメントで明示 |
| **自己訂正** | **旧 `lean/README.md` の記述に誤りを 2 件見つけて訂正した**（§3） |

---

## 1. Lean 形式化の拡張

### 1.1 追加したもの

**`IntegrableLattice/PropCPeriod.lean`（命題 C の残り。整除方向を閉じた）**

従来 `PropC.lean` は「還元 $GL_d(\mathbb{Z}/p^k)\to GL_d(\mathbb{Z}/p)$ の核の指数が $p^{k-1}$ を割る」という
**代数的核**だけを形式化しており、README は命題 C を「部分的」としていた。残っていたのは
(i) 仮定 $U\equiv I \pmod p$ を還元写像から実際に取り出す段、(ii) 周期を定義して整除を結論する段、
(iii)「$p\nmid\det T$ なら純周期的だから最終周期＝位数」の段である。この 3 つを形式化した。

| 定理 | 内容 |
| --- | --- |
| `eq_natCast_mul_of_castHom_eq_zero` | $x\in\mathbb{Z}/p^k$ が mod $p$ で $0$ なら $x=p\cdot y$。商を `x.val / p` として**明示的に構成**（選択公理を使わない） |
| `matrix_eq_natCast_mul_of_map_castHom_eq_zero` | その行列版 |
| `matrix_pow_mul_prime_pow_eq_one` | $\bar A^m=I \Rightarrow A^{mp^{k-1}}=I$ |
| `orderOf_dvd_mul_prime_pow` | $\operatorname{ord}(A)\mid\operatorname{ord}(\bar A)p^{k-1}$ |
| `orderOf_reduction_dvd` | **$\pi(p,k)\mid\pi(p,1)p^{k-1}$**（整数行列 $T$ の形） |
| `isUnit_pow_add_eq_iff` | $A$ 可逆なら $A^{N+t}=A^N\iff A^t=1$（純周期性の正当化） |
| `isUnit_intCast_of_not_dvd` / `isUnit_map_of_not_dvd_det` | $p\nmid\det T$ $\Rightarrow$ $T\bmod p^k$ 可逆 |

**形式化していないこと**: 等号（Wall 型 $\pi(p,k)=p^{k-1}\pi(p,1)$）。これは**人手証明のとおり一般には偽**で
（cycle 6 で六頂点 572 件中 4.5% の反例）、形式化の対象ではない。また「最終周期の最小値」を
`Nat.find` 等で定義してはおらず、可逆性から最終周期の条件が $A^t=1$ と同値であることを示して
`orderOf` で述べる形を採った。

**`IntegrableLattice/PropB.lean`（命題 B の片方向）**

人手証明の主張は
$\pi(p,1)=\operatorname{lcm}\{\operatorname{ord}(\lambda):\lambda\ \text{相異固有値},\ p\nmid m_\lambda\}$
という**等式**である。このうち **lcm が $\pi(p,1)$ を割る側だけ**を形式化した。

| 定理 | 内容 |
| --- | --- |
| `mulVec_pow_eq_pow_smul` | $Av=\mu v\Rightarrow A^nv=\mu^nv$ |
| `eigenvalue_pow_eq_one_of_pow_eq_one` | $A^N=1$ かつ $\mu$ が固有値なら $\mu^N=1$ |
| `orderOf_eigenvalue_dvd_orderOf` | $\operatorname{ord}(\mu)\mid\operatorname{ord}(A)$ |
| `lcm_orderOf_eigenvalues_dvd_orderOf` | $\operatorname{lcm}_{\mu\in s}\operatorname{ord}(\mu)\mid\operatorname{ord}(A)$ |

この方向は**重複度の仮定 $p\nmid m_\lambda$ を必要としない**（どの固有値についても成り立つ）ので、
任意の体上で述べた。純代数の主張であり $\mathbb{R}$ へは脱出していない。

**弱くなる退化ケースを隠さず記す**: $\operatorname{ord}(A)=0$（$A$ が有限位数を持たない。例えば非可逆）のとき
$n\mid 0$ は常に真なので、この整除は情報を持たない。意味があるのは $A$ が可逆で位数有限のとき、
すなわち $p\nmid\det T$ かつ係数体が有限のときである。定理としては正しいが、
**退化ケースを含む形で述べてある**ことをファイル冒頭と README に明記した。

### 1.2 到達しなかったもの（命題 N・T・W）と、その理由

3 段 grep（§3 の方式）で mathlib v4.32.1 / commit `520045ab14e2` を走査（`Mathlib/**/*.lean` **8264 ファイル**）。
生ログ `lean/logs/mathlib-gap-survey-cycle16.log`。

- **命題 N（Newton 多角形）**: `NewtonPolygon` 内容 0 件、語幹 `newton` 内容 7 件・ファイル名 2 件。
  **7 件の中身を読んだ結果、すべて Newton–Raphson 法（`Dynamics/Newton.lean`, `Padics/Hensel.lean`,
  `RingTheory/Henselian.lean`）と Newton 恒等式（`NewtonIdentities.lean`）で、Newton 多角形は 1 件も無い。**
  → **無い**と判定。
- **命題 T・W（matrix-tree / 全域木数）**: `kirchhoff` は内容・ファイル名とも **0 件**。
  `spanning tree` は内容 3 件だが、中身は全域木の**存在**（`SimpleGraph/Acyclic.lean:457,464`）と
  arborescence であって**個数の公式ではない**。→ **無い**と判定。
- **命題 W（岩澤型漸近）**: `iwasawa` 語幹で 6 件当たるが、中身を読むと **5 件は群論の
  「Iwasawa 単純性判定法」**（`GroupTheory/GroupAction/Iwasawa.lean` 系）、
  **残り 1 件は `NumberTheory/Padics/Measure/Basic.lean` の docstring が岩澤代数に言及しているだけ**で、
  $\mu,\lambda$ 不変量もその漸近も定義されていない。→ **無い**と判定。
  なお命題 W の人手証明は、自分自身が `cycle14_T3_two_variable_criterion.md` §0 で
  「上界方向は**自前では証明できなかった**、Cuoco–Monsky の定理そのものである」と認めているので、
  仮に mathlib に道具があっても形式化は外部定理の引き写しになる。

---

## 2. refs.bib の整備

`outputs/papers/001_R_Lambda_duality/refs.bib` を **16 エントリ**で整備した（brace balance 0、キー重複 0）。

### 方針（守ったこと）

- **書誌を推測で埋めていない。** 巻・号・頁・年・DOI・arXiv 番号は、arXiv API の `journal_ref`/`doi`、
  zbMATH Open、Crossref、または取得済み PDF・ページ画像で確認したものだけを書いた。
  確認できなかった項目は**空欄にせず、コメントで「未確認」と明記**した
  （例: Ershov1965 の DOI、Kataoka2026 の掲載誌、MonskySomeInvariants1981 の号と DOI）。
- **書誌を確認したことと、本文を読んだことを区別した。** 各エントリの `note` に
  「本文のどこまで読んだか」を書いた。**abstract しか見ていないものは「本文未読」と書いてある**
  （Viswanathan2024, Vallieres2021, Lehmer1933, FerreroWashington1979, AxKochen1966, Ershov1965）。

### この step で直した点

1. **Monsky1981 / CuocoMonsky1981 の note が「原論文の本文は未取得・未確認」のままだった。**
   cycle 16 step 1 が GDZ の IIIF で原論文本文を取得・確認済みなので、**事実と食い違っていた**。
   実際に読んだ範囲（Monsky: Def 3.1 / Thm 3.4 / Thm 5.5 / Thm 5.6 / Remark 1,2 / References。
   Cuoco–Monsky: Introduction と §1 全体と §2 冒頭）と、**読んでいない範囲**
   （Monsky §1・§2・§4、Cuoco–Monsky §3–§7）を両方書いた。
2. **Kataoka2026 の note が「§4–§6 は未読」のままだった。** step 1 で全 28 ページ読了しているので訂正し、
   併せて Proposition 4.4 から本文の数式の誤りを検出・訂正した経緯を書いた。
3. **`MonskySomeInvariants1981` を新設した。** 本文では引用しないが、
   **本プロジェクトが cycle 15 まで Theorem 5.6 の出典をこの論文だと誤同定していた**ので、
   同じ誤りを再発させないための控えとして置いた。全 5 ページ通読して §5 も Thm 5.6 も
   存在しないことを確認済みである旨と、正しい出典が `Monsky1981`（*On p-adic power series*,
   Math. Ann. 255(2), 217–227, 1981）である旨を note に書いた。
4. **本文との対応表をヘッダに追加した。** `structured-latex/content/*.ts` を grep して、
   現在の本文が実際に言及している 10 件と、背景として控えてあるだけの 6 件を区別した。

### 残る限界

- **`Deninger2009` / `Ueki2020` / `Vallieres2021` / `McGownVallieres2024` / `DuBoseVallieres2023` は、
  現在の本文が言及していない。** bibtex は `\cite` されない限り出力しないので害は無いが、
  「参考文献に挙がっているのに本文に出てこない」状態が投稿時に残らないよう、
  本文側で引くか控えから落とすかの判断が要る（**本文の編集はこの step の担当外**）。
- `Ershov1965` は**ロシア語原論文を取得していない**。DOI も zbMATH Open に登録が無く未確認。
- `Kataoka2026` は**未出版のプレプリント**で、掲載誌は 2026-07-31 時点で未確認。

---

## 3. 自己訂正 — 旧 `lean/README.md` に誤りが 2 件あった

**この step で最も重要な発見はこれである。** 敵対的レビュー（自分の過去の結論を反証しにいく）として
旧調査スクリプトの方式を検算したところ、**旧 `mathlib-gap-survey.sh` の方式が偽陰性を生んでおり、
それが README の記述を 2 箇所で誤らせていた**ことが分かった。

旧スクリプトは**キャメルケース連結語をファイル内容にだけ grep** していた。

### 誤り 1: 「Weierstrass 準備定理」の判定根拠が偽陰性だった

`WeierstrassPreparation` の内容 grep は **0 件**である。しかし
`Mathlib/RingTheory/PowerSeries/WeierstrassPreparation.lean` は**実在する**。
中身の宣言名が `IsWeierstrassDivisionAt` / `IsWeierstrassFactorizationAt` /
`exists_isWeierstrassDivision` 等で、"WeierstrassPreparation" という連続文字列が
ファイル内に一度も現れないだけであった。

（旧 README の結論「Weierstrass 準備定理は mathlib にある」自体は**正しかった**。
別経路で確認していたためである。誤っていたのは調査方法であり、
**同じ方法で出した他の 0 件も信用できない**ことを意味する。）

### 誤り 2: 命題 B の「未着手」理由が事実に反していた

旧 README は命題 B について
「**mathlib には固有値の重複度を $\overline{\mathbb{F}_p}$ 上で扱う直接の API が無く**、
`Polynomial.roots` と分解体を自前で組む必要がある」
と書いていた。**これは誤りである。** 一次確認の結果、必要な部品はすべて mathlib v4.32.1 に存在する。

| 必要なもの | mathlib での所在 |
| --- | --- |
| 代数的重複度 | `Polynomial.rootMultiplicity`。`LinearAlgebra/Eigenspace/Zero.lean:211`（`finrank_eigenspace_le`）が `φ.charpoly.rootMultiplicity μ` をまさに「algebraic multiplicity」と呼んでいる |
| 半単純性の判定（十分条件） | `Module.End.isSemisimple_of_squarefree_aeval_eq_zero`（`LinearAlgebra/Semisimple.lean:221`） |
| 半単純性の判定（必要条件） | `Module.End.IsSemisimple.minpoly_squarefree`（同 246） |
| 代数閉体上の固有空間分解 | `Module.End.IsSemisimple.iSup_eigenspace_eq_top`（`LinearAlgebra/Eigenspace/Semisimple.lean:79`） |

**したがって命題 B の逆方向が未形式化なのは、mathlib の欠落のせいではなく、
単に本 step で組み立てをやっていないからである。** 残る作業は
行列 → `Module.End` への移送、$\mathbb{F}_p\to\overline{\mathbb{F}_p}$ への係数拡大、
「$\chi_T$ の各重根の重複度が $p$ と素 $\Rightarrow$ minpoly が squarefree」の導出、
そこから固有空間分解を経て $A^{\mathrm{lcm}}=1$ を出す段である。README をこの通りに書き直した。

### 是正した方式

現行 `scripts/mathlib-gap-survey.sh` は各概念について必ず 3 つを取る。

1. 連結語のファイル**内容** grep（その綴りの識別子があるか）
2. 語幹の **case-insensitive** 内容 grep（別綴り・分割綴りを拾う）
3. 語幹の case-insensitive **ファイル名**検索（宣言名とファイル名が食い違う場合を拾う）

**(2)(3) がともに 0 のときにだけ「無い」と書く。** 0 でないときはヒットの中身を読んで判定する。
§1.2 の判定はすべて中身を読んだ結果である。この注意はスクリプト冒頭のコメントにも書いた。

---

## 4. 一次情報（この step で実行したもの）

| ログ | 内容 |
| --- | --- |
| `lean/logs/cache-get-cycle16.log` | `lake exe cache get`。`Completed successfully in 76454 ms!` / `CACHE_EXIT=0` |
| `lean/logs/build-cycle16-final.log` | 最終の `lake build`。`Build completed successfully (8663 jobs).` / `BUILD_EXIT=0` |
| `lean/logs/build-cycle16-propB.log` | `PropB` 追加時の `lake build`。`BUILD_EXIT=0` |
| `lean/logs/build-cycle16-baseline.log`, `-2.log`, `-3.log` | `PropCPeriod` を通すまでの失敗ログ 2 本と成功ログ 1 本（是正の経過を残すため保存） |
| `lean/logs/check-no-sorry-cycle16.log` | `scripts/check-no-sorry.sh`。46 定理が `sorryAx` 非依存 / `CHECK_EXIT=0` |
| `lean/logs/mathlib-gap-survey-cycle16.log` | 3 段方式に是正した欠落調査の生ログ（8264 ファイル走査、mathlib `520045ab14e2`） |

## 5. この step でやっていないこと（正直に）

- **命題 B の等式（逆方向）は形式化していない。** 上記のとおり mathlib の欠落ではなく、作業をしていない。
- **命題 N・T・W は未着手のまま。** mathlib 欠落は再確認したが、欠落を自前で埋める作業はしていない。
- **論文本文（`structured-latex/`）は一切触っていない**（担当外）。本文へ反映すべき事項は
  呼び出し元へ別途申し送る。
- **`Ershov1965` のロシア語原論文、`Deninger2009` 以下 5 件の本文**は取得していない。
