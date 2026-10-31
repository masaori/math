# 論文構成再編の継続 Runbook

## ゴールライン

2026-10-31 に代表が承認した章立て（[six-chapter-organization-proposal.md](six-chapter-organization-proposal.md)。
以下「章立て案」）のとおりに、複素行列版の本文 `structured-latex/content/` を組み直す。次がすべて成り立てば完了である。

- 本文の並びが、数学的道具立て → 分配関数（転送行列による表示、射影と Jordan–Wigner 表示）→
  固有値問題（離散 Fourier 変換による $2\times2$ 行列への帰着、対角化と $V^{(+)}$ の指数表示、$V^{(+)}$ の固有値、
  $V^{(+)}$ の最大固有値に属する固有ベクトル）→ 熱力学極限（$N\to\infty$ の極限と最大固有値、$M\to\infty$ の極限と閉形式）→
  臨界点、の部・章になっている。本文の部・章の見出しは章立て案の題と一致する。
- 各章は、章立て案のその章の「ゴールの式」を主張するブロックで終わる。各章は、それより前の章と数学的道具立てだけを参照する
  （前方参照が無い）。
- 本文の冒頭に章立ての説明ページ（各章のゴールの式と章の依存関係の図）があり、本文の部・章と一致している。
- 本文の題（章題・ブロック題）に、本文で定義されていない物理の用語（運動量、フェルミオン、セクター）が無い。
- `npm run check`・`build:html`・`build:pdf`、SageMath の対応検査、Lean の `lake build` と `check-no-sorry.sh` が通る。
- 公開ページ（論文本文と論文構成）が remote default branch の現行版である
  （`bash scripts/verify-complex-matrix-ising-paper-artifacts.sh` が通る）。

以前のゴールライン（最終章を「数学的道具立て」「2次元イジングモデル」の二章だけにする）は、この章立てで置き換えた。
数学的道具立てとイジング側の分類規則（下の「分類規則」）は引き続き使う。

## 作業の順序

上から順に、未完了の最初の項目を進める。進んだ位置は状態台帳
[paper-organization-state.md](paper-organization-state.md) の「現在地」と「次の一歩」に書く。

1. **$\Lambda^{(\delta)}_{M}$ の定義を、閉形式の定理（`onsager_free_energy_expression`）から独立した definition ブロックへ分ける。**
   いまは定理の statement の中で定義しており、$V^{(+)}$ の最大固有値の定理（`max_eigenvalue_of_V_plus_simple`）と
   `c_plus_equals_Lambda_half_integer` が、定義を使うためだけに閉形式の定理を参照している。参照を新しい定義へ付け替え、
   Lean・SageMath の対応も同じ回で揃える。
2. **本文の題から未定義の物理用語を除く。** 章題・ブロック題で「偶セクター」「半整数運動量」「フェルミオン」を含むもの
   （2026-10-31 時点で 16 件。`grep -n "title:" content/*.ts | grep -E "セクター|運動量|フェルミオン"` で列挙できる）を、
   対象を式で表す題へ直す（例：「$\check\psi_\mu$ の定義」「添字集合 $\check{\mathcal M}$」「$V^{(+)}$ の定義」）。
   本文の段落の言い回しも同じ回で直してよいが、数学の中身は変えない。
3. **章の割り当てを棚卸しの生成器に入れる。** 章立て案の「振り分けの決め方」（各章のゴールの式の依存閉包を上の章から順に取り、
   まだどの章にも入っていない項をその章に入れる）を `tools/build-flat-inventory.ts` に実装し、
   各項目の所属章を棚卸しへ出力する。数学的道具立ての項は道具章のまま。章ごとの項目数が章立て案の数（20・27・27・27・15・17・9・9・10）
   からずれたら、理由を状態台帳に書く。
4. **章ごとに本文を組み直す。** 1 回に 1 章ずつ、章立て案の上の章から順に、その章に割り当てられたブロックを
   その章の見出しの下へ、章内の依存順で並べ直す。章の最後は、その章のゴールの式を主張するブロックにする
   （無ければ既存ブロックの組み合わせとして主張を立てる。中身の新しい証明はしない）。
   ブロックの移動はブロックを丸ごと移し、id・ラベル・本文を変えない。移したブロックを `正本:` などでファイル名つきで
   指している Lean・SageMath のコメントや overview は、同じ回で新しい場所へ直す。
