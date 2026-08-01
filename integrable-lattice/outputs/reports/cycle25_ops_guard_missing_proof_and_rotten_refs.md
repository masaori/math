# cycle 25 / 運用: guard_missing_proof_and_rotten_refs — 証明の欠落と腐ったツール参照を機械検出する

日付: 2026-08-01 / track: 運用 / step: `guard_missing_proof_and_rotten_refs`

対象は cycle 24 総括が「検査で守られていない負債」として挙げた 2 種類である。

> 正直な限界: 本章は主張と限界だけで `proof` が空。原本の証明はまだ運んでいない。
> **転記検査は主張しか見ないので、この未了は赤にならない**（＝検査で守られていない負債である）。

> **「本文の文言を変えない」を守ると本文中のツール参照は自動では直らない。** 次サイクルの機械検出の対象。

**この step は `structured-latex/tools/` の 7 ファイルと `package.json` の検査段だけを触った。**
本文（`content/` と `locales/en/content/`）・`lean/`・`MEMORY.md`・`docs/tasks/auto-loop-state.md`・
既存の report は 1 バイトも書き換えていない（§10 に確認方法と出力）。

---

## 0. 結論（先に置く）

> 1. **検査 C（証明の欠落）と検査 R（腐ったツール参照）を新設し、`npm run check` の段に組み込んだ。
>    現状のリポジトリで両方とも緑である**（§9）。
> 2. **証明が空の定理型ブロックは 7 件だった**（§2）。cycle 24 総括が名指ししたのは第 11 章の 2 件だが、
>    **実測すると命題 G′・G″・J・K・R の 5 件が前から同じ状態だった。** 負債は 2 件ではなく 7 件である。
> 3. **腐ったツール参照は、免除で説明できないものが 0 件になるまで 1 件ずつ判定した。
>    そのうち 29 件は「本当に腐っている」**（実在しないものを現在形で指している）。
>    直すのが本 step の担当範囲外なので**記録して通しているだけで、直ったことにはならない**（§5）。
>    **この 29 件には、cycle 24 step 2 の手作業の訂正が取りこぼした 1 行が含まれている**
>    （`locales/en/content/005_duality.ts` の訳語集への相対パス）。**手で 12 ファイルを直した作業が、
>    同じファイル群の中で 1 件取りこぼしていた**——機械検出を入れる根拠そのものである。
> 4. **宣言（既知の未了・免除）は、腐ったら赤くなる。24 通りの壊し方で 24 件とも検出を実測した**（§7）。
>    「赤くなった」で満足しないため、**期待する違反の種類まで突き合わせている**
>    （cycle 24 step 3 §9.1 の教訓）。
> 5. **できないことを先に書く**（§8）。検査 R は**実在するかしか見ない**。
>    検査 C は**証明が空でないことしか見ない**。どちらも中身の正しさは見ない。

---

## 1. 前提の裏取り

| step の前提 | 一次情報での確認 | 判定 |
|---|---|---|
| 第 11 章（命題 M・U）は `proof` が空 | 本文を読み込んで `proof` を見た。2 件とも `proof` フィールドが無い | **正しい** |
| 転記検査はこの未了を赤にしない | `verify-transcription.ts` は `viewOf` で statement と proof を**同じ袋に入れて**「report の記号・語が本文に出るか」を見る。証明の有無という概念を持たない | **正しい** |
| cycle 24 step 2 が 12 ファイル分の腐りを踏んだ | `git show 6756584` が 12 ファイル＋`010_prior_art.ts` の計 13 ファイル 28 行を訂正している | **正しい** |
| 腐りは 3 種類（撤去済みツール・存在しない npm script・誤った相対パス） | 同コミットの削除行で 3 種類とも確認 | **正しい** |
| **未了は第 11 章の 2 件だけ** | **誤り。実測 7 件**（§2） | **前提が実態と食い違っていた** |

---

## 2. 証明が空の定理型ブロック（実測）

本文 46 ブロック（13 ファイル）のうち定理型は 34 件。そのうち `theorem` / `claim` は 23 件で、
**証明を持つのは 16 件、持たないのは 7 件**である。

