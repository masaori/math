# cycle 24 step 2: 英語版をローカライズモデルへ移し、日英二重管理を撤去した

日付: 2026-08-01 / track: 運用 / step: `localize_english_edition`

## 0. 結論

英語版は独立プロジェクト `integrable-lattice/structured-latex-en/` をやめ、
**`integrable-lattice/structured-latex/locales/en/`（`locales.config.ts` が宣言する翻訳ロケール `en`）**
になった。ラベル型・スキーマ・生成器・検査は日本語版と共有する。

日英対応の検査は自前の比較器（`verify-ja-en-correspondence.ts`、331 行）をやめ、
**システム（リポジトリ直下 `structured-latex/`）の構造照合**（`validateLocalizedRevision` /
`resolveLocalized`、および `npm run gen --check`）に載せ替えた。

自前検査が拾っていた検出は**1 つも落としていない**（§3）。加えて、載せ替えによって
**移行前には原理的に見えなかった差が 1 件実際に見つかった**（§4）。
弱くなった点も 1 つある。隠さず §5 に書く。

**日本語本文（`structured-latex/content/`）は 1 バイトも変えていない。**
英語本文の文言も変えていない（変えたのは import 行と `origin.path` だけ。§7 で `git diff -M` により実証）。

## 1. 撤去したもの → 責務の移管先（対応表）

| 撤去したファイル（旧 `structured-latex-en/`） | 行数 | 責務の移管先 |
| --- | --- | --- |
| `schema.ts` | 155 | `structured-latex/schema.ts`（`defineTranslatedBlocks` / `refInTranslation` / `translatedRuntimeSchema` を追加。**固有メタデータの宣言は 1 か所のまま**） |
| `labels.generated.ts` | 生成物 | `structured-latex/labels.generated.ts`（`Label` に加え `TranslationOnlyLabel` / `AnyLocaleLabel` を生成器が出す） |
| `document.generated.ts` | 生成物 | `structured-latex/document.generated.ts`（翻訳ロケールのファイルも連結し、ファイル跨ぎの一意性を型で主張する） |
| `package.json` / `pnpm-lock.yaml` / `tsconfig.json` / `.gitignore` | — | `structured-latex/` の同名ファイル（`tsconfig` の `include` に `locales` と `locales.config.ts` を追加。スクリプトは `--locale` 付きの `*:en` を追加） |
| `tools/build-latex.ts` | 644 | `structured-latex/tools/build-latex.ts`（`--locale`）＋ `tools/editions.ts`（版で変わるものだけ） |
| `tools/math-unicode.ts` | 23 | `tools/editions.ts` の `starMacro`（★ の落とし先だけが版で違う） |
| `tools/content-modules.ts` | 44 | `structured-latex/tools/content-modules.ts`（`contentDirForLocale` / `loadContentFilesForLocale` / `localeFromArgv` を追加） |
| `tools/validate-content.ts` | 224 | `structured-latex/tools/validate-content.ts`（`--locale`） |
| `tools/verify-no-notes-in-output.ts` | 105 | `structured-latex/tools/verify-no-notes-in-output.ts`（`--locale`） |
| `tools/negative-type-test.ts` | 253 | `structured-latex/tools/negative-type-test.ts`（翻訳ロケールの受け口 2 ケースを追加。11 ケース） |
| `tools/schema-runtime-test.ts` | 108 | `structured-latex/tools/schema-runtime-test.ts`（スキーマが 1 つになったので複製不要） |
| `tools/verify-ja-en-correspondence.ts` | 331 | **システム**の `validateLocalizedRevision`（構造照合本体）＋ `locales/en/allowance.ts`（差の理由）＋ `tools/verify-localization.ts`（集約の組み立てと登録の監査） |
| `tools/verify-ja-en-detection-test.ts` | 142 | `structured-latex/tools/verify-localization-detection-test.ts` |
| `tools/en-only-blocks.ts` | 70 | `structured-latex/locales/en/translation-only-blocks.ts`（ファイル単位の表 `TRANSLATION_ONLY_SEGMENTS` を追加） |
| `tools/ja-en-diff-rules.ts` | 131 | `structured-latex/locales/en/diff-rules.ts`（規則を 3 → 5 種類へ。§4） |
| `tools/ja-en-exceptions.ts` | 119 | `structured-latex/locales/en/structure-exceptions.ts` |
| `frontmatter.ts` | — | `structured-latex/locales/en/frontmatter.ts` |
| `content/` 14 ファイル | — | `structured-latex/locales/en/content/`（`git mv` で履歴を保存） |
| `README.md` | — | `structured-latex/locales/en/README.md` |