5. **どの章のゴールの式からも辿れない項（2026-10-31 時点で 9 項）を一つずつ確かめる。**
   本文のどこからも使われていなければ参照用ノートへ退避し、採用しなかった理由を書く。使われているなら、使う章へ置く。
6. **冒頭の章立ての説明ページを、組み直した本文と照合する。** 部・章の題、ゴールの式、依存関係の図が本文と一致するかを
   確かめ、ずれていれば説明ページの側を本文に合わせる。
7. **完了の確認。** ゴールラインの全項目を確かめ、ゴール台帳の該当ゴールを更新する。

各回の終わりに、論文本文と論文構成の二つのページを作り直して公開し直す（下の「毎回の手順」）。

## 一回の作業の大きさ

一回の作業は、上の「作業の順序」の 1 項目、または項目 4 の 1 章とする。それより大きいと分かったら、
中身で割り直して状態台帳に書き、先頭の一つだけを行う。

前回の作業が途中で止まって未コミット成果、または remote default に未包含のローカル成果コミットが残っている場合は継続モードとする。
新しい項目へ着手せず、既存成果について未完のレビュー、指摘修正、全検証、台帳整合、コミット、remote default 反映だけを行う。

## 毎回の手順

- `AGENTS.md`、`CLAUDE.md`、`docs/context/` 全文、プロジェクト README、この Runbook、章立て案、状態台帳、`MEMORY.md` を読む。
- `origin` を fetch し、remote default branch は fetch 後のローカル `origin/HEAD` から取得する。作業ツリーが遅れていれば、
  未コミット成果を失わない方法で取り込む。lambda 版（`exact-solution-of-2d-ising-model-lambda/`）には触れない。
- npm の対象は常に論文側の `structured-latex/package.json` とする。リポジトリ直下からは
  `npm --prefix exact-solution-of-2d-ising-model/structured-latex run gen`、同じ prefix で `run inventory:organization`、`run check` を実行する。
  別の作業場所からは prefix をその作業ツリー内の絶対パスにする。cwd に暗黙依存した `npm run` は使わない。
- 状態台帳の「次の一歩」だけを担当者が行い、別のエージェントが、章の割り当て・依存方向（前方参照の有無）・
  ゴールの式との一致・物理用語の混入・数学の中身が変わっていないこと・高校生可読性をレビューする。
  指摘があれば同じ単位を修正して再レビューし、未解決のまま次へ進まない。
- 検証を全て通す：論文側の `check`・`build:html`・`build:pdf`、`node sagemath/tools/verify-check-linkage.ts`、
  `lean/` で `lake build` と `bash scripts/check-no-sorry.sh`。
- 論文本文の HTML（`build:html`）と論文構成のページ（`build:organization-artifact`）を作り直し、skill `publish-artifact` で
  名前空間 `math` のパス `complex-matrix-ising-paper` と `complex-matrix-ising-paper-organization` へ公開し直す。
  公開後に `bash scripts/verify-complex-matrix-ising-paper-artifacts.sh` を通す。
- 状態台帳と `MEMORY.md` を更新してコミットし、成果コミットを remote default へ反映し、fetch 後の包含確認までを同じ作業で行う。
  non-fast-forward 時は remote default を取り込み、再検証してから反映する。

## 並行して本文を触る作業との衝突

lambda 版の証明の積み上げ（連続実行「可算二次元イジング: 証明の積み上げ」）は、式変形の書き方の統一のために
この論文の `content/` のブロックも書き換える。ブロックを移した回で rebase が衝突したら、相手の書き換え（証明の中身）を残し、
こちらの移動をその上にやり直す。相手の書き換えを捨てない。

## 分類規則

- 「数学的道具立て」は、2次元イジング模型を一切参照せずに定義・主張できる複素数・複素行列の道具を含む。参照回数は分類条件にしない。
- 記号の由来がスピン、格子、転送行列、全スピン反転行列、Jordan–Wigner 行列族等に依存するなら、イジング側（分配関数以降の部）に置く。
  一般化できそうという印象だけで道具章へ移さない。
- 人手本文は複素数と具体的複素行列に固定する。必要十分な抽象化は Lean の中だけに置く。

## 継続実行の資産

- 章立て案: `docs/tasks/six-chapter-organization-proposal.md`
- 状態: `docs/tasks/paper-organization-state.md`
- 棚卸し: `docs/organization/flat-inventory.json`
- 棚卸し生成器: `structured-latex/tools/build-flat-inventory.ts`
- 公開物の検証: `scripts/verify-complex-matrix-ising-paper-artifacts.sh`（リポジトリ直下）