| # | ブロック id | ラベル | 命題 | ファイル |
|---|---|---|---|---|
| 1 | `paper_055_theorem_theta_infinity` | `paper_prop_G_infty` | 命題 G′ | `content/005b_theta_infinity.ts` |
| 2 | `paper_056_theorem_ell2_family` | `paper_prop_G_ell2` | 命題 G″ | `content/005c_ell2_family.ts` |
| 3 | `paper_091_theorem_theta_padic` | `paper_prop_J` | 命題 J | `content/008_theta_padic.ts` |
| 4 | `paper_101_theorem_s_infinity_decision` | `paper_prop_K` | 命題 K | `content/009_s_infinity_decision.ts` |
| 5 | `paper_101_theorem_digit_branch` | `paper_prop_R` | 命題 R | `content/009_theta_recursion.ts` |
| 6 | `paper_111_theorem_general_closed_form` | `paper_prop_M` | 命題 M | `content/010_general_closed_form.ts` |
| 7 | `paper_112_theorem_coefficient_layers` | `paper_prop_U` | 命題 U | `content/010_general_closed_form.ts` |

**cycle 24 総括が名指ししたのは 6・7 の 2 件だけである。1〜5 は cycle 21 以前から同じ状態で、
どの総括にも「証明が無い」とは書かれていない。** 検査が無いと、負債はこう溜まる。

未了を記録する（宣言の根拠として機械検証される。§4）:

- `paper_055_theorem_theta_infinity`（命題 G′）は証明を持たない。原本は cycle 19 の定理 X′ にある。
- `paper_056_theorem_ell2_family`（命題 G″）は証明を持たない。原本は cycle 20 の定理 Y′ にある。
- `paper_091_theorem_theta_padic`（命題 J）は証明を持たない。原本は cycle 19 の定理 J2 にある。
- `paper_101_theorem_s_infinity_decision`（命題 K）は証明を持たない。原本は cycle 20 の定理 W3 にある。
- `paper_101_theorem_digit_branch`（命題 R）は証明を持たない。原本は cycle 20 の定理 L1 にある。
- `paper_112_theorem_coefficient_layers`（命題 U）は証明を持たない。原本は cycle 22 の定理 D1 にある。

（命題 M の未了は `cycle24_ops_reflect_g4_and_d_series.md` §9 が既に記録しているので、
宣言はそちらを根拠にしている。**新しく記録を起こさずに済むものは起こさない。**）

---

## 3. 「証明を持つべき」の定義と、その根拠

**定義: `kind` が `theorem` または `claim` のブロックは証明を持たなければならない。**

根拠は 3 つとも一次情報である。

1. **入力言語が持つ定理型の種別は 5 つだけ**（システムの `THEOREM_LIKE_KINDS`＝
   `theorem` / `definition` / `claim` / `remark` / `note`）。このうち**証明されるべき事柄を述べるのは
   `theorem` と `claim` だけ**である。`definition` は定義であって証明の対象ではなく、
   `remark` / `note` は注記である。
2. **現在の本文がその境界どおりに書かれている（実測）。** 定理型 34 ブロックのうち
   `proof` を持つ 16 ブロックは**すべて** `theorem` か `claim`、
   `definition` / `remark` の 18 ブロックは**1 つも** `proof` を持たない。
   つまりこの規則は新しい約束事ではなく、**すでに守られている区別を機械が読める形にしたもの**である。
   （もし境界がずれていれば、規則を入れた瞬間に 18 件の偽陽性が出ていたはずである。出ていない。）
3. リポジトリ CLAUDE.md の命名規則が type を `definition, claim, theorem, remark, note, heading` と
   列挙し、「正しさに必要ならそれは注記ではない」＝主張は `statement`、証明中の事柄は `proof` と定めている。

**「証明を持っている」の判定**は 4 通りの空を弾く: `proof` フィールドが無い／空配列／
TODO ノードを含む／地の文と数式を連結すると空白だけ。§7 の C-2 で 3 通りを実測した。

---

## 4. 宣言（既知の未了）の仕組みと、腐ったら赤くなること

7 件をそのまま違反にすると `npm run check` が落ちて他の作業が止まる。
cycle 24 step 3 が免除に対して採った方式に倣い、**根拠つきで宣言できるようにし、宣言が腐ったら赤くする。**

宣言 1 件が持つのは次の 2 つで、どちらも**型で必須**である（省くと `tsc` が落ちる）。

- `recordedIn` … その未了を記録している report と、**その一文**。
- `origin` … **原本の証明の在処**（report とその目印）。

機械検証するのは 6 つである。