システム側に足したもの（これが「移管先」の実体）:

| システムのファイル | 追加内容 |
| --- | --- |
| `domain-model/resolved/localized-revision.ts` | `LocalizationAllowance` / `TranslationDivergence` / `DivergenceVerdict`、id・key による対応付け、新しい issue code 7 種 |
| `domain-model/resolved/resolve-localized.ts` | `resolveLocalized` / `resolveLocalizedTolerantly` に allowance を通す |
| `codegen/structured-text-index/locales.ts` | `TranslationSource.allowance` の受け入れと形の検査 |
| `codegen/structured-text-index/cli.ts` | 翻訳限定ラベルの収集、原文ラベルとの衝突検査、allowance の受け渡し、翻訳ファイルの生成物への取り込み |
| `codegen/structured-text-index/render.ts` | `TranslationOnlyLabel` / `AnyLocaleLabel` の生成、翻訳ロケールごとの一意性・ラベル整合の型主張 |
| `README.md` / `docs/domain-model.md` | allowance の設計と不変条件 I8a–I8d |

## 2. なぜ「単に移す」だけでは済まなかったか

システムの既定は I8「翻訳は原文と同じセグメント・ブロック・ラベル・共有ノード構造を持つ」で、
差はすべて違反である。ところが英語版は**意図した差**を 6 種類持っていた（実測）。

| 差 | 件数（実測） | 旧検査での扱い |
| --- | --- | --- |
| 英語版にしか無いファイル | 2 | 検査対象外（ブロック単位でのみ登録） |
| 英語版にしか無いブロック | 7 | `en-only-blocks.ts` に理由つき登録 |
| 数式中の `\text{}` の中身の英訳 | 多数 | 規則 `text-body-translated(-reordered)` |
| リポジトリ内部の `\texttt{}` ノードの削除 | 多数 | 規則 `repo-internal-texttt-removed` |
| `cite` ノードの追加（投稿稿の書誌） | 多数 | **見ていなかった**（数式の多重集合しか見ない） |
| `realEscape` の文言の英訳 | 6 | 有無だけを比較 |
| 段落の切り直し・語順変更によるノード位置の変化 | 12 ブロック | **見ていなかった**（多重集合比較のため位置は無視） |
| 行内数式 → 別行立て数式への変更 | 1 | **見ていなかった**（tex 文字列しか見ない） |

「検査を緩めて通す」と、意図しない訳し落としまで一緒に通る。そこでシステム側に
**差を 1 件ずつ allowance へ渡し、説明できなかったものだけを違反にする**仕組みを入れた。
**免除の単位はブロックではなく差分 1 つである**（cycle 21 の事故と同じ穴を開けないため）。

## 3. 自前検査が拾っていた検出は 1 つも失っていない

旧 `verify-ja-en-correspondence.ts` の 8 つの不変条件と、載せ替え後の担い手:

