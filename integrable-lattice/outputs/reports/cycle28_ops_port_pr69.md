# cycle 28 step 5: 救済 PR #69 の 1 コミット分を、主張だけ現在の main の上へ移植した

変更: `lean/IntegrableLattice/PropCPeriod.lean`（**3 定理を追記**）、
`lean/scripts/check-no-sorry.sh`（380 → **383 定理**）。

## 何が救済ブランチにあったか（実測）

PR #69（`worktree-piped-brewing-kahan`、1 コミット `84f4ed5`）が触っているのは 3 ファイル:
`PropCPeriod.lean`（新規 187 行）、`logs/cache-get.log`（削除）、`refs.bib`（230 行の変更）。

管理役のコメントは「命題 C の『純周期性から最終周期を出して整除を結論する段』が入っており、
main には `eventualPeriod` / `pisanoPeriod` を含むファイルが 1 つも無い」と記録していた。
**この記録は正しい。** ただし実測すると、状況はもう少し細かい。

**main には既に大部分が在った。** 現在の `PropCPeriod.lean` は
`orderOf_reduction_dvd`（$\pi(p,k)\mid\pi(p,1)p^{k-1}$ そのもの）、
`isUnit_pow_add_eq_iff`（純周期性）、`isUnit_map_of_not_dvd_det`（$p\nmid\det T$ からの可逆性）を
**すべて証明済みで持っている**。両者は同じファイル名で**別々に発展した**結果、
主張の重なりが大きい。

**本当に欠けていたのは 1 点だけである**——「最終周期の**最小値**が `orderOf` に一致する」
という `IsLeast` の橋。人手証明は $\pi(p,k)$ を最終周期の最小値として導入しているので、
これが無いと、main が計算に使う `orderOf` が人手証明の $\pi(p,k)$ と同じものであることを
言えていない。

## そのままマージしてはいけなかった理由（2 つ。1 つは実測で増えた）

1. **分岐点が古い。** 分岐点は `45a689e` で、現在の main との差はブランチ側から見て
   772 ファイル・11 万行超の削除になる（管理役のコメントのとおり）。
2. **救済側の実装は未証明の穴を含んでいた。** `isUnit_intCast_matrix_of_not_dvd_det`
   （$p\nmid\det T$ なら $T\bmod p^k$ は可逆）が**証明されていない**。
   このリポジトリは未証明の穴を禁じているので、そのまま取り込めばビルドは通っても検査で落ちる。
   **この点は PR のコメントに記録されていなかった。**

## どう移植したか

**コードを持ってこず、主張だけを現在の main の上へ書き直した。**

- `isLeast_eventualPeriod` — 単元 `A` について、最終周期の最小値が `orderOf A` であること。
  証明は main の `isUnit_pow_add_eq_iff` をそのまま使う（救済側は同じ内容を
  `pow_eq_one_of_isUnit_of_eventually_periodic` として別に書いていたが、main の形のほうが強い——
  向こうは「$N_0$ 以上の全ての $N$ で」を仮定するのに対し、main の形は各 $N$ について同値を述べる）。
- `isOfFinOrder_of_isUnit_of_finite` — 有限モノイドの単元は有限位数。
  **行列環は簡約モノイドではないので `isOfFinOrder_of_finite` を直接は使えない。**
  単元の成す群へ移してから `orderOf_units` で戻す。救済側はこの一歩を書いておらず、
  `isOfFinOrder_of_finite` をそのまま呼んでいた（現在の mathlib では型が合わない）。
- `isLeast_eventualPeriod_reduction` — 整数行列版。未証明だった可逆性の補題の代わりに、
  main の `isUnit_map_of_not_dvd_det` を使う。**未証明の穴は 1 つも持ち込んでいない。**

**持ってこなかったもの**: `pisanoPeriod` / `pisanoPeriodOne` という定義と `pisanoPeriod_dvd`。
これらは main の `orderOf_reduction_dvd` と**同じ主張の別名**であり、
名前を増やすだけで内容が増えない。救済側が別名を必要としたのは、
そのブランチに `orderOf_reduction_dvd` が無かったからである。

`refs.bib` の変更と `logs/cache-get.log` の削除は移植していない。前者は現在の main の
`refs.bib`（cycle 24 以降のローカライズ作業で書き換わっている）と系統が違い、
後者はログの削除であって成果ではない。

## 検証

`lake build` 8684 jobs exit 0、`check-no-sorry.sh` **383 定理**すべて sorryAx 非依存。

## 自分の誤りの記録

**doc コメントに `sorry` という語を書き、検査を自分で赤くした。**
「救済側は補題に `sorry` を残していた」と経緯を書いたところ、
`check-no-sorry.sh` の第 1 段（ソース中の `sorry` / `admit` の grep）が拾った。
検査は語を見るのであって文脈を読まない。「未証明のまま残していた」と書き直した。
**検査が正しく働いた例**でもある。

## 限界

- 移植したのは**主張**であって、救済ブランチのコミットそのものではない。
  ブランチは PR を閉じたあと参照されなくなるので、**内容がこのファイルへ入ったことが
  唯一の記録になる**（本 report と `PropCPeriod.lean` の節コメントに経緯を残した）。
- 命題 C の整除方向はこれで閉じたが、**等号（Wall 型）は一般に偽**であり形式化の対象ではない
  （cycle 6 で 572 件中 4.5% の反例）。この扱いは移植前後で変わっていない。