| # | 何を見るか | 腐ると出る違反 |
|---|---|---|
| 1 | 宣言が指すブロックが本文に実在し、証明を要する種別であること | 宣言が指すブロックが本文に無い／証明を要さない種別 |
| 2 | **そのブロックがいまも証明を持っていないこと** | 宣言が余っている（証明が入った） |
| 3 | 記録 report が実在し、引用文が**ちょうど 1 行**に当たること | 未了の記録が見つからない／複数箇所に当たる |
| 4 | **その引用文が実際に未了を述べていること**（「証明」＋未了を表す語） | 記録が未了を述べていない |
| 5 | **原本の在処が転記検査の台帳（`source-links.ts`）と一致すること** | 原本の在処が転記検査の台帳と食い違う |
| 6 | **その report に原本の証明が実在すること**（目印が 1 か所に当たり、80 行以内に証明の書き出しがある） | 原本の目印が見つからない／原本にその証明が無い |

4 は cycle 24 step 3 の検査 A′ の「**その文から実際にその項目が出る**」に当たる。
これが無いと「report のどこか 1 行を pin しただけで未了の宣言が通る」＝根拠が根拠になっていない状態が緑で通る。

5 は**台帳との突き合わせ**である。転記検査の台帳が「このブロックの根拠は report X」と言っているのに、
宣言だけが「原本の証明は report Y にある」と名乗ることはできない。**2 つの台帳が別々に腐ることを防ぐ。**

6 が最も強い。**原本の証明が消えたら赤になる。**「本文へ運ぶ」という申し送りは、
運ぶ元があって初めて成立するからである。

宣言の件数と内訳は**毎回出力する**（黙って緑にしない。cycle 23 の「照合力 0 のブロック 5 件」、
cycle 24 の「機械検証できない免除 14 件」と同じ思想）。

**step 1 が原本を書き換えた直後に測っている。** 本 step の作業中に `origin/main` が 1 コミット進み
（`cd0734d`。step 1 が `cycle21_T3_general_closed_form.md` と `cycle21_T3_drop_assumption_B_star.md` を訂正）、
取り込んでから測り直したが、宣言 7 件はすべて生きていた（目印が節見出しなので節の中身の訂正では動かない）。
**「赤にならなかった＝訂正が原本の証明に触れなかった」であって、検査が弱い証拠ではない。**

---

## 5. 実在しない参照の実測と、その内訳

### 5.1 何を見て、どこを走査するか

見るのは 3 種類だけである。**いずれも「実在するか」しか見ない。**

1. **パス参照** … 相対パス・リポジトリ相対パスが実在するファイル／ディレクトリを指すこと。
2. **スクリプト名** … `npm run …` / `pnpm …` の名前が、その場所を治める package.json に実在すること。
3. **ファイル名** … 拡張子つきの裸のファイル名がリポジトリのどこかに実在すること。

**参照とみなすのは「バッククォートの中に書かれたもの」だけ**である。根拠は実測にある——
cycle 24 step 2 の腐りは **3 件とも**バッククォートの中に書かれていた。地の文まで広げると
「`sagemath/Lean` 投下可」のような言い回しが大量に偽陽性になる（**実測: 164 件 → 90 件 → 58 件**）。
TypeScript のソースでは import 文が範囲外になるが、**そちらは `tsc` が既に解決を検査する**ので取りこぼしではない。

走査範囲の根拠:

| 走査する | 根拠 |
|---|---|
| `structured-latex/content` · `structured-latex/locales` | **腐りが実際に起きた場所**（cycle 24 step 2） |
| `structured-latex/tools` · `schema.ts` · `locales.config.ts` | 検査道具どうしの参照。ツール名の変更で最初に腐る |
| `docs/` · `README.md` | 作業手順がここからツールを名指しする（runbook の `.mjs` 参照など） |

| 走査しない | 根拠 |
|---|---|
| `outputs/reports/` | **その時点の作業の記録**。当時実在したものを指す記述が現在実在しないのは腐りではない |
| `MEMORY.md` · `docs/tasks/auto-loop-state.md` | 同じ理由。追記専用の履歴で「当時 …、現在は …」が**実測 20 件**ある |
| `_old/` | 温存退避。外を指す参照が古いのは当然 |
| `sagemath/` · `lean/` · `inputs/` · `pipeline/` | 本 step の担当外。腐りの実例も無い。将来広げてよい |

**除外は黙って行わない。** 検査は毎回この一覧を理由つきで出力する。

### 5.2 実測

69 ファイル・参照 437 件を走査して、**実在しない参照 58 件**
（実在しないパス 40・実在しないファイル名 16・実在しない npm script 2）。
免除 52 件で全件を説明し、**説明のつかない腐り 0 件**。

> **数え方の注意**: `build/` を作った直後に走らせると **54 件**になる（生成物 4 件が実在するため）。
> 58 は `build/` が無い状態（＝リポジトリを clone した直後の状態）の数である。
> 生成物の免除は「実在するか」ではなく「作るスクリプトが実在するか」で判定しているので、
> **どちらの状態でも検査は緑になる**（実行順に結果が依存しない）。これは §9.2 の誤りを直した結果である。