| 旧不変条件 | 載せ替え後 | 強弱 |
| --- | --- | --- |
| 1. 日本語版のブロック id が英語版にすべて存在する | `missing_translated_block`（**allowance へ渡さない**＝宣言で正当化できない） | 同等以上 |
| 2. `kind` の一致 | `structural_drift ...kind` | 同等 |
| 3. `labels` の**集合**一致 | `sameStringArray`（**順序まで**一致を要求） | **強くなった** |
| 4. 日本語版のラベルが英語版にすべて存在 | 3 から従う | 同等 |
| 5. `habitat` の一致、`realEscape` の有無の一致 | `block_meta`（`habitat` は値の一致）＋ `localeSpecificMetaKeys: ["realEscape"]`（**有無**の一致） | 同等 |
| 6. `proof` の有無・`verification`・`lean` の一致 | `proof` は骨格まで比較、`verification` / `lean` は `block_meta` で**順序込みの完全一致** | **強くなった** |
| 7. 数式（`math`/`displayMath` の tex）の**多重集合**一致、規則で説明できない差は違反 | 骨格の**位置込み**比較。位置が違う場合だけ規則 `translation-reflowed` が多重集合一致を検査 | 既定は強く、免除時は同等（§5） |
| 8. 英語版限定ブロックは理由つき登録のみ | `unexplained_translation_only_block`。**ファイル単位で認めても中のブロックは 1 件ずつ理由を要求する** | **強くなった** |
| 登録の腐り（不要な登録・使われない規則・空の理由） | `tools/verify-localization.ts` の `auditRegistrations()` ＋ システムの `empty_divergence_reason` | 同等 |

新たに検査対象になったもの（旧検査は**一切見ていなかった**）:
**参照先（`ref.target`）・引用キー（`cite.keys`）・画像資産キー・ノート対応・セグメントの順序・
ブロックの相対順序・ノードの位置と入れ子・行内/別行立ての別。**

### 検出テストで実測した

旧 `verify-ja-en-detection-test.ts` が守っていた性質「登録済みブロックでも数式ノードの脱落は
1 つ残らず違反になる」を、載せ替え後の検査に対して**実際に壊して**確かめた
（`tools/verify-localization-detection-test.ts`）。

```
  結果: 壊し方 1325/1325 件で違反、cycle 21 型の脱落 11/11 ブロックで違反。
  登録済みのブロックでも、骨格ノードの脱落は 1 つ残らず違反になる。
```

旧テストは 765 件（11 ブロック）だった。今回は登録ブロックが 27 件に増えたので 1319 件、
これに新規の壊し方 6 件（参照先の差し替え／`habitat` の書き換え／`realEscape` の削除／
`verification` の削除／理由の無い翻訳限定ブロックの追加／原文ブロックの脱落）を足して 1325 件。
**すべて違反として検出された。**

## 4. 載せ替えで新たに見つかった差（移行前は原理的に見えなかった）

`paper_101_theorem_digit_branch`（桁定理）の statement で、

```
sep(a,b) := min{ t ≥ 0 : ... }
```

が、**日本語版では行内数式（`math`）、英語版では別行立て数式（`displayMath`）**になっていた。
旧検査は数式を「tex 文字列の多重集合」でしか見ていないため、ノードの種別が変わっても差として
現れない。システムの骨格比較は種別を含むので初めて表面化した。

数学の中身は変わっていない（`\text{}` の中身の英訳を除いて tex は一致する）ので、
規則 `math-display-mode-changed` を新設し、**tex が他の規則の下で一致することを別に検査した上で**
理由つきで認めた。これを口実に数式の中身を書き換えることはできない。

規則は 3 種類 → 5 種類になった: 既存 3 つに `citation-added`（英語版だけの `cite` ノード。
`cite` ノードにしか当たらない）と `math-display-mode-changed` を追加し、
`translation-node-order` を `translation-reflowed` に改名した（§5）。

## 5. 弱くなった点（隠さず書く）

**`translation-reflowed` を認めた 22 ブロックでは、骨格ノードの「位置」の一致を要求していない。**