免除の型別内訳:

| 型 | 件数 | 何を機械検証するか |
|---|---|---|
| **本当に腐っている（直すのは担当範囲外。記録済み）** `outOfScope` | **29** | この report に記録が実在すること。**直れば「宣言が余っている」で赤になる** |
| **過去の状態として書かれている** `historical` | 12 | 「cycle 24 step 2 までは」等の目印が同じファイルに実在すること |
| **例示・否定の文脈** `illustration` | 6 | 同上（否定・再現データの文脈の目印） |
| **生成物** `generated` | 4 | それを作る npm script が package.json に実在すること |
| **別プロジェクトのファイル** `otherProject` | 1 | 相手プロジェクトの下に実在すること |

### 5.3 「本当に腐っている」29 件（直すべきものとして記録する）

**これは黙らせるための一覧ではない。** 直すのが本 step の担当範囲外（本文・ロケール・docs・runbook）なので
記録して通しているだけである。直したら免除を消すこと（消さないと「宣言が余っている」で赤になる）。

| ファイル | 参照 | 何が起きているか |
|---|---|---|
| `structured-latex/locales/en/content/005_duality.ts` | `../../docs/paper001-en-glossary.md` | **cycle 24 step 2 の訂正が 12 ファイル中この 1 行だけ取り残した。**深さが誤り（正: `../../../../docs/…`） |
| `structured-latex/locales/en/content/005_duality.ts` | `tools/ja-en-exceptions.ts` | 撤去済みのツールを現在形で指す（現: `locales/en/structure-exceptions.ts`） |
| `structured-latex/locales/en/content/005b_theta_infinity.ts` | `tools/ja-en-exceptions.ts` | 同上 |
| `structured-latex/locales/en/content/007_asymmetry_scope.ts` | `tools/ja-en-exceptions.ts` | 同上 |
| `structured-latex/locales/en/content/005c_ell2_family.ts` | `ja-en-exceptions.ts` | 同上（裸のファイル名） |
| `structured-latex/locales/en/content/009_s_infinity_decision.ts` | `ja-en-exceptions.ts` | 同上 |
| `structured-latex/locales/en/content/009_theta_recursion.ts` | `ja-en-exceptions.ts` | 同上 |
| `structured-latex/locales/en/content/001a_reader_guide.ts` | `../../outputs/reports/paper001_submission_venue_survey.md` | 相対パスの深さが誤り |
| `structured-latex/locales/en/content/001a_reader_guide.ts` | `009_prior_art.ts` | 実ファイルは `010_prior_art.ts`（章番号の付け替えで書き換え漏れ） |
| `structured-latex/locales/en/content/010_prior_art.ts` | `../../outputs/reports/cycle18_T1_monsky1989_acquisition.md` | 相対パスの深さが誤り |
| `structured-latex/locales/en/content/010_prior_art.ts` | `../../outputs/reports/cycle17_T1_prior_art_check.md` | 相対パスの深さが誤り |
| `structured-latex/locales/en/content/010_prior_art.ts` | `../../docs/tasks/auto-loop-state.md` | 相対パスの深さが誤り |
| `structured-latex/locales/en/allowance.ts` | `locales/en/math-exceptions.ts` | **監査のエラーメッセージ**が実在しないファイル名を指す。読んだ人が探して見つからない |
| `structured-latex/locales/en/diff-rules.ts` | `verify-ja-en-detection-test.ts` | 改名済みのテストを現在形で指す |
| `structured-latex/locales/en/frontmatter.ts` | `tools/verify-ja-en-correspondence.ts` | 撤去済みの比較器を現在形で指す |
| `structured-latex/locales/en/frontmatter.ts` | `../structured-latex/content/001_intro.ts` | 旧 `structured-latex-en/` 時代の相対パス |
| `structured-latex/locales/en/frontmatter.ts` | `../outputs/reports/paper001_submission_venue_survey.md` | 同上 |
| `README.md` | `inputs/queries/` | 構成として掲げているが未作成 |
| `docs/architecture.md` | `inputs/queries/` | 同上 |
| `docs/architecture.md` | `operations.md` | `inputs/seeds/` に置く予定として挙げているが未作成 |
| `docs/architecture.md` | `axes.md` | 同上 |
| `docs/architecture.md` | `canonical-papers.md` | 同上 |
| `docs/schemas.md` | `inputs/seeds/operations.md` | スキーマの列挙元として名指ししているが未作成 |
| `docs/paper001-en-glossary.md` | `content/008_prior_art.ts` | 実ファイルは `locales/en/content/010_prior_art.ts` |
| `docs/paper001-en-glossary.md` | `content/001a_reader_guide.ts` | 実ファイルは `locales/en/content/001a_reader_guide.ts` |
| `docs/paper001-en-glossary.md` | `ja-en-exceptions.ts` | 撤去済みのツールを現在形で指す |
| `docs/tasks/auto-loop-runbook.md` | `schema.mjs` | 実ファイルは `schema.ts`。**runbook 自身が「ソース形式は TypeScript に統一する（`.mjs` は使わない）」と書いているのに、参照だけ `.mjs` のまま** |
| `docs/tasks/auto-loop-runbook.md` | `tools/validate-content.mjs` | 同上 |
| `docs/tasks/auto-loop-runbook.md` | `verify-no-lost-proofs.mjs` | 同上（Ising 側の実ファイルは `.ts`） |