英訳では 1 文の切り方と語順が変わるため、段落の割り方や数式と地の文の前後関係が原文と違う。
システムの既定はこれを違反にするが、英語版の 22 ブロックで実際に起きているので、
規則 `translation-reflowed` として理由つきで認めた。この規則は
**骨格ノードを平らにした多重集合の一致を実際に検査する**ので、
「組み替えた」を口実にノードを落とすことも足すこともできない。

- これは**移行前の自前検査と同じ強さ**である（旧検査は数式の多重集合しか見ていなかった）。
  したがって「移行によって検出力が落ちた」のではなく、**既定が強くなった分を一部のブロックで
  使えていない**という状態である。
- しかも旧検査と違い、多重集合には数式だけでなく**参照・引用・画像も入る**ので、
  同じ「多重集合比較」でも対象は広い。
- 規則を使ったブロックは `structure-exceptions.ts` に列挙されており、
  使わなくなれば `auditRegistrations()` が「登録が古い」として報告する。

**残りの 5 ブロック**（`paper_012` / `paper_032` / `paper_062` / `paper_072` / `paper_081`）は
位置込みの照合を通っている。

## 6. 検証（すべて実行し、出力を貼る）

### 6.1 システム側 `(cd structured-latex && npm run check)` — 終了コード 0

```
> npm run check:entities && npm run check:generated && npm run typecheck && npm run check:deps && npm run test && npm run test:types
entity definitions are up to date (13 entities)
generated files are up to date (5 labels, 2 content + 1 notes files)
# tests 67
# pass 67
# fail 0
負テスト: 16 ケース × (正/誤) すべて期待どおり
```

### 6.2 プロジェクト側 `(cd integrable-lattice/structured-latex && npm run check)` — 終了コード 0

```
> node ../../structured-latex/codegen/structured-text-index/cli.ts --project . --check
generated files are up to date (34 labels + 6 translation-only labels, 12 content + 0 notes files + 14 translated files)

> tsc -p tsconfig.json --noEmit

> node tools/validate-content.ts
validated (ja) 43 blocks from 12 files (11 headings, 34 labels, 89 refs, all resolved)

> node tools/validate-content.ts --locale en
validated (en) 50 blocks from 14 files (12 headings, 40 labels, 91 refs, all resolved)

> node tools/build-latex.ts && node tools/verify-no-notes-in-output.ts
no notes in output (ja): ノート 0 件（本文サンプル 0 件）は build/document.tex に現れない

> node tools/build-latex.ts --locale en && node tools/verify-no-notes-in-output.ts --locale en
no notes in output (en): ノート 0 件（本文サンプル 0 件）は build/en/document.tex に現れない

> node tools/verify-localization.ts
ロケール対応検証（システムの構造照合）
  ja: 43 ブロック / 12 ファイル
  en: 50 ブロック / 14 ファイル
  理由つきで認めた差: 翻訳限定ファイル 2 件 / 翻訳限定ブロック 7 件 / 骨格の規則 49 件
違反 0 件: 翻訳は原文の内容を 1 件も失っていない。

> node tools/negative-type-test.ts
すべての負テストが期待どおり: 誤った入力は tsc が拒否する（11 件）

> node tools/schema-runtime-test.ts
実行時検証テスト 13 件すべて期待どおり

> node tools/verify-localization-detection-test.ts
  結果: 壊し方 1325/1325 件で違反、cycle 21 型の脱落 11/11 ブロックで違反。

> node tools/verify-transcription.ts
違反 0 件。

> node tools/verify-transcription-detection-test.ts
3 / 3 件で検出を実証した。
```

### 6.3 `node integrable-lattice/structured-latex/tools/validate-content.ts` — 終了コード 0

上記 6.2 の `validate` と同じ（`(ja) 43 blocks ... all resolved`）。

### 6.4 `node integrable-lattice/sagemath/tools/verify-check-linkage.ts` — 終了コード 0

```
OK: 参照されている対応はすべて生きている（実在・規約適合）。
注意: 本ツールは対応の生死だけを見る。数学的な正しさは見ない。
```