**tools/ の中で見つかった腐り 1 件は、担当範囲なので直した**——`source-links.ts` の doc コメントが
撤去済みの `ja-en-exceptions.ts` を「の注記も参照」と現在形で指していたので、
現存する `locales/en/diff-rules.ts` を指すよう書き換えた（コメント 1 行。検査の挙動は変えていない）。

---

## 6. 誤検出への対処（何を候補から外したか）

偽陽性を出すと検査は使われなくなるので、次を候補から外した。**外した理由はすべて実測に基づく。**

| 外したもの | 実例 | 根拠 |
|---|---|---|
| バッククォートの外 | 「sagemath/Lean 投下可」 | 参照として書かれていない。実測 164→90 件 |
| テンプレート文字列の埋め込み式 | `` `${mode}:${node.tex}` `` | `node.tex` はプロパティであってファイルではない。実測 3 件 |
| glob・穴あき | `content/*.ts` · `outputs/papers/001_<topic>/` | 集合の指示。展開はしない（§8 の限界） |
| 外部ホスト名 | `zbmath.org/static/msc2020.pdf` | リポジトリ内のパスではない |
| arXiv id・分数 | `math-ph/9904003` · `1/2` | 第 1 階層の名前が**リポジトリに実在するもの**でなければパス候補にしない（表をツールへ書き写さず、ディレクトリを読んで決める） |
| 拡張子だけの表記 | 「`.mjs` は使わない」 | ファイル名の部分が無い |
| pnpm 自身のサブコマンド | `pnpm install` | スクリプト名ではない |

§7 の R-3 で、この 9 通りが実際に静かであることを実測した。

---

## 7. 検出テスト — 何通りの壊し方で何件検出したか

**「本番で違反 0 件だった」は検査が効いていることの根拠にならない**（cycle 22 の教訓）。
さらに cycle 24 step 3 §9.1 の教訓——**「赤くなった」で満足すると、どの経路で赤くなったのかを見落とす**——
を踏まえ、**期待する違反の種類まで突き合わせる**（種類が違えば失敗にする）。
**ファイルは 1 バイトも書き換えない。**読み込んだ後のメモリ上の値に差分を当てる。

### 7.1 検査 C（13 件）

| # | 壊し方 | 期待した違反 | 結果 |
|---|---|---|---|
| 1 | **証明を持つ 16 ブロックすべてから、1 つずつ証明を落とす** | 未宣言の証明欠落 | **16 / 16 件で検出**（壊す前の未宣言違反は 0 件） |
| 2 | `proof` を空配列にする | proof が空配列 | 検出 |
| 3 | `proof` を TODO ノードだけにする | proof が TODO ノードを含む | 検出 |
| 4 | `proof` を空白だけの段落にする | proof に中身が無い | 検出 |
| 5 | 未了を記録した report の一文を書き換える | 未了の記録が見つからない | 検出 |
| 6 | 引用は report に実在するが、**未了を述べていない文**へ貼り替える | 記録が未了を述べていない | 検出 |
| 7 | 引用を短くして pin にならなくする | 宣言の指定が短すぎて何も pin していない | 検出 |
| 8 | 原本の在処を、**転記検査の台帳が挙げていない** report にする | 原本の在処が転記検査の台帳と食い違う | 検出 |
| 9 | 原本の目印を report に無いものへ（原本が改稿された場合） | 原本の目印が見つからない | 検出 |
| 10 | 目印は実在するが**その先に証明が無い**箇所を指す（原本から証明が消えた場合） | 原本にその証明が無い | 検出 |
| 11 | 宣言が指すブロックが本文から消える | 宣言が指すブロックが本文に無い | 検出 |
| 12 | **証明が本文へ入ったのに宣言が残る** | 宣言が余っている（証明が入った） | 検出 |
| 13 | 宣言が、証明を要さない種別のブロックを指す | 宣言が指すブロックは証明を要さない種別 | 検出 |