（従来どおり、論文の主張と結びついていない検証ディレクトリ 2 件の注意が出る。step 2 の変更とは無関係。）

### 6.5 生成物の鮮度（`--check`）

6.2 の 1 行目で緑。翻訳ロケールのファイル 14 件と翻訳限定ラベル 6 件が生成物へ入っている。

### 6.6 本文に差分が無いこと（`git diff -M`）

- **日本語本文**: `git diff --cached -M --stat -- integrable-lattice/structured-latex/content/` → **出力なし（差分 0）**。
- **英語本文**: 14 ファイルすべてが rename として検出され、変更行は 128 行。その内訳を
  `grep -vE "origin: \{ path|^[-+]import \{"` で絞ると **0 行**。すなわち変更は
  **`origin.path` の付け替えと import 行の付け替えだけ**で、散文・数式は 1 文字も変えていない。
- 加えて、生成した LaTeX を移行前後で突き合わせた。**日本語版は完全一致（差分 0 行）**、
  **英語版はヘッダのコメント 3 行のみ差分**（生成元パスと再生成コマンドの表記）。
  書誌の導出物 `refs.generated.bib` も本体は完全一致。

## 7. 自分の誤り（この step で実際にやらかしたこと）

1. **`sed` の置換パターンで `.` をワイルドカードとして扱ってしまった。**
   調査用スクリプトのパスを書き換える際に `s#./structured-latex/#../structured-latex/#` と書き、
   `.` が任意 1 文字にマッチして `integrable-lattice/structured-latex/content` が
   `integrable-lattic../structured-latex/content` に化けた。その結果「日本語版の content が 0 件」
   という**誤った観測**を得て、一瞬それを事実として扱いかけた。
   検出できたのは、0 件という結果が明らかに不自然で、`listSourceFiles` を単体で叩き直したからである。
   **教訓**: 正規表現の置換でパスを扱うときはメタ文字をエスケープする。
   そして「観測結果が不自然なら、まず観測手段を疑う」。

2. **ブロック doc コメントの中に `locales/*/content/` と書いて、`*/` がコメントを終端させた。**
   `tools/localization.ts` が構文エラーで読めなくなった。実害は数分で消えたが、
   **コメントの中身は構文と無関係だという思い込み**が原因である。

3. **免除の「使用実績」を記録し損ねて、正しい登録を『腐っている』と報告させた。**
   `translation-reflowed` の経路（多重集合比較）では tex の正規化規則が実際に効いているのに、
   使用実績として記録していなかったため、監査が 4 件の登録を「1 度も使われなかった」と報告した。
   **登録を消す**方向へ直すと、その規則が守っていた検査が消える。
   正しい直し方は「規則を 1 つ外すと一致しなくなるかを実際に試して、効いているなら使用と記録する」
   であり、そちらで直した。**監査が赤いときに、登録を消して黙らせてはならない。**

4. **作業ディレクトリの取り違えを何度も起こした。**
   `cd` がシェル呼び出しをまたいで残ることを忘れ、相対パスのコマンドが
   `No such file or directory` で落ちた。毎回リポジトリ root からの絶対パスで始めるべきだった。

## 8. 申し送り

- 本文反映（cycle 24 step 4）は、この構成の上で再開できる。日本語本文を変えたら
  `locales/en/content/` の対応ブロックも直し、`npm run verify:localization` を緑に戻す。
  **翻訳が追いつかないうちは検査が落ちる**が、それは正しい状態である（喪失は宣言で正当化できない）。
- `translation-reflowed` を認めているブロック（§5）は、本文を書き換えるときに
  位置の照合が効いていないことを意識する。ノードの増減は依然として必ず落ちる。
- 新しいロケールを足すときは、`locales.config.ts` に宣言し、`tools/editions.ts` に版を足す
  （版が無いと生成器が明示的に落ちる。黙って原文の体裁で組まれることはない）。