**#1 が本題である。**「証明を運んだブロックから証明が落ちたら赤くなる」ことを、
1 件の代表例ではなく**現存する 16 件すべてで**確かめている。

### 7.2 検査 R（11 件）

| # | 壊し方 | 結果 |
|---|---|---|
| 1 | **cycle 24 step 2 の腐りの再現データ**（`git show 6756584` の削除行から起こした 12 ファイル分の相対パス＋撤去済み比較器＋存在しない npm script） | **14 / 14 件を検出** |
| 2 | 同じ 3 種類を**訂正後の記述**にする | **3 / 3 件が静か**（偽陽性でない） |
| 3 | 正当な書き方 9 通り（分数・arXiv id・外部ホスト・glob・地の文・テンプレート埋め込み式・実在する相対パス・実在する npm script・pnpm のサブコマンド） | **9 / 9 件が静か** |
| 4 | 「過去の状態として書かれている」の目印がファイルから消える | 根拠の目印が同じファイルに無い |
| 5 | 同じ目印が短すぎる | 根拠の指定が短すぎて何も pin していない |
| 6 | 生成物を作るスクリプトが改名される | 生成物を作るスクリプトが無い |
| 7 | 別プロジェクトのファイルが向こうで消える | 別プロジェクトにもそのファイルが無い |
| 8 | 「本当に腐っている」の記録が消える | 記録が見つからない |
| 9 | 免除が指す参照が、そのファイルからもう消えている | 宣言が余っている（その参照がもう書かれていない） |
| 10 | **免除が指す参照が実在するようになった**（＝直った） | 宣言が余っている（その参照が解決するようになった） |
| 11 | 免除が指すファイルそのものが消える | 宣言が指すファイルが読めない |

再現データは**当時の原文**である（`git show 6756584` の `-` 行）。
12 ファイルすべてが「正本は日本語版 `` `../../structured-latex/content/<file>` ``」と書いており、
移動後の正しい形は `` `../../../content/<file>` `` である。

```
24 / 24 件で検出を実証した（検査 C 13 件 + 検査 R 11 件）。
```

---

## 8. 正直な限界

### 8.1 検査 C

- **証明が空でないことしか見ない。** 中身の正しさ・十分さは見ない。1 文字でも書けば通る
  （中身の照合は転記検査、正しさは Lean 化の領分。**この検査はそのどちらの代わりにもならない**）。
- **種別の付け方そのものは見ない。** `remark` に実質的な主張を書けば検査の対象外になる。
  現在の本文ではこの逃げ方は使われていない（§3 の 2）が、**塞いではいない。**
- **宣言の妥当性は測れない。**「本文へ運ぶべきか、それとも原本を参照するに留めるべきか」は人の判断である。
  検査が言えるのは「原本に証明があり、本文には無い」ことだけである。
- **翻訳ロケールには走らせていない。** 原文（日本語）だけを見る。
  英語版で証明だけが落ちる事故は、システムの構造照合（`proof` の骨格まで比較する）が拾う建付けだが、
  **本 step ではその依存関係を実測で確かめていない。**

### 8.2 検査 R

- **実在するかしか見ない。** 実在するが**別のものを指している**参照（例: 移設で意味が変わったパス）は検出できない。
- **バッククォートの外は見ない。** 地の文でツール名を出している箇所の腐りは拾えない。
- **glob は展開しない。** `content/*.ts` が 0 件になっても赤くならない。
- **走査範囲を絞っている。** `outputs/reports/` · `MEMORY.md` · `auto-loop-state.md` · `_old/` ·
  `sagemath/` · `lean/` は対象外である（理由は §5.1。**毎回出力する**）。
  とくに `MEMORY.md` は**実測 20 件**の腐りを持っているが、履歴として正しいものと本当の腐りを
  分ける手段が無いので外した。**外した件数を隠していない、というだけである。**
- **npm script の所在は「最も近い package.json」で決めている。** 別ディレクトリの
  スクリプトを指す記述は、名前が偶然一致すれば通る。

### 8.3 両方に共通

- **免除・宣言の型が「その判定でよいか」を機械検証する手段は無い。**
  `historical` が本当に過去形で書かれているか、`illustration` が本当に例示かは、人の判断である
  （cycle 24 step 3 の `positioning` 14 件と同じ性質）。検査できるのは
  「そう判定した根拠の文が生きているか」までである。
- **本 step で新設した 2 検査は、いま緑である。それは検査が強い証拠ではない。**
  免除を現在の状態から起こした以上、全件通るのは当たり前である
  （cycle 24 step 3 §5 と同じ注意）。**値打ちはこれから本文・docs・ツールが動いたときに出る。**

---

## 9. 自分が犯した誤り（隠さず記録する）

### 9.1 設計を先に決めてから一次情報を見た（最重）

「未了は第 11 章の 2 件」という step の前提をそのまま受け取り、
**2 件を宣言する仕組みとして設計を書き始めた。**実際に本文を読み込んで数えたのは後で、
**7 件あった。**5 件は cycle 21 以前からの負債で、どの総括にも記録が無い。

指示は「**id とラベルを列挙してから設計に入ること**」と明示していた。読んでいたのに、
先に型を書き始めていた。**cycle 24 step 3 §9.2（閾値を先に決めて一次情報を後から見た）と同じ形である。**
気付いたのは実測スクリプトを走らせたときで、設計は書き直した。

### 9.2 検査の結果が「ビルドを走らせたか」に依存する設計にしていた

生成物（`build/document.tex` 等）の免除を「**いまも実在しないこと**」で検証する形にしていた。
単体で走らせると緑だったが、`npm run check` の中では `verify:no-notes` が先にビルドするので
`build/` が実在し、**同じ免除が「余っている」で赤になった。**

```
- structured-latex/locales/en/README.md / build/en/document.tex: [宣言が余っている（その参照が解決するようになった）]
```

**単体で緑だったことを「通った」と読んでいた。**`npm run check` に組み込んで初めて出た。
生成物の免除が腐るのは「作るスクリプトが消えたとき」だけなので、
実在の判定を外して「`producedBy` が package.json に実在すること」だけを見る形へ直した。
**検査は実行順に依存してはならない。**

### 9.3 走査範囲を「広いほど強い」と読み違えた

最初は `MEMORY.md` と `auto-loop-state.md` を走査対象に入れていた。腐りは 164 件出た。
中身を読むと、大半は「当時 `tools/en-only-blocks.ts`、現在は …」のような**履歴として正しい記述**だった。
これを免除で 1 件ずつ潰すと、**毎サイクル追記されるたびに無関係な赤が出る検査**になる。

**広い走査は強い検査ではない。**赤が意味を持たなくなれば、検査は無視されるようになる。
`outputs/reports/` を外したのと同じ理由で外し、**外したことと理由を毎回出力する**形にした。

### 9.4 自分の再現データで自分の検査を赤くした

検出テストは「腐っていた当時の記述」を再現データとして持つ。走査はその文字列も拾うので、
**自分のテストファイルで赤くなった。**ファイルごと走査から外せば消えるが、
それは「このファイルなら何を書いてもよい」という穴である。1 件ずつ免除する形にした
（cycle 21 の「ブロック単位の免除が検査の穴になった」と同じ話である）。

### 9.5 ソースに NUL 文字を書き込んでいた

新規ファイルのテンプレート文字列に、空白のつもりで NUL 文字（`U+0000`）が 3 か所入っていた。
検査の挙動は同じ（キーの区切りとして両側で同じ文字を使っていたため）なので**何も落ちなかった**が、
ソースとしては壊れている。編集ツールが該当行を見つけられなくなって気付いた。
**「動いているから正しい」は根拠にならない。**全新規ファイルを走査して除去した。

---

## 10. 検証（すべて自分で実行した）

**作業中に `origin/main` が 1 コミット進んだ（step 1 のマージ `cd0734d`）ので、
取り込んでから下記をすべて実行し直した。**以下の数字は取り込み後のものである。

| 検査 | 結果 |
|---|---|
| `(cd integrable-lattice/structured-latex && npm run check)` | **exit 0**（1 分 36 秒）。**15 段すべて緑**（従来の 12 段＋新設 3 段） |
| `node tools/verify-proof-completeness.ts` | **exit 0**。定理型 34・証明を持つべき 23・証明あり 16・**証明なし 7（宣言 7・未宣言 0）**・**失効した宣言 0** |
| `node tools/verify-reference-rot.ts` | **exit 0**。69 ファイル・参照 437 件・**実在しない参照 58 件**・免除 52・**失効した免除 0・登録が古い免除 0・説明のつかない腐り 0** |
| `node tools/verify-guards-detection-test.ts` | **exit 0**。**24 / 24 件で検出を実証**（検査 C 13 + 検査 R 11） |
| `(cd structured-latex && npm run check)`（システム側） | **exit 0**（2 分 4 秒）。負テスト 16 ケース × (正/誤) すべて期待どおり |
| `node integrable-lattice/structured-latex/tools/validate-content.ts` | **exit 0**。ja 46 ブロック / 13 ファイル、36 ラベル・108 参照すべて解決 |
| `node integrable-lattice/sagemath/tools/verify-check-linkage.ts` | **exit 0**。SageMath 検証 45 件・Lean 定理 67 件すべて実在 |
| 既存の転記検査を壊していないこと | `npm run check` の中で `verify:transcription`（違反 0）と `verify-transcription-detection-test`（12/12）が緑 |
| 型で必須になっていることの確認 | `tsc -p tsconfig.json --noEmit` が exit 0。宣言・免除の根拠は型で必須なので、根拠なしでは書けない |

Node は v22.22.3。依存は worktree で `pnpm install` した（gitignore された依存が worktree に無いのは正常な初期状態）。
**1 本のスクリプトの壁時計上限 20 分**は満たしている（最長はシステム側 `npm run check` の 2 分 4 秒）。
**負荷判断に `uptime` の負荷平均を使っていない**——`top -l 1 -n 0` の CPU idle で見た。
**パイプの後ろで `$?` を取っていない**（`${PIPESTATUS[0]}` を使った。cycle 24 step 4 §8.3 の誤りの再発防止）。

### 10.1 担当範囲外に差分が無いこと

```
$ git diff --stat origin/main...HEAD
 ...le25_ops_guard_missing_proof_and_rotten_refs.md | 460 ++++++++++++++++
 integrable-lattice/structured-latex/package.json   |   5 +-
 .../structured-latex/tools/proof-debt.ts           | 399 ++++++++++++++
 .../tools/reference-rot-allowances.ts              | 355 ++++++++++++
 .../structured-latex/tools/reference-rot-model.ts  | 613 +++++++++++++++++++++
 .../structured-latex/tools/source-links.ts         |   3 +-
 .../tools/verify-guards-detection-test.ts          | 418 ++++++++++++++
 .../tools/verify-proof-completeness.ts             |  81 +++
 .../structured-latex/tools/verify-reference-rot.ts | 101 ++++
 9 files changed, 2433 insertions(+), 2 deletions(-)
```

**触ったのは `structured-latex/tools/` の 7 ファイル・`package.json`・自分の report だけ**である。
`package.json` の差分は検査段の追加（`verify:proofs` / `verify:refs` / `test:guards` の 3 スクリプトと
`check` への連結）だけで、既存の検査を緩めていない。`source-links.ts` の差分は
doc コメント 1 か所（§5.3 の末尾）で、台帳・免除・検査の挙動は変えていない。

担当範囲外に差分が無いことも明示的に確かめた（出力なし＝差分 0）:

```
$ git diff --stat origin/main...HEAD -- \
    integrable-lattice/structured-latex/content \
    integrable-lattice/structured-latex/locales \
    integrable-lattice/lean integrable-lattice/MEMORY.md \
    integrable-lattice/docs integrable-lattice/sagemath
（出力なし）
```

---

## 11. 申し送り

- **cycle 25 step 4（本文反映）は、命題 M・U に証明を入れたら宣言を消すこと。**
  消さないと「宣言が余っている（証明が入った）」で赤になる。
  残る 5 件（命題 G′・G″・J・K・R）は**別の step を立てるべき負債**である。
- **§5.3 の 29 件は直すべき腐りである。**とくに `locales/en/content/005_duality.ts` の 1 行は
  **cycle 24 step 2 の手作業が取りこぼしたもの**で、本文を触る step が直すのが自然である。
  `docs/tasks/auto-loop-runbook.md` の `.mjs` 参照 3 件は、runbook 自身の方針と食い違っているので早く直したい。
- **走査範囲は広げられる。** `sagemath/` · `lean/` · `MEMORY.md` を入れるなら、
  「履歴として正しい記述」を分ける型（`historical`）を先に使いこなす必要がある。
  範囲を広げる step は、**出た件数を判定しきるところまでを 1 つの step にすること**
  （cycle 23 §9・cycle 24 step 3 §10 と同じ申し送り）。
- **検査 C を翻訳ロケールへ広げるかは未決である**（§8.1 の最後）。
  システムの構造照合が `proof` の骨格を比較しているので二重になる可能性がある。先に依存関係を実測すること。

**新規性は主張しない。** 本 step は検査道具の追加であり、新しい数学は無い。
