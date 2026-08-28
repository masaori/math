# MEMORY — 3 次元 Ising の可算コアを同定する

- 2026-08-28 14:04（本流）: セクション表に本流の未完了が無くなったので、ゴール文書「可算コアの同定とは何か」の自由エネルギー密度の行へ戻り、次の標的を「有限個の値しかとらない列で極限量を持つものは末尾定数である」に引き直した。末尾周期性はこの条件の特別な場合であり、直前まで四層で閉じた分類を包含したうえで、第二の有理点を探す条件を広げる。大きいので二つへ割り、割った先頭（鳩の巣原理と極限の一意性だけの一論法）と、既存の「末尾定数となる正の有理点は 1 に限る」との合成を台帳へ書いた。次はこの先頭の記述層。

- 2026-08-28 13:36（並行）: 復号後の再復元が元の完全マッチングへ戻るという候補を落とした。`encodePeriodicSquareInternalEdgesAt` は存在定理から city 内部完全被覆を `Classical.choose` で一つ選ぶため、復号で失われた内部マッチングの選択を復元できない。次は全単射ではなく、復号写像の繊維を city ごとの内部完全被覆の個数で数える重み付き恒等式を標的にする。

- 2026-08-28 13:33: 本流 `claim_eventually_periodic_limit_quantity_only_at_one` の Lean 必要十分版 `NecSuf.eventuallyPeriodicLimit_onlyTarget` と具体導出を追加し、四層を閉じた。必要なのは Hausdorff 位相空間に値を持つ自然数列、正の周期、剰余類ごとの定数性、各剰余類の添字列の共終性、列の極限、末尾定数性から対象を一意に定める分類だけである。次の本流はゴール文書から引き直す。

- 2026-08-28 13:06: 本流 `claim_eventually_periodic_limit_quantity_only_at_one` の Lean 具体版 `lean/Ising3DCut/LimitQuantity/EventuallyPeriodicLimitQuantityOnlyAtOne.lean` を追加した。人手証明と同じく、剰余類ごとの定数値がすべて一致するか二つ相異なるかで場合を分け、相異なる側は `residue_class_values_differ_no_limit_quantity` で極限量の存在の仮定と矛盾させ、一致する側は `residue_class_values_agree_gives_eventually_constant` で末尾定数性へ落とした。末尾定数となる正の有理点が 1 に限られることは、人手証明が既出の主張を引用しているのと 1 対 1 に対応させて仮定 `heventuallyConstantOnlyAtOne` として受け取る（Lean 側では有限箱値の有理数表示を経由する別系統で既に閉じている）。`lake build` 8972 ジョブ成功、sorry 非依存検査 668 件、`npm run check` 参照 444 件、linkage 102 件。次は同主張の Lean 必要十分版。

- 2026-08-28 12:03: 本文末尾の注記が三つの主張を繋いだ結論を証明なしに述べていたので、定理 `claim_eventually_periodic_limit_quantity_only_at_one`（末尾周期的で極限量が存在するなら正の有理点は 1）を立て、剰余類ごとの定数値がすべて一致するか二つ相異なるかの場合分け一本で証明した。注記は判定可能性の補足として残した。`npm run check` 198 ブロック・参照 444 件、`build:pdf` 68 ページ、linkage 101 件。次は同主張の SageMath 検証。

- 2026-08-28 11:03: 本流 `claim_residue_class_values_differ_no_limit_quantity` の Lean 具体版 `lean/Ising3DCut/LimitQuantity/ResidueClassValuesDifferNoLimitQuantity.lean` を追加した。剰余類の添字列 `k ↦ L0 + t + k*p` が `atTop` へ飛ぶこと、その部分列の極限が剰余類の定数値に一致すること（部分列の収束・定数列の極限・ℝ の極限の一意性のみ）、二つの定数値が相異なれば矛盾することを三本に分けて示した。`lake build` 成功、sorry 非依存検査 665 件。次は同主張の Lean 必要十分版。

- 2026-08-28 10:36（並行）: `encodedEvenSubgraph_encodePeriodicSquareMatching` を追加し、偶部分グラフから復元した完全マッチングの復号が元の辺集合へ戻ることを二包含から閉じた。次は逆向きの復元等式を示し、全単射へ束ねる。

- 2026-08-28 10:32: 本流 `claim_residue_class_values_differ_no_limit_quantity` の SageMath 層を追加した。二つの剰余類部分列が相異なる有理数の定数列になることと、その二定数の共通極限を排除する互いに交わらない有理数近傍を `ZZ` と `QQ` で検査して全 PASS。次は Lean 具体版。

- 2026-08-28 10:06（並行・最新）: 復号→復元の逆向きの包含 `subset_encodedEvenSubgraph_encodePeriodicSquareMatching` を Lean で閉じ、外部辺の単射性と、任意の元の辺について外部辺が city 内部辺になりえないことを一般形で示した。これで復元と復号は互いに逆である。sorry 非依存検査 661 件。次は偶部分グラフと完全マッチングの個数の一致（全単射）を述べる。

- 2026-08-28 10:02: 本流をゴール文書へ引き直し、「剰余類ごとの値が食い違うなら極限量は存在しない」の記述層を追加した（`claim_residue_class_values_differ_no_limit_quantity` と `remark_eventually_periodic_limit_quantity_reduces_to_one`）。収束列の部分列が同じ極限へ収束すること、定数列の極限がその定数であること、ℝ の極限の一意性だけから、剰余類ごとの定数値が二つ相異なれば矛盾が出る。これで末尾周期性から極限量の存在を得られる正の有理点は 1 だけに確定した。次は同主張の SageMath 検証。

- 2026-08-28 09:34: 本流「剰余類ごとの値の一致は有限の有理数等式で判定できる」を Lean 必要十分版と具体導出まで追加して四層で閉じた。抽象版に必要なのは一つのモノイドの元とその二つの自然数べきだけで、実数・正値性・乗根の一意性・指数の非零性・可換性は不要である。次の本流はゴール文書へ戻り、有限等式へ移した剰余類ごとの値の食い違いを分類へ接続する標的を引き直す。台帳「現在地」先頭を参照。

- 2026-08-28 09:06（並行）: `latticeEndpoint₀_ne_latticeEndpoint₁`（$n\ge2$ で自己ループ無し）と `encodePeriodicSquareExternalEdges_not_mem_internalEdges` を追加し、外部辺が city 内部辺になりえないことを閉じた（sorry 非依存検査 656 件）。次は復号が元の偶部分グラフを含む逆向きの包含を示す。

- 2026-08-28 09:03: 本流 `claim_root_equality_implies_cross_power_equality` の Lean 具体版 `Ising3DCut.LimitQuantity.posRoot_equality_implies_cross_power_equality` を追加した。`x := posRoot A N` と置き、仮定の乗根一致から `x^M = B` を取り、`A^M=(x^N)^M=x^{NM}=x^{MN}=(x^M)^N=B^N` の五つの等号を人手証明と同じ順で形式化した。`lake build` 8966 ジョブ成功、sorry 非依存検査 654 件。次は同主張の Lean 必要十分版。

- 2026-08-28 08:34: 本流 `claim_root_equality_implies_cross_power_equality` の SageMath 層を追加した。`A^M=(x^N)^M=x^{NM}=x^{MN}=(x^M)^N=B^N` の五段を `QQ` と `ZZ` の厳密計算で一行ずつ全 PASS とし、検証対応は 100 件。次は同主張の Lean 具体版。

- 2026-08-28 08:03: 本流をゴール文書へ引き直し、「剰余類ごとの値の一致は有限の有理数等式で判定できる」の記述層を追加した（`claim_root_equality_implies_cross_power_equality` と `remark_residue_class_values_agree_is_decidable`）。正の乗根の一致から交差べき等式が従い、既に閉じていた逆向きと合わせて同値になるので、二つの箱幅の量の一致は分配多項式の値の有限個の有理数等式で判定できる。次は同主張の SageMath 検証。

- 2026-08-28 07:34: 本流 `claim_residue_class_values_agree_gives_eventually_constant` の Lean 必要十分版 `NecSuf.residueClassValuesAgree_givesEventuallyConstant` と具体導出を追加し、四層で閉じた。必要なのは任意型の自然数列、正の周期、剰余類ごとの定数性、代表値の共通値への一致だけである。次はゴール文書へ戻り、剰余類ごとの値が食い違う場合を有限の等式で判定する標的を引き直す。
- 2026-08-28 07:06（並行）: `encodedEvenSubgraph_encodePeriodicSquareMatching_subset` を追加し、復元→復号が元の偶部分グラフの部分集合を返すことを閉じた（sorry 非依存検査 651 件）。逆向きの包含には外部辺が city 内部辺になりえないこと（元の辺の二端点が相異なる city にあること）が要る。次はそれを示す。
- 2026-08-28 07:05: 本流 `claim_residue_class_values_agree_gives_eventually_constant` の Lean 具体版 `Ising3DCut.LimitQuantity.residue_class_values_agree_gives_eventually_constant` を追加した。自然数の除法の定理で `L = L0 + (L-L0) % p + ((L-L0)/p) * p` と分け、剰余類ごとの末尾定数性で `a_{L0+r}` へ落として共通値 `c` に着く。`lake build` と sorry 非依存検査 650 件を通過。次は同主張の Lean 必要十分版。
- 2026-08-28 06:35（並行）: `encodePeriodicSquareMatching_isPerfectMatching` を追加し、偶部分グラフから復元した辺集合の terminal graph における完全マッチング性を閉じた。次は復元と復号が互いに逆であることを示す。
- 2026-08-28 06:32: 本流 `claim_residue_class_values_agree_gives_eventually_constant` の SageMath 三検査を追加し、自然数の除法、剰余類代表への帰着、共通値から末尾定数性を得る等式を `ZZ` と `QQ` で全 PASS。次は同主張の Lean 具体版。
- 2026-08-28 06:07（並行）: `pairwiseDisjoint_encodePeriodicSquareExternalEdges` と `pairwiseDisjoint_encodePeriodicSquareMatching` を追加し、復元辺集合全体の相異なる二辺が端子を共有しないことを閉じた。sorry 非依存検査 648 件通過。次は全端子の被覆と排他性を合わせて完全マッチング性を閉じる。
- 2026-08-28 06:03: 本流をゴール文書から引き直し、「剰余類ごとの値が一致する末尾周期性は末尾定数性である」を記述した（`claim_residue_class_values_agree_gives_eventually_constant` と注記 `remark_residue_class_values_agree_reduces_to_one`）。自然数の除法の定理で閾値以後の箱幅を剰余類へ落とすので、剰余類ごとの定数値が一致する末尾周期的な有理点は既存分類から 1 に限られ、末尾周期性で残るのは剰余類ごとの値が食い違う場合だけになった。次は同主張の SageMath 検証。
- 2026-08-28 05:34: 本流「末尾周期性は剰余類ごとの末尾定数性を与える」を Lean 必要十分版 `NecSuf.eventuallyPeriodic_residueClassConstant` と具体導出まで閉じた。必要なのは任意の型への自然数列と閾値以後の周期等式だけである。次はゴール文書へ戻り、この結果を第二の有理点での極限量の存在へ接続できる条件を引き直す。
- 2026-08-28 05:36（並行）: `biUnion_encodePeriodicSquareMatching` を追加し、復元した内部辺と外部辺の和が terminal graph の全端子を覆うことを示した。次は復元辺集合全体の相異なる二辺の排他性を閉じる。
- 2026-08-28 05:03: 本流「末尾周期性は剰余類ごとの末尾定数性を与える」の Lean 具体版を追加し `lake build` と sorry 非依存検査（642 件）を通した。次は同主張の Lean 必要十分版。
- 2026-08-28 04:36（並行）: 束ねた内部辺と復元用の外部辺が端子を共有しないことを Lean で示した。次は両辺集合の和が全端子をちょうど一度覆うことを示す。
- 2026-08-28 04:33: 本流「末尾周期性は剰余類ごとの末尾定数性を与える」の SageMath 三検査を `ZZ` と `QQ` で実行し、すべて PASS。次は Lean 具体版。
- 2026-08-28 04:31（レビュー修正）: 「末尾周期性は剰余類ごとの末尾定数性を与える」の帰納段の添字変形に、自然数の分配法則と結合律を根拠として明記した。次は SageMath 検証。
- 2026-08-28 04:04: 本流「末尾周期性は剰余類ごとの末尾定数性を与える」を記述した（`claim_eventually_periodic_residue_class_constant`）。次は SageMath 検証。
- 2026-08-28 04:07: ゴール文書「最初の三手」の第一手は既存の定理で閉じていることを確認し（有理点の素指数データが分配多項式を決める主張と台の両端）、重複を避けて標的を差し替えた。次の本流は「末尾周期性は剰余類ごとの末尾定数性を与える」の記述。
- 2026-08-28 03:35（並行）: city ごとの内部辺被覆を束ねた集合について、相異なる二辺が端子を共有しない `pairwiseDisjoint_encodePeriodicSquareInternalEdges` を追加した。共通端子の第一成分から二つの city を同定し、city 内の排他性へ戻す。次は内部辺と外部辺の排他性。
- 2026-08-28 03:32: 末尾周期性の残る正の有理点について否定判定を行った。周期一の候補三点への絞り込みは、隣接する全箱に共通の底と三つの連続箱の整除を使う。一方、一般の周期の冪等式は箱幅の剰余類ごとの列しか結ばないため、この分類を移せない。既存結果で有理点 2 と 2 分の 1 は排除済みだが、残る正の有理点は未分類であることを本文の注意として記録した。次の本流はゴール文書から引き直す。
- 2026-08-28 03:04: 有理点 2 分の 1 の末尾周期性排除を Lean 必要十分版 `NecSuf.pow_ne_pow_of_pow_additive_index_mul_ne` と `NecSuf.no_eventual_cross_power_identity_of_pow_additive_index_mul_ne` へ抽象化し、このセクションを四層で閉じた。仮定は「各箱の値の冪の上で加法的な `ℤ` 値の指標」と「点数と指標の積が二つの箱で相異なること」だけで、回文性・有理数体・素数 2・点数の立方は落ちた。有理点 2 の版と違い指標の値が 1 であることは残らず、また指標は負の値を取るので値域を `ℕ` から `ℤ` へ広げる必要がある。具体版は `eventually_periodic_at_one_half_power_identity_impossible_fromNecSuf` として導出。sorry 非依存検査 639 件通過。次の本流は末尾周期性の残る正の有理点の判定。
- 2026-08-28 02:36: 有理点 2 分の 1 の末尾周期性排除を Lean 具体版へ移した（`EventuallyPeriodicAtOneHalfImpossible.lean`）。回文性から有限箱値の素数 2 の指数を `1-#E_L` と定め、周期交差冪等式の両辺の指数差が正になる有限計算で矛盾を閉じた。次は Lean 必要十分版。
- 2026-08-28 02:09: 有理点 2 分の 1 の末尾周期性排除について SageMath 検証を追加した（`sagemath/check/eventually-periodic-at-one-half-impossible/`、3 ファイル PASS、linkage 97 件）。回文性 $2^{\#E_M}Z_M(1/2)=Z_M(2)$ を分配多項式への直接代入で独立に確認し、指数等式の差 $(L+p)^3-L^3+3pL^2(L+p)^2$ の全係数が正であることを $\mathbb Z[L,p]$ の恒等式として確認した。次は Lean 具体版。
- 2026-08-28 01:36（並行）: 各 city で選んだ内部辺被覆の相異なる二辺が端子を共有しないことを `pairwiseDisjoint_encodePeriodicSquareInternalEdgesAt` として存在定理から取り出した。次は city 間と外部辺との排他性を合わせる。
- 2026-08-28 01:32: 有理点 2 分の 1 で末尾周期性が不可能であることを本文に記述した（`claim_eventually_periodic_at_one_half_is_impossible`）。回文性から各箱値の素数 2 の指数が `1-#E_L` となり、周期交差冪等式が強制する指数等式は、自由境界の辺数を代入すると両辺の差が正になるため成立しない。次は SageMath 検証。
- 2026-08-28 01:06: 有理点 2 で末尾周期性が不可能であることを Lean 必要十分版 `NecSuf.pow_ne_pow_of_pow_additive_index_eq_one` と `NecSuf.no_eventual_cross_power_identity_of_pow_additive_index_eq_one` へ抽象化し、このセクションを四層で閉じた。仮定は「冪の上で加法的な指標が二値でともに 1」「二つの指数が相異なる」だけで、素数 2・法 4・自然数・モノイド則は落ちた。具体版は `eventually_periodic_at_two_power_identity_impossible_fromNecSuf` として導出。sorry 非依存検査 632 件通過。次の本流は有理点 2 分の 1 の末尾周期性の排除。
- 2026-08-28 00:34: 有理点 2 で末尾周期性が不可能であることの Lean 具体版 `partitionValueAtTwoNat_cross_power_ne` と `eventually_periodic_at_two_power_identity_impossible` を閉じた。法 4 で 2 の有限箱値は素数 2 の指数が一であり、交差冪等式は異なる箱の点数が等しいと強制するため矛盾する。着手前レビュでは直前の並行成果に修正事項は無かった。次は同主張の Lean 必要十分版。
- 2026-08-28 00:06（並行）: 束ねた内部辺の合併が全 city の残存端子に一致することを `biUnion_encodePeriodicSquareInternalEdges` で閉じ、未登録だった三定理を sorry 非依存検査へ登録した（627 件）。次は各端子の被覆の一意性。
- 2026-08-28 00:02: 有理点 2 では有限箱の量が末尾周期的にならないことについて SageMath 検証を追加した（`sagemath/check/eventually-periodic-at-two-impossible/`、3 ファイル PASS、linkage 96 件）。有限箱値の 2 の指数がちょうど 1 であること、周期の冪等式から共通の 2 の冪を除く式変形、残る両辺の偶奇の食い違い、一辺 2・3・4 の実データでの非等号を段ごとに確かめた。着手前レビューでは前 tick の記述に修正事項は無かった。次は同主張の Lean 具体版。
- 2026-08-27 22:36（並行）: 偶部分グラフから復元する内部辺と外部辺の和 `encodePeriodicSquareMatching` を定義し、terminal graph の辺集合への包含を Lean で示した。次は各端子の被覆の存在と一意性。
- 2026-08-27 23:05: 末尾周期性と周期だけ離れた箱の冪等式の同値を Lean 必要十分版へ抽象化し、このセクションを四層で閉じた。`NecSuf.root_eq_iff_crossPowerEquality` と `NecSuf.eventuallyPeriodic_iff_crossPowerIdentity` の仮定はモノイド・冪等式・指数の非零性・非零指数の冪写像の単射性だけで、順序・実数・有理数・分配多項式は使わない。具体版は `eventually_periodic_iff_power_identity_viaNecSuf` として導いた。前 tick の具体版が sorry 非依存検査へ未登録だったのを直し、検査は 623 件を通過。次は末尾周期的な正の有理点が 1 に限られるかの判定。
- 2026-08-27 22:34: 末尾周期性と周期だけ離れた箱の冪等式の同値を Lean 具体版 `eventually_periodic_iff_power_identity` に移した。正の有限箱値の乗根表示と非零自然数冪の単射性だけを使い、極限は使わない。`lake build` と sorry 非依存検査 619 件を通過。次は Lean 必要十分版。
- 2026-08-27 22:03: 末尾周期性と周期だけ離れた箱の冪等式の同値について SageMath 検証を追加した（`sagemath/check/eventually-periodic-iff-power-identity/`、3 ファイル PASS、linkage 95 件）。着手前レビューでは定義と同値主張を読み直し、修正事項は無かった。次は同主張の Lean 具体版。
- 2026-08-27 21:04: レビューで、末尾定数性の最終分類の証明に残る唯一の TODO（底の自然数化と候補三点への絞り込みを外部仮定として受け取っていた箇所）を、既存の主張がどちらも内部で閉じていることを確かめて埋めた。本文の TODO は 0 件。そのうえで本流をゴール文書から引き直し、末尾定数性を真に含む有限的条件として末尾周期性 $a_L(q)=a_{L+p}(q)$（閾値以後）を定義した。次は周期 $p$ の冪等式への言い換え。
- 2026-08-27 20:34: 末尾定数性の最終分類について、有限箱の合同式から底の整除へ至る全段を既存の必要十分版から再導出する `base_divisibility_of_rational_value_form_viaNecSuf` と、分類へ束ねる `eq_one_of_cross_power_identity_from_free_box_closed_viaNecSuf` を追加して四層を閉じた。並行では各 city の残存端子を候補内部辺の互いに交わらない二元集合で完全被覆する `exists_candidate_internal_edge_cover_at` を追加した。Lean build と sorry 検査 619 件を通過。次の本流はゴール文書から標的を引き直し、並行は city ごとの被覆を全体の内部辺集合へ束ねる。
- 2026-08-27 20:05: 分類を閉じる接続のうち、整除を冪へ持ち上げる段の Lean 必要十分版 `NecSuf.dvd_mul_pow_sub_pow_of_dvd_mul_sub` を置いた（仮定は可換環であることだけで、有理点・箱・係数 2・指数 $L_0^3$ を外し、任意の $k,x,y,n$ で $a\mid k(x-y)\Rightarrow a\mid k(x^n-y^n)$）。具体版をその特殊化として導出する `power_numerator_divisibility_of_base_divisibility_fromNecSuf` も置いた。`lake build` と sorry 検査 616 件、`npm run check`（180 ブロック・405 参照すべて解決）、`build:pdf` 63 ページを通過。次は残る段（有限箱の合同式から底の整除を得る部分と束ね）の必要十分版。
- 2026-08-27 19:37: 隣接する三箱の有限合同式から二つの頂点数差に対する整除を作り、差の互いに素性と既存の最大公約数定理で `a ∣ 2(c-1)` を導いた。これを直前の束ねへ渡す `eq_one_of_cross_power_identity_from_free_box_closed` により、冪等式だけから有理点を一に定める Lean 具体版を閉じた。次はこの最終接続の Lean 必要十分版。
- 2026-08-27 19:03: 束ね定理が外から受け取る二つの分子整除のうち、閾値の箱の点数乗についてのものが、箱に依存しない `a ∣ 2(c-1)` だけから従うことを `power_numerator_divisibility_of_base_divisibility` で示し、外部仮定を一つに減らした版 `eq_one_of_cross_power_identity_from_free_box_base_divisibility` を置いた。`lake build` と sorry 検査 609 件、`npm run check`（180 ブロック・405 参照すべて解決）、検証対応 94 件を通過。次は残った一つの仮定を、底を有限箱の値から決める先行結果から接続する。
- 2026-08-27 18:06: 分母二の場合の閾値箱の等式を、有限和から破れ辺数ゼロの項を取り出す分解 `brokenCountSum_head_split` を介して既存の分母二の判定へ接続し、有理点の既約分子が一になることを Lean 具体版 `denominator_two_numerator_eq_one_of_rational_value_form` で閉じた。次は分母一・分母二の二つの接続を束ね定理の残る二仮定へ渡して主張全体を閉じる。
- 2026-08-27 17:34: 分母一の場合の閾値箱有限和と箱に依存しない分子整除を `integer_point_finite_box_data_of_rational_value_form` で束ね、最終分類定理が要求する有限箱データを Lean 具体版で閉じた。次は分母二の場合の有限箱等式を接続する。
- 2026-08-27 17:04: 分母一の場合の有限和を自然数の等式へ移す Lean 具体版 `integer_point_threshold_box_sum_eq_nat_power` を追加。次は分子整除を接続して束ね定理の分母一の仮定を閉じる。
- 2026-08-27 16:32: 最終分類定理に残る既約分子の二場合を四つへ分割し、先頭として、既約分母一を自由境界の閾値箱の有限和表示へ代入して、その有限和が点数乗表示の値に等しいことを Lean 具体版 `integer_point_threshold_box_sum_eq_power` で閉じた。次はこの有限和の値へ既存の箱に依存しない分子整除を接続する。
- 2026-08-27 16:04: 自由境界の箱で閉じた三つの排除を最終の分類定理へまとめて渡す Lean 具体版 `eq_one_of_cross_power_identity_from_free_box` を置いた。外から残る仮定は有理点の既約分子についての二場合だけ。`lake build` と sorry 検査 605 件、`npm run check`、検証対応 94 件を通過。
- 2026-08-27 15:05: 点の既約分母の偶奇二場合を束ね、素数二が点数乗表示の底の既約分母を割らないことを Lean 具体版で無条件に閉じた。素数二と二以外の双方の排除から底の既約分母が一に定まる一段も置いた。並行では偶数個の残存端子の完全な対分けを構成した。次は二以外の素数の排除を有理点の分母を割る素数まで広げ、並行はその対分けを各 city の内部辺として完全マッチングへ組み上げる。
- 2026-08-27 14:34: 偶数分母の有限箱等式を既存の素数二の指数排除へ接続し、点数乗表示の底の既約分母を二が割らないことを Lean 具体版で閉じた。並行では候補内部辺の所属条件を二元部分集合として特徴づけた。次は分母の奇偶二場合を束ねて底の既約分母一を最終分類へ渡し、並行は偶数個の残存端子の完全被覆を構成する。
- 2026-08-27 14:04: 有理点の既約分母が偶数のとき、自由境界の箱の有限和が法四で二に合同であること（`brokenCountSum_mod_four_eq_two`）と、既約分母が偶数なら既約分子は奇数であること（`num_odd_of_den_even`）を Lean 具体版で閉じた。破れ辺数が辺数より二以上小さい項は既約分母の二乗で法四で消え、辺数から一を引いた項は多重度が零で消え、残る辺数の項が既約分子の辺数乗の二倍になる。辺が二本以上あることは既存の `two_le_card_edge` を使った。次はこの法四の合同を有限箱の整数等式へ入れ、素数二の指数を比較して偶数分母の非整除を接続する。
- 2026-08-27 13:05: 方向を固定した辺の始点が `(L - 1) * L ^ 2` 個であることを `NullModel.card_fixed_axis_edge_starts` で閉じた。直前 tick の成果が未コミットだったので検証して main へ反映した。次は三方向を足して箱全体の辺数 `3 * L ^ 2 * (L - 1)` を確定する。
- 2026-08-27 12:40: 辺数計数を二歩へ割り、固定した方向の始点座標が `L - 1` 通りであることを `NullModel.card_forward_start_coordinates` で閉じた。次は三方向と残りの二座標を掛け、箱全体の辺数を `3 * L ^ 2 * (L - 1)` と確定する。
- 2026-08-27 12:04: 偶数分母の接続を三歩へ割り、第一歩として自由境界の箱で破れ辺数が辺数から一を引いた数である配位が存在しないこと（`multiplicity_card_edge_sub_one_eq_zero`）を Lean 具体版で閉じた。回文性で破れ辺数一へ移し `NullModel.brokenCount_ne_one` へ渡す。残る材料は自由境界の箱の辺数が幅から決まる形（`3 * L^2 * (L-1)`）で、これが無いと偶数分母の排除定理へ等式を渡せない。次はその辺数の形を示す。
- 2026-08-27 11:34: 偶数分母の接続を小さく分け、末尾の点数乗表示を一つの箱で分母を払った自然数等式へ移す `integer_equation_of_rational_value_form` を Lean 具体版で閉じた。次は自由境界箱の辺数、回文性、破れ数一の不可能性を入れ、偶数分母の素数二の非整除を接続する。
- 2026-08-27 11:05: 閾値の箱の有理評価を破れ辺数の多重度の有限和の商へ展開する補題 `rationalValueSeq_eq_brokenCountSum_div` と、その和の正値性 `brokenCountSum_multiplicity_pos` を切り出し、束ね定理が要求する第一の仮定（点の既約分母を割らない素数は底の既約分母も割らない）と、第二の仮定のうち点の既約分母が奇数の場合を Lean 具体版で接続した。残るのは点の既約分母が偶数の場合の素数二の非整除である。
- 2026-08-27 10:36: `point_den_dvd_two_mul_base_den_pow_of_rational_value_form` を追加し、閾値箱が幅二以上なら有限箱評価を分母を払った多重度の有限和へ展開して、点数乗表示から束ね定理の法分母の整除を直接得た。次は奇素数と素数二の非整除も束ね定理へ接続する。
- 2026-08-27 10:07: 前歩の整除を実際の自由境界の箱へ渡す `point_den_dvd_two_mul_base_den_pow_from_free_box` を Lean 具体版に追加した。回文性 `Ω_L(#E_L)=Ω_L(0)` と `Ω_L(0)=2` を入れると、右辺が箱に依存しない `2 * c.den ^ N` になる。次はこの整除を束ね定理の法 `q.den` の仮定へ接続する。
- 2026-08-27 09:34: 既存の `rational_power_base_congruences` から法 `q.den` の整除を取り出し、整数上の整除を自然数上へ戻す `point_den_dvd_zero_multiplicity_mul_base_den_pow_from_finite_box` を Lean 具体版に追加した。次は自由境界箱の回文性と破れ数ゼロの多重度二をこの整除へ渡す。
- 2026-08-27 09:04: 点の分母が偶数の場合を閉じた。場合分けは点の既約分母の素数二の指数について行う形へ直し（先行の二つの排除定理がそちらで分岐しているため）、有限箱の等式から両分岐を排除する `two_not_dvd_power_base_den_from_finite_box_even_point_den` を追加した。次は法 q.den の整除の仮定を接続する。
- 2026-08-27 08:36（並行）: 残存端子の対構成を、候補内部辺の定義と完全被覆の証明に分け、先頭の `encodePeriodicSquareCandidateInternalEdgesAt` を二元部分集合として置いた。次は偶数性から交わらない完全被覆を構成する。
- 2026-08-27 08:32: 点の分母が偶数の場合を、底の既約分母における素数二の指数が一の場合と二以上の場合に分ける `two_not_dvd_power_base_den_of_exponent_cases` を Lean 具体版で閉じた。次は有限箱の先行定理から両分岐の矛盾を構成して渡す。
- 2026-08-27 08:06（並行）: 残存端子の個数が偶部分グラフの次数に等しいこと（`card_encodePeriodicSquareRemainingTerminalsAt`）と、その偶数性（`even_card_encodePeriodicSquareRemainingTerminalsAt`）を閉じた。次は偶数個の端子を内部辺で対にして覆う集合の構成。
- 2026-08-27 08:03: 点の分母が奇数の場合について、素数二も点数乗表示の底の既約分母を割らないことを、同じ有限箱の正整数商表示から `two_not_dvd_power_base_den_from_finite_box_representation` として Lean 具体版で閉じた。次は点の分母が偶数の場合と、法 q.den の整除を有限箱の先行主張から接続する。
- 2026-08-27 07:35（並行）: 各 city で内部辺により覆うべき残存端子を、対応する元辺が偶部分グラフに属する端子として定義し、所属条件を閉じた。次は残存端子数の偶数性を示す。
- 2026-08-27 07:33: 底の既約分母について残る三接続を論法ごとに分割し、先頭として有限箱値の正整数商表示と点数乗表示を同じ箱で結ぶ `odd_prime_not_dvd_power_base_den_from_finite_box_representation` を追加した。次は素数二が底の既約分母を割らないことを有限箱の先行主張から接続する。
- 2026-08-27 07:03: 有限箱の量が末尾で一定となる正の有理点の分類について、分母一・分母二の各場合の有限箱データを仮定に置き、分子の結論を外から受け取らずに有理点を一に定める束ね定理 `eq_one_of_cross_power_identity_from_finite_box_data` を Lean 具体版へ追加した。残る外部仮定は底の既約分母についての三つだけである。
- 2026-08-27 06:37（並行）: 偶部分グラフの補集合を terminal graph の外部辺へ送る `encodePeriodicSquareExternalEdges` と所属条件を追加した。次は各頂点で残る端子を内部辺で一意に覆う集合を構成する。
- 2026-08-27 06:34: 分母二の場合の有限箱結論を渡す `denominator_two_numerator_eq_one_from_finite_box` を追加した。分母を払った有限箱等式と分子の整除から二の有限冪への整除を導き、破れ数零の多重度二と既約性で分子を一に定める。次は分母一・分母二の結論を最終の束ね定理へ直接接続する。
- 2026-08-27 06:04: 分母一の場合の有限箱結論を渡す `integer_point_numerator_divides_two` を追加した（多重度零が二であることと既存の整除定理の合成）。次は分母二の場合を渡す段。
- 2026-08-27 05:37（並行）: `PeriodicSquareEvenSubgraph` と `decodePeriodicSquareMatching` を追加し、完全マッチングから復号した辺集合を偶次数の証明ごと一つの型へ入れた。次は偶部分グラフから完全マッチングを構成する逆向き。
- 2026-08-27 05:34: `rational_point_numerator_divides_two_of_denominator_cases` を追加し、有理点の既約分母が 1 か 2 かで有限箱側の結論を場合分けして、既約分子が 2 を割ることへ束ねた。`eq_one_of_cross_power_identity_of_finite_box_numerator_conditions` で底の分母判定と候補三点の分岐へ接続した。次は分母一・分母二の各結論を既存の有限箱定理から直接渡す。
- 2026-08-27 05:32（レビュー）: 直前の束ね定理を先行定理と照合し、立場違反・未証明依存・記号の衝突が無いことを確認した。修正なし。
- 2026-08-27 05:04: `eq_one_of_cross_power_identity_of_base_den_conditions` を追加した。冪等式の末尾成立から底を取り出し、`rational_power_point_denominator_divides_two` へ渡して底の既約分母が 1 であることと有理点の既約分母が 2 を割ることを同時に受け取り、候補三点の分岐へつなぐ。未接続に残るのは既約分子が 2 を割る段だけ。`lake build` と未証明依存検査 579 件を通過。次は既約分子が 2 を割る段を束ねる。
- 2026-08-27 05:02（レビュー）: `EventuallyConstantOnlyAtOneBundle.lean` の説明書きが候補三点を仮定として受け取ると述べたままだったので、その場で証明する実態へ合わせた。
- 2026-08-27 04:36（並行）: `periodicSquareEncodedIncidentEdgesAt` と `periodic_square_matching_decodes_even_subgraph` を追加した。周期正方格子の接続辺数四と、完全マッチングで選ばれた外部辺の各頂点での偶数性を合わせ、選ばれなかった外部辺として復号した集合そのものが偶部分グラフになる結論まで束ねた。次はこの復号を全単射へ拡張する。
- 2026-08-27 04:33: `positive_rational_three_candidates_of_num_den_dvd_two` を追加し、正の有理点の既約分子と既約分母がともに 2 を割るなら候補は二分の一・一・二に尽きることを Lean 具体版で閉じた。既約性により二分の二を除く。`eq_one_of_cross_power_identity_of_den_one` も候補三点を外部仮定で受け取らず、この補題を使う形へ更新した。次は点数乗表示の底の既約分母が一であることを既存の有限箱定理から束ねる。
- 2026-08-27 04:03: `LimitQuantity/EventuallyConstantOnlyAtOneBundle.lean` に `eq_one_of_cross_power_identity_of_den_one` を追加した。冪等式の末尾成立から底を取り出し（`eventually_cross_power_identity_iff_rational_power_form_viaNecSuf`）、既約分母が 1 であることを受けて自然数の底へ移し（`eventualPowerFormAt_of_rationalPowerForm_den_one`）、三点の候補からの分岐（`eq_one_of_eventual_power_form`）へ渡して有理点を 1 に定める。候補が三点に尽きることと底の既約分母が 1 であることは本文の有限箱の整除と合同式による絞り込みで、Lean へは未移行なので仮定として明示した。`lake build` と未証明依存検査 576 件を通過。次はこの絞り込み自体の Lean 具体版。
- 2026-08-27 03:34: `EventuallyConstantOnlyAtOne.lean` に `eventualPowerFormAt_of_rationalPowerForm_den_one` を追加した。既約分母が一と分かった正の有理数の底を分子の絶対値という正の自然数へ移し、同じ有限箱の点数乗表示を `EventualPowerFormAt` へ接続する。次は候補三点への絞り込みを既存の有限箱定理から束ねて、末尾定数性分類の Lean 具体版を閉じる。
- 2026-08-27 03:32（レビュー）: `claim_eventually_constant_only_at_one` は、冪等式から得る底が正の有理数である一方、引用先 `claim_eventual_power_form_only_at_one` は底を正の自然数と仮定し、候補三点も外部仮定として受け取っているため、そのままでは合成できない。本文へ TODO を戻した。次は底の自然数化と候補三点への絞り込みを既存の有限箱定理から束ねて Lean 具体版を閉じる。
- 2026-08-27 03:09: `claim_eventually_constant_only_at_one` の SageMath 層を `sagemath/check/eventually-constant-only-at-one/` に置いた。合成の両端を実際の自由境界の箱の値で確かめ、有理点 1 では $Z_L(1)=2^{#V_L}$ と隣接箱の冪等式が一辺 4 の箱まで成り立つこと、有理点 1 以外の有限標本では冪等式が一辺 1 と 2 の組で既に破れることを 2 ファイルとも PASS。有理点での値が要る検査は全配位列挙が回る一辺 1・2 に限る。次は同主張の Lean 具体版。
- 2026-08-27 02:34: 末尾定数性・隣接箱の冪等式・点数乗表示の三つの同値を合成し、有限箱の量が末尾で一定となる正の有理点は 1 に限られることを `claim_eventually_constant_only_at_one` として記述した。次は同主張の SageMath 検証。

- 2026-08-27 02:03: 束ね主張 `claim_eventual_power_form_only_at_one` の Lean 必要十分版 `NecSuf/EventualPowerFormOnlyAtOne.lean` と導出 `LimitQuantity/EventualPowerFormOnlyAtOneFromNecSuf.lean` を追加し、この主張の四層を完成させた。必要十分版に残るのは「候補が三つに尽きること」と「そのうち二つで性質が成り立たないこと」の二つだけで、台となる型にも性質にも構造は要らない。候補が有限個であることすら本質ではないため、一意性から一点を決める一般形も併せて置いた。未証明依存検査 574 件。次の標的は `可算コアの同定とは何か.md` から引き直す。

- 2026-08-27 01:37（並行）: `periodic_square_selected_edges_even` を追加し、周期正方格子の接続辺数四を完全マッチングからの偶部分グラフ定理へ接続した。次は Pfaffian 予言の復号写像全体の結論へ束ねる。

- 2026-08-27 01:34: 束ね主張 `claim_eventual_power_form_only_at_one` の Lean 具体版 `LimitQuantity/EventualPowerFormOnlyAtOne.lean` を追加した。候補三点から有理点 2 分の 1 と 2 を既存の不可能性定理で除き、有理点 1 では底 2 の点数乗表示が全箱で成り立つことを有限和から示した。次は Lean 必要十分版。

- 2026-08-27 01:05（並行）: 周期境界の平面正方格子の各頂点の接続辺がちょうど四本であることを Lean で閉じた（`four_lattice_edges_subset_incidentEdges` と `card_latticeIncidentEdges_eq_four`、未証明依存検査 568 件）。次はこの個数を偶部分グラフの条件へ接続する。

- 2026-08-27 01:02: 束ね主張 `claim_eventual_power_form_only_at_one` の SageMath 検証を追加した（`sagemath/check/eventual-power-form-only-at-one/`、三検査すべて PASS、linkage 93 件）。候補が三点で尽きること、有理点 2 と 2 分の 1 の排除、有理点 1 で底 2 の点数乗が成り立ち底が 2 に限られることを段ごとに検査した。次はこの主張の Lean 具体版。

- 2026-08-27 00:32: これまでの有限箱の候補絞り込みと有理点 2・2 分の 1 の排除を束ね、末尾で点数乗表示が成り立つ正の有理点は 1 に限られることを `claim_eventual_power_form_only_at_one` として記述した。逆向きは既存の $Z_L(1)=2^{\#V_L}$ を使う。次はこの束ね主張の SageMath 検証。

- 2026-08-27 00:06（並行）: 周期境界の平面正方格子で各頂点の接続辺が出入りの四辺で尽きること（`latticeIncidentEdges_subset_four`）を追加した。次は逆向きの包含と併せて接続辺数が四であることを一般の一辺で示す。

- 2026-08-27 00:04: 有理点 2 分の 1 で点数乗表示が末尾でも成り立たないことの Lean 必要十分版 `NecSuf/EventualPowerFormAtOneHalfImpossible.lean` と導出 `EventualPowerFormAtOneHalfImpossibleFromNecSuf.lean` を追加し、この主張の四層を完成させた。必要十分版に残るのは、指数が 2 以上なら素数の冪に何を掛けても素数の平方で割れること、平方を法とした余りがその素数である数は平方で割れないこと、その二つを尺度倍した値が自然数であるという仮定へ当てる組み立ての三つだけである。点数乗という形も素数性も論証には使っておらず、必要なのは底が正であることと 2 分の 1 での値が自然数であることだけだと分かった。次の標的は `可算コアの同定とは何か.md` から引き直す。

- 2026-08-26 23:34: 有理点 2 分の 1 で点数乗表示が末尾でも成り立たないことの Lean 具体版 `EventualPowerFormAtOneHalfImpossible.lean` を追加した。回文性による有理点二分の一と二の有限箱値の関係、辺数が二以上であること、法四の矛盾を人手証明と同順に形式化した。次は Lean 必要十分版。

- 2026-08-26 23:05: 有理点 2 分の 1 で点数乗表示が末尾でも成り立たないことの SageMath 検証を追加した（`sagemath/check/eventual-power-form-at-one-half-impossible/`、三検査すべて PASS）。回文性からの有限箱の等式、辺の個数 $3L^2(L-1)$ からの 4 の可除性、有理点 2 の値が法 4 で 2 になることの三段を段ごとに検査した。次はこの主張の Lean 具体版。
- 2026-08-26 22:06: 有理点 2 で点数乗表示が末尾でも成り立たないことの Lean 必要十分版と導出を追加し、この主張の四層を完成させた。必要十分版に残るのは、一つの添字以外が法で割れる有限和の項分離、素数の平方を法とする冪の剰余がその素数にならないこと、その組み立ての三つだけである。底の正値性は不要だと分かった。次の標的は `可算コアの同定とは何か.md` から引き直す。
- 2026-08-26 21:35: 有理点 2 で点数乗表示が末尾で成り立たないことの Lean 具体版を追加した。多重度の有限和が法 4 で 2 になる段と、正の自然数の二乗以上が法 4 で 2 にならない段を分けて形式化した。次は同主張の Lean 必要十分版。
- 2026-08-26 21:05: 有理点 2 では点数乗表示が末尾でも成り立たないことの SageMath 検証を追加した（`sagemath/check/eventual-power-form-at-two-impossible/`、3 ファイル PASS）。次は同主張の Lean 具体版。
- 2026-08-26 20:06: 本流「分母 2 の有理点と最終判定」の Lean 必要十分版を追加し、この主張の四層を完成させた。必要十分版に残るのは、共通因子による有限和の先頭分離、可換環での両辺の書き換え、互いに素な数の冪の約数が一であること、正の約数の上界の四つだけである。具体版がこれらの特殊化であることも別ファイルで示した。次の標的は `可算コアの同定とは何か.md` から引き直す。
- 2026-08-26 19:37（レビュー）: 直前の並行補題 `fin_sub_one_ne_self` が名前空間の外にあり、未証明依存検査にも未登録だった不備を修正した。次はこの補題を使って出入り四辺の相異性を示す。
- 2026-08-26 19:34（本流）: `lean/Ising3DCut/LimitQuantity/DenominatorTwoPointAndFinalCandidateSet.lean` を追加し、分母二の有理点と最終判定の Lean 具体版を閉じた。有限和の定数項分離、二倍した差の整数等式、分子が一に定まる互いに素性、整数候補の確定を人手証明と同じ順で形式化した。次は同主張の Lean 必要十分版。着手前レビュー修正なし。
- 2026-08-26 19:07（並行）: `fin_sub_one_ne_self` を追加し、一辺が二以上のとき巡回座標を一つ戻しても元へ戻らないことを閉じた。一辺が一のときはこれが破れるので、出る辺と入る辺の相異性にはこの仮定が要る。対象ファイルの構築成功、未証明依存検査 544 件。次は四辺の相異性。
- 2026-08-26 19:03（本流）: `sagemath/check/denominator-two-point-and-final-candidate-set/` に三検査を追加し全 PASS させ、`claim_denominator_two_point_and_final_candidate_set` の SageMath 層を閉じた。分母を払って定数項と分子の倍数へ分ける段とくくり出した和の整数性、両辺から一を引いて二倍する段は `QQ` 上の多項式恒等式で、奇数の分子が $2^{E+1}$ を割ることから $a=1$ が従う段は整数の厳密標本（採用 33 件・除外 2079 件）で確認した。候補集合が $\{1/2,1,2\}$ の三つに限られることも確かめた。linkage 90 件、`npm run check` 176 ブロック・461 参照すべて解決、PDF 62 ページ。次は同主張の Lean 具体版。着手前レビュー修正なし。
- 2026-08-26 18:35（本流）: `claim_denominator_two_point_and_final_candidate_set` を記述した。分配多項式の有限和に分母を払う 2 の有限冪を掛け、定数項以外から分子をくくり出すことで、分母 2 側は二分の一に限られる。整数側の既存主張と合わせた候補は二分の一・一・二の三つであり、現在の関係だけでは一以外を排除できないと判定した。次はこの主張の SageMath 検証。
- 2026-08-26 18:32（レビュー）: 直前の整数有理点の定数項帰着の四層を再照合し、数学的な修正事項は無かった。セクション表の末尾に、四層完了済みの「二つの箱の整除を箱に依存しない一つの整除へまとめる」を「記述まで」とする古い重複行が残っていたため削除した。次は本流「分母 2 の有理点と最終判定」の記述。
- 2026-08-26 18:04（本流）: `NecSuf/DivisibilityTransfersAlongAdditiveDecomposition.lean`（`NecSuf.dvd_of_additive_decomposition`）と具体導出 `integer_point_numerator_divides_twice_zero_multiplicity_minus_one_viaNecSuf` を追加し、整数の有理点を定数項へ帰着する主張の四層を閉じた。具体版から有限和・冪・自然数の減法を落とすと、可換環で対象が定数項と有理点の倍数へ分かれる加法的な分解だけが残る。自然数版へは多重度ゼロの値と分配多項式の値の非負性だけで戻る。構築成功、未証明依存検査 544 件、`npm run check` 175 ブロック・386 参照すべて解決、linkage 89 件。次は「二つの箱から得た整除を一つへまとめて箱の大きさに依存しない形へ移す」の SageMath 検証。着手前レビュー修正なし。
- 2026-08-26 17:33（本流）: `lean/Ising3DCut/LimitQuantity/IntegerPointNumeratorDividesTwiceZeroMultiplicityMinusOne.lean` を追加し、整数の有理点を定数項へ帰着する主張の Lean 具体版を閉じた。有限和の定数項分離、自然数減法に必要な `Omega 0 >= 1`、二倍した差、整除の差を人手証明と同じ三段で並べた。対象ファイルの構築成功、未証明依存検査 544 件。次は同主張の Lean 必要十分版。着手前レビュー修正なし。
- 2026-08-26 16:36（並行）: `incoming_lattice_edges_mem_and_ne` を追加し、周期境界の平面正方格子で各頂点へ入る横辺と縦辺を一つ前の巡回座標から構成して、接続辺集合への所属と相異性を閉じた。次は出入りの四辺の相異性と、接続辺集合がこの四辺だけであることを示す。
- 2026-08-26 16:33（本流）: `claim_integer_point_numerator_divides_twice_zero_multiplicity_minus_one` の SageMath 層を追加した。定数項分離と二倍した差を `ZZ` 上の多項式恒等式で、整除の差による保存を整数の厳密標本で確認し、三検査とも PASS、linkage 89 件。次は同主張の Lean 具体版。着手前レビュー修正なし。
- 2026-08-26 15:36（並行）: `outgoing_lattice_edges_mem_and_ne` を追加し、周期境界の平面正方格子で各頂点から出る横辺と縦辺が接続辺集合に属し、相異なることを閉じた。接続辺数四の一般形を出る二辺と入る二辺の構成へ割った先頭で、次は入る二辺の構成と四辺の相異性を示す。
- 2026-08-26 16:02（本流）: 「結んだ関係から正の有理点一以外を排除できるか判定する」を整数の場合と分母 2 の場合へ割り、先頭を記述した（`claim_integer_point_numerator_divides_twice_zero_multiplicity_minus_one`）。整数の有理点では関係が定数項 $\Omega_{L_0}(0)$ だけの整除へ帰着し、候補が有限個に絞られる。次は同主張の SageMath 検証。着手前レビュー修正なし。
- 2026-08-26 15:34（本流）: `NecSuf.relation_of_relation_preserving_map_and_target_equality` と具体導出 `numerator_divides_twice_threshold_box_value_minus_one_viaNecSuf` を追加し、「底の従属性を整除へ代入して分子と箱の値を結ぶ」の四層を完了した。自然数・冪・有限等比和・整除を落とすと、関係を保つ写像、関係の推移、最後の対象の等号だけが残る。次は「結んだ関係から正の有理点一以外を排除できるか判定する」の記述。着手前レビュー修正なし。
- 2026-08-26 14:34（並行）: `card_univ_latticeEdge` を追加し、周期境界の平面正方格子の辺総数が一辺 $n$ に対して $2n^2$ であることを Lean で閉じた。端点写像から接続辺を定義しているのと同じ辺型を数えており、対象ファイルの単独再構築に成功。次は接続辺数四の一般形を示して偶部分グラフ条件へ接続する。
- 2026-08-26 14:33（本流）: `claim_numerator_divides_twice_threshold_box_value_minus_one` の SageMath 層を追加した。有限等比和の四段、整除の二倍への移送と推移、閾値の箱の値の代入を `ZZ` の三検査へ分けて全 PASS、linkage 88 件。次は同主張の Lean 具体版。着手前レビュー修正なし。
- 2026-08-26 13:06（並行）: `lean/Ising3DCut/Prediction/PeriodicPlanarSquareLattice.lean` を追加し、周期境界の平面正方格子を具体的に構成した。頂点 `Fin n × Fin n`、辺は起点と方向（横・縦）の組、端点写像は巡回和で一つ進めるだけ。接続辺は端点写像から定義するので格子の形を担うのは端点写像だけである。端点条件 `latticeIncident` と、$n=3$・$n=4$ での接続辺数四（`decide`）を示した。これで直前の `forall_even_card_selected_of_card_incidentEdges_eq_four` の仮定を満たす具体例が出た。`lake build` 成功、未証明依存検査 538 件。次は辺の総数と偶部分グラフ条件の接続。
- 2026-08-26 13:03（本流）: `lean/Ising3DCut/LimitQuantity/PowerFormBaseDeterminedByThresholdBox.lean` を追加し、`claim_power_form_base_is_determined_by_threshold_box` の Lean 具体版を閉じた。人手証明と同じ順で、準備段（閾値の箱の点の数 $n=L_0^3\ge1$）、第二段（正の有理数の狭義大小は非零自然数乗で保たれる。因子を一つずつ置き換える帰納）、着地（三分律で両側の不等号を第一段の等式との矛盾で排除）を置いた。扱うのは $\mathbb Q$ の等式と大小だけで、正の実数乗根も箱の大きさの極限も現れない。`lake build` 成功、未証明依存検査 538 件、`npm run check` 173 ブロック・452 参照すべて解決、linkage 87 件。次は同主張の Lean 必要十分版。着手前レビュー修正なし。
- 2026-08-26 12:36（本流）: `claim_power_form_base_is_determined_by_threshold_box` の SageMath 層を追加した。閾値での冪等式、正の有理数の有限乗の狭義順序保存、同じ冪からの底の一意性を三ファイルに分けて全 PASS、linkage 87 件。次は Lean 具体版。
- 2026-08-26 12:34（レビュー）: 直前に記述済みの `claim_power_form_base_is_determined_by_threshold_box` が台帳で `todo` のままだった不整合を「記述まで」へ訂正した。本文は正の有理数の有限乗の単射性だけで閉じ、許されない脱出は無い。次は SageMath 検証。
- 2026-08-26 12:07（本流）: 次の本流をゴール文書の自由エネルギー密度の最小性の行から引き直し、三つへ割って台帳へ書いた（底の一意性 → 整除への代入 → 排除の判定）。その先頭 `claim_power_form_base_is_determined_by_threshold_box` を記述した。点数乗表示 $Z_L(q)=c^{\#V_L}$ の底 $c$ は自由変数ではなく、閾値の箱 $L_0$ の値と点の数だけで一意に決まる。証明は三分律と、正の有理数の積の狭義単調性を $n=\#V_{L_0}\ge1$ 回用いるだけである。`npm run check` はブロック 173 件・参照 381 件すべて解決。次はこの記述の SageMath 検証。着手前レビュー修正なし。
- 2026-08-26 11:35（本流）: `NecSuf.every_target_has_related_admissible_witness` と具体導出 `box_free_divisibility_excludes_no_rational_point_viaNecSuf` を追加し、箱に依存しない整除による否定判定の四層を閉じた。整数・正値性・整除を落とすと、対象ごとに許容される証人を構成し、所定の関係を満たすことだけが残る。次の本流はゴール文書の「最初の三手」「極限側で問う言明」「否定判定」から引き直す。着手前レビュー修正なし。
- 2026-08-26 10:34（本流）: `lean/Ising3DCut/LimitQuantity/BoxFreeDivisibilityExcludesNoRationalPoint.lean` を追加し、`claim_box_free_divisibility_excludes_no_rational_point` の Lean 具体版を閉じた。分子 $a>0$ に対し底を $c=a+1$ に取り、人手証明と同じ三段（$1\le c$、$2(c-1)=2a$、$a\mid 2a$）で $a\mid 2(c-1)$ を示す存在主張である。**否定判定**なので、証人の構成そのものが結論であり、これ以上絞れるのは分子と底の組だけである。`lake build` 成功、未証明依存検査 536 件、`npm run check` はブロック 172 件・参照 379 件すべて解決、linkage 86 件。次は同主張の Lean 必要十分版。着手前レビュー修正なし。
- 2026-08-26 09:34（並行）: `forall_even_card_selected_of_card_incidentEdges_eq_four` を追加し、どの頂点にも接続辺がちょうど四本ある場合（平面正方格子の次数）へ具体化した。四が偶数であることだけを使い、完全マッチングから復号した辺集合がどの頂点でも偶数本の選択辺を持つ、すなわち偶部分グラフであることを結論した。直前の同値そのものは次数の値に依らず、四という具体値はここでだけ効く。`lake build` 成功、未証明依存検査 535 件。次は平面格子の頂点集合と接続辺を具体的に構成して、この仮定を満たすことを示す。
- 2026-08-26 09:32（本流）: `claim_box_free_divisibility_excludes_no_rational_point` と `remark_box_free_divisibility_judgement` を追加し、箱の大きさに依存しない整除 $a\mid 2(c-1)$ が正の有理点をどこまで絞るかを判定した。**否定判定**: 底に $c=a+1$ を取ればどの分子 $a$ でも整除が成り立つので、この整除だけからは $a=1$ は従わず、正の有理点は一つも排除されない。絞られているのは有理点そのものではなく、有理点と冪の底の組であり、次に要るのは $Z_L(q)=c^{\#V_L}$ を $a,b$ の言葉で書く関係である。`npm run check` はブロック 172 件・参照 379 件すべて解決、linkage 85 件。次はこの記述の SageMath 検証。着手前レビュー修正なし。
- 2026-08-26 09:06（並行）: `forall_even_card_selected_iff_forall_even_card_incidentEdges` を追加し、完全マッチングから復号した選択辺集合の各頂点での次数の偶数性を、元の接続辺数の偶数性へ移した。これで覆われずに残る端子の偶奇が偶部分グラフの条件そのものへ接続した。次は平面格子の各頂点で元の接続辺数が偶数であることを具体化する。
- 2026-08-26 09:04（本流）: `NecSuf.relation_of_relation_and_three_equalities` と具体導出 `numerator_divides_twice_base_minus_one_viaNecSuf` を追加し、二つの箱から得た整除を箱に依存しない一つへまとめる主張の四層を閉じた。整数・冪・最大公約数を落とすと、対象関係が中間値について成り立つことと三段の等式による移送だけが残る。`lake build` 成功、未証明依存検査 533 件。次は箱に依存しない整除から正の有理点一以外を排除できるかの判定を記述する。着手前レビュー修正なし。
- 2026-08-26 08:35（本流）: `lean/Ising3DCut/LimitQuantity/NumeratorDividesTwiceBaseMinusOne.lean` を追加し、二つの箱から得た整除を一つへまとめて箱の大きさに依存しない形へ移す主張の Lean 具体版を閉じた（準備の二段 `gcd_two_mul_eq_two_mul_gcd`・`int_gcd_two_mul_eq_two_mul_gcd` と本体 `numerator_divides_twice_base_minus_one`）。`lake build` 成功、未証明依存検査 530 件。次は同主張の Lean 必要十分版。着手前レビュー修正なし。
- 2026-08-26 08:03（本流）: `sagemath/check/numerator-divides-twice-base-minus-one/` に三検査を追加し、最大公約数への二倍の移送、隣接指数の互いに素性による箱サイズの消去、最終整除を `ZZ` 上で全 PASS させた。次は同主張の Lean 具体版。着手前レビュー修正なし。
- 2026-08-26 07:34（並行）: 覆われずに残る端子数の偶数性を各頂点へ降ろす同値を Lean で閉じた（`forall_even_card_uncovered_iff_forall_even_card_incidentEdges`）。未証明依存検査 530 件。次は偶部分グラフの条件そのものへ接続する。
- 2026-08-26 07:36: 本流「二つの箱から得た整除を一つへまとめて箱の大きさに依存しない形へ移す」を記述した（`claim_numerator_divides_twice_base_minus_one`）。隣接する二つの箱の頂点数の差が互いに素であることと、冪から一を引いた数の最大公約数が指数の最大公約数で決まることを合わせ、箱の大きさを含まない整除 $a\mid 2(c-1)$ を得た。次はこの記述の SageMath 検証。
- 2026-08-26 07:03（本流）: `NecSuf.combine_eq_normalize_of_reaches_self` と具体導出 `powerMinusOne_gcd_equals_power_of_exponent_gcd_viaNecSuf` を追加し、到達形を指数の最大公約数乗から一を引いた数へ書き換える主張の四層を閉じた。具体的な冪差・整数・最大公約数を落とすと、二項演算が同じ値へ到達する等式と同じ二値を一値へ正規化する等式だけが残る。`lake build` 成功、未証明依存検査 529 件。次は二つの箱から得た整除を一つへまとめる記述。着手前レビュー修正なし。
- 2026-08-26 06:35（並行）: `even_sum_card_uncovered_of_perfectMatching` を追加した。直前に閉じた「覆われずに残る端子の総数は選ばれた元辺数の二倍」から、その総数が偶数であることを直接の帰結として得た。偶部分グラフの条件は各頂点での次数の偶奇で述べられるので、まず総和側の偶奇を固定した。対象ビルド成功、未証明依存検査 527 件。次は各頂点での偶奇へ降ろす。
- 2026-08-26 06:34（本流）: `lean/Ising3DCut/LimitQuantity/PowerMinusOneGcdEqualsPowerOfExponentGcd.lean` を追加し、`claim_power_minus_one_gcd_equals_power_of_exponent_gcd` の Lean 具体版を閉じた。準備の `gcd_self_eq_of_dvd_antisymm`（$\gcd(a,a)=a$ を両方向の整除で）、それを非負整数へ移す `int_gcd_self_eq_of_nonneg`、主張の三段を並べた `powerMinusOne_gcd_equals_power_of_exponent_gcd` を人手証明と同じ順に置いた。`lake build` 成功、未証明依存検査 526 件、`npm run check` 169 ブロック・376 参照すべて解決、linkage 84 件。次は同主張の Lean 必要十分版。着手前レビュー修正なし。
- 2026-08-26 06:05（並行）: `sum_card_uncovered_eq_two_mul_card_selectedOriginalEdges_of_perfectMatching` を追加した。完全マッチングから得た頂点ごとの覆われない端子数の和を、選ばれた端点・元辺の組の個数へ移し、各元辺の二つの端点による個数二の定理と合成して、選ばれた元辺数の二倍へ接続した。対象ビルド成功、未証明依存検査 526 件。次はこの偶数性を偶部分グラフの条件へ接続する。
- 2026-08-26 06:02（本流）: `claim_power_minus_one_gcd_equals_power_of_exponent_gcd` の SageMath 層を閉じた。`sagemath/check/power-minus-one-gcd-equals-power-of-exponent-gcd/` で、同じ自然数どうしの最大公約数の相互整除、指数の最大公約数で定まる到達形の書き換え、最終等式までの三段を `ZZ` の三検査へ分けて全 PASS。次は同主張の Lean 具体版。着手前レビュー修正なし。
- 2026-08-26 05:31（本流）: `claim_power_minus_one_gcd_equals_power_of_exponent_gcd` を記述した。$\gcd(a,a)=a$ を両方向の整除で準備し、直前に閉じた到達形 $\gcd(c^m-1,c^n-1)=\gcd(c^{g}-1,c^{g}-1)$ へ $a=c^{g}-1$ を当てて、$\gcd(c^m-1,c^n-1)=c^{\gcd(m,n)}-1$ を得た。`npm run check` はブロック 169 件・参照 376 件すべて解決、PDF 58 ページ。次はこの記述の SageMath 検証。着手前レビュー修正なし。
- 2026-08-26 04:36（本流）: `lean/Ising3DCut/LimitQuantity/PowerMinusOneGcdReachesExponentGcd.lean` を追加し、`claim_power_minus_one_gcd_reaches_exponent_gcd` の Lean 具体版を閉じた。準備の `gcd_sub_left_eq`（$\gcd(m-n,n)=\gcd(m,n)$ を両方向の整除で）、指数の和についての強い帰納法の本体（`m<n`・`m=n`・`m>n` の三場合）、束ねた `powerMinusOne_gcd_reaches_exponent_gcd` を人手証明と同じ順に並べた。`lake build` 成功、未証明依存検査 521 件、`npm run check` 168 ブロック・376 参照すべて解決、linkage 83 件。次は同主張の Lean 必要十分版。着手前レビュー修正なし。
- 2026-08-26 04:05（並行）: `card_selectedEndpointIncidences_eq_two_mul_card_selectedOriginalEdges` を追加し、元辺への第二成分写像で全体を繊維分解して、各繊維の個数二から選ばれた端点・辺の組の総数が選ばれた元辺数の二倍であることを閉じた。対象ビルド成功。次はこの個数等式を覆われずに残る端子の総数へ接続する。
- 2026-08-26 04:02（本流）: `claim_power_minus_one_gcd_reaches_exponent_gcd` の SageMath 層を閉じた。`sagemath/check/power-minus-one-gcd-reaches-exponent-gcd/` で指数差による最大公約数の不変性、強い帰納法の三場合の減少、指数の最大公約数への到達等式を `ZZ` の三検査へ分け、全 PASS。linkage 83 件、`npm run check` は 168 ブロック・376 参照すべて解決。次は同主張の Lean 具体版。着手前レビュー修正なし。
- 2026-08-26 03:33（本流）: `claim_power_minus_one_gcd_reaches_exponent_gcd` を記述した。指数の和についての強い帰納法で一段の還元を繰り返し、二つの指数が等しい場合・大きいほうから引く場合・小さいほうから引く場合の三つに分けて $\gcd(c^m-1,c^n-1)=\gcd(c^{\gcd(m,n)}-1,c^{\gcd(m,n)}-1)$ へ落とした。準備で差による指数の最大公約数の不変性を両方向の整除から示した。`npm run check` はブロック 168 件・参照 376 件すべて解決、linkage 82 件、PDF 58 ページ。次は同主張の SageMath 検証。着手前レビュー修正なし。
- 2026-08-26 03:04（本流）: 「指数の差への一段の還元」の Lean 必要十分版 `NecSuf.PowerMinusOneGcdExponentDifferenceStep` と具体導出を追加し、四層を閉じた。冪と指数を落とすと整数の分解、最大公約数の相互整除、自然数の反対称性だけが残る。次は還元を強い帰納法で繰り返して指数の最大公約数へ到達する主張の記述。
- 2026-08-26 02:35（本流）: `lean/Ising3DCut/LimitQuantity/PowerMinusOneGcdExponentDifferenceStep.lean` を追加し、`claim_power_minus_one_gcd_exponent_difference_step`（$\gcd(c^m-1,c^n-1)=\gcd(c^{m-n}-1,c^n-1)$）の Lean 具体版を六定理で閉じた。冪は $\mathbb Z$、最大公約数は `Int.gcd` の自然数値で扱い、相互整除から `Nat.dvd_antisymm` で等号へ着地した。`lake build` 成功、未証明依存検査 514 件。次は必要十分版。
- 2026-08-26 02:04（本流）: 「指数の差への一段の還元」の SageMath 層を追加し、冪差の分解、二つの最大公約数の相互整除、最大公約数の等式を `ZZ` の三検査で全 PASS させた。底一では最大公約数が零になるため、相互整除は剰余でなく `ZZ.divides` で検査した。次は同主張の Lean 具体版。
- 2026-08-26 02:02（レビュー修正）: 最大公約数の一段還元で、三つの冪差と二つの最大公約数を「四つの数」と数えていた数量表現を「ここに現れる三つの冪差」へ直した。数学的な等式と整除の両方向には不備なし。次は同主張の SageMath 層。

- 2026-08-26 00:36（並行）: `fiber_eq_endpoint_pair_of_selectedEndpointIncidences` と `card_fiber_eq_two_of_selectedEndpointIncidences` を追加し、元辺への射影の繊維が両端点との二組に一致すること、両端点が相異なるとき繊維の個数が二であることを閉じた。`lake build` 成功、未証明依存検査 501 件。次は繊維の個数二を全体の数え上げへ渡す。
- 2026-08-26 00:34（本流）: `lean/Ising3DCut/LimitQuantity/PowerMinusOneDividesMultipleExponent.lean` を追加し、`claim_power_minus_one_divides_multiple_exponent`（$c^n-1\mid c^{nk}-1$）の Lean 具体版を閉じた。基底の証人、指数の加法と同じ底の冪の積、帰納段の分解、証人の更新、帰納法による証人の存在、整除への着地の六定理を人手証明と同じ順に並べた。`lake build` 成功、未証明依存検査 499 件、`npm run check` 166 ブロック・376 参照すべて解決、linkage 81 件。次は同主張の Lean 必要十分版。着手前レビュー修正なし。
- 2026-08-26 00:06（並行）: `endpoint_pair_subset_fiber_of_selectedEndpointIncidences` を追加し、選ばれた元辺の両端点との組がどちらも元辺への射影の繊維に属する逆向きの包含を閉じた。対象ビルド成功、未証明依存検査 493 件。次は前 tick の包含と束ねて繊維の等号と個数二を示す。
- 2026-08-26 00:03（本流）: `claim_power_minus_one_divides_multiple_exponent` の SageMath 層を閉じた。`sagemath/check/power-minus-one-divides-multiple-exponent/` で帰納法の基底、指数法則、帰納段の分解、整除証人の更新を `ZZ` 上で一行ずつ確認し、四検査すべて PASS、linkage 81 件。次は同主張の Lean 具体版。着手前レビュー修正なし。
- 2026-08-25 23:36（並行）: `Ising3DCut.Prediction.fiber_subset_endpoint_pair_of_selectedEndpointIncidences` を追加し、元辺への射影の繊維が二つの端点との組の二元集合に含まれることを示した。`lake build` 成功、未証明依存検査 492 件。次は逆向きの包含。
- 2026-08-25 23:33（本流）: 「分子は底から 1 を引いた数の 2 倍を割る」を三つへ割り、その先頭 `claim_power_minus_one_divides_multiple_exponent`（$c^n-1\mid c^{nk}-1$）を記述した。自然数 $k$ の帰納法一本で、$c^{n(k+1)}-1=c^{nk}(c^n-1)+(c^{nk}-1)$ の分解を一行ずつ書いた。`npm run check` はブロック 166 件・参照 376 件すべて解決。次はこの記述の SageMath 検証。
- 2026-08-25 23:04（本流）: `NecSuf.coprime_of_add_one_and_prime_divisors_of_offset_dvd_base` と具体導出 `adjacent_vertex_number_gaps_are_coprime_viaNecSuf` を追加し、隣接する頂点数差の互いに素性の四層を閉じた。三次元の頂点数を落とすと、前項が一と部分の和、後項が前項と差の和、その差の素因子が部分を割るという仮定だけが残る。次の本流は「分子は底から 1 を引いた数の 2 倍を割る」の記述。
- 2026-08-25 22:36（並行）: `first_eq_endpoint_of_mem_selectedEndpointIncidences` を追加し、選ばれた端点・辺の組の第一成分が元辺の二端点のいずれかであることを示した。`lake build` 成功、未証明依存検査 489 件。次は繊維がちょうど二元であることを示す。
- 2026-08-25 22:34（本流）: `lean/Ising3DCut/LimitQuantity/AdjacentVertexNumberGapsAreCoprime.lean` を追加し、`claim_adjacent_vertex_number_gaps_are_coprime` の Lean 具体版を閉じた。準備の二等式（$g_L=3L(L+1)+1$、$g_{L+1}=g_L+6(L+1)$）、共通素因子が $2\cdot3\cdot(L+1)$ を割ることからの三分岐、どの分岐でも $p\mid3L(L+1)$ を得て $p\mid1$ へ落ちる着地を、人手証明と同じ順の六定理として並べた。`lake build` 成功、未証明依存検査 488 件、`npm run check` 165 ブロック・376 参照すべて解決、linkage 80 件。次は同主張の Lean 必要十分版。直前の SageMath 層のレビュー修正なし。
- 2026-08-25 22:04（本流）: `sagemath/check/adjacent-vertex-number-gaps-are-coprime/` を追加し、準備の因数分解、隣接差を $6(L+1)$ へ移す四段、最大公約数の結論を `ZZ` の六ファイルで一行ずつ検査して全 PASS。次は `claim_adjacent_vertex_number_gaps_are_coprime` の Lean 具体版。直前本流と並行のレビュー修正なし。まとめ締切に入ったため並行ストリームは見送った。
- 2026-08-25 21:35（並行）: `mem_selectedEndpointIncidences_iff` を追加し、選ばれた端点・辺の組の所属条件を頂点の所属と選択接続辺の所属へ分解した。前 tick の `card_selectedEndpointIncidences` が sorry 検査へ未登録だったので登録した。`lake build` 成功、未証明依存検査 482 件。次は元辺への射影の各繊維が両端点の二元であることを示す。
- 2026-08-25 21:33（本流）: 「頂点数の差だけの点数乗の整除から正の有理点一以外を排除できるか判定する」を三つへ割り、先頭 `claim_adjacent_vertex_number_gaps_are_coprime`（$\gcd(g_L,g_{L+1})=1$、$g_L=3L^2+3L+1$）を記述した。$g_L=3L(L+1)+1$ と $g_{L+1}-g_L=6(L+1)$ を準備し、共通素因子が $L+1$・$2$・$3$ のいずれを割る場合も $g_L-3L(L+1)=1$ へ落ちる三場合分けで閉じた。`npm run check` 165 ブロック・376 参照すべて解決、linkage 79 件。次はこの記述の SageMath 検証。直前の Lean 必要十分版のレビュー修正なし。
- 2026-08-25 21:04（本流）: 「分子は頂点数の差だけの点数乗から 1 を引いた数の 2 倍を割る」の必要十分版 `NecSuf.equality_and_dvd_twice_gap_power_minus_one` と具体導出 `rational_power_point_numerator_divides_twice_gap_power_minus_one_viaNecSuf` を追加し、四層を閉じた。有限箱・有理数・三次元の頂点数を落とすと、指数の加法分解、共通剰余、保存する対象の等号だけが残る。`lake build` 成功、未証明依存検査 480 件。次は「頂点数の差だけの点数乗の整除から正の有理点一以外を排除できるか判定する」の記述。直前の具体版のレビュー修正なし。
- 2026-08-25 20:33（本流）: 「分子は頂点数の差だけの点数乗から 1 を引いた数の 2 倍を割る」の Lean 具体版 `rational_power_point_numerator_divides_twice_gap_power_minus_one` を追加し、三層目を閉じた。準備段（隣接二箱の頂点数の差が $3L^2+3L+1$ で大きい側が小さい側と差の和）、第二段（二つの合同式と指数法則から $2c^{g}\equiv2$）、第三段（合同式の定義から $a\mid2(c^{g}-1)$）を人手証明の三段と 1 対 1 に並べた。`lake build` 成功、未証明依存検査 477 件、`npm run check` 164 ブロック・376 参照すべて解決、linkage 79 件、PDF 56 ページ。次は同主張の Lean 必要十分版。直前の記述と SageMath のレビュー修正なし。まとめ締切のため並行ストリームは見送った。
- 2026-08-25 19:34（本流）: 「分子が割る差の形から正の有理点一以外を排除できるか判定する」を二つへ割り、先頭 `claim_rational_power_point_numerator_divides_twice_gap_power_minus_one` を記述した（$a\mid2(c^{3L^2+3L+1}-1)$）。破れ数ゼロの配位数 2 と既約分母 1 を法 $a$ の合同式へ入れ、隣接二箱の合同を一続きの変形で結んで底の共通部分を落とした。次はこの記述の SageMath 検証。レビューでは既約分母が 2 を割る証明の整除記号の連鎖を等式の連鎖へ正した。
- 2026-08-25 19:07（並行）: `sum_card_uncovered_eq_sum_card_selected_of_perfectMatching` を追加し、頂点ごとの「覆われずに残る端子数と選ばれた接続辺数の一致」を有限和で束ねた。次は選ばれた各元辺が両端点で二回数えられることを示し、選ばれた元辺総数の二倍へ接続する。
- 2026-08-25 19:05（本流）: 「分子は隣接する二つの箱の底の点数乗の差を割る」の必要十分版 `NecSuf.equality_and_dvd_difference_of_common_residue` と具体導出 `rational_power_point_numerator_divides_base_power_difference_viaNecSuf` を追加し、四層を閉じた。有限箱・有理数・点数乗を落とすと、対象の等号と二つの整数が同じ剰余へ合同であることだけが残る。次は「分子が割る差の形から正の有理点一以外を排除できるか判定する」の記述。直前の具体版のレビュー修正なし。
- 2026-08-25 18:03（本流）: `sagemath/check/rational-power-point-numerator-divides-base-power-difference/` を追加し、底の既約分母が一になる段、隣接二箱の底の点数乗がともに二へ合同なら差が零へ合同になる段、零合同と整除の同値を `ZZ`・`QQ` の三ファイルで一行ずつ検査して全 PASS。次は同主張の Lean 具体版。直前の記述のレビュー修正なし。
- 2026-08-25 17:37（並行）: `card_uncovered_eq_card_selected_of_perfectMatching` を追加し、全単射から覆われずに残る端子数と選ばれた接続辺数の等式を得た。`lake build` 通過、未証明依存検査 469 件。次は各頂点の個数等式を束ねる。
- 2026-08-25 17:34（本流）: 次のセクションを二つへ割り、先頭「点数乗表示が成り立つ正の有理点の分子は隣接する二つの箱の底の点数乗の差を割る」の記述を追加した（`claim_rational_power_point_numerator_divides_base_power_difference`）。底が正の自然数であることから既約分数表示の分母を 1 とし、法 $a$ の合同式で隣接する二つの箱がともに $c^{\#V_L}\equiv2$ を満たすことから $a\mid c^{\#V_{L+1}}-c^{\#V_L}$ を得た。`npm run check` 163 ブロック・373 参照すべて解決、linkage 77 件。次は同主張の SageMath 検証。直前の並行成果のレビュー修正なし。
- 2026-08-25 17:07（並行）: `secondProjection_bijOn_uncovered_selected_of_perfectMatching` を追加し、覆われずに残る端子と選ばれた接続辺の所属対応の両方向から、第二成分写像の全単射を完全マッチングの仮定だけで導いた。従来の補助定理の強すぎる全称同値は、定義域上の順方向と構成した逆像についての逆方向へ修正した。次は全単射から両有限集合の濃度等式を得る。
- 2026-08-25 17:03（本流）: 「点数乗表示が成り立つ正の有理点の既約分母は 2 を割る」の必要十分版 `NecSuf.denominator_one_and_outer_denominator_divides_constant` と具体導出 `rational_power_point_denominator_divides_two_viaNecSuf` を追加し、四層を閉じた。有限箱・有理数・素数 2 を落とすと、分母の素因子が指定した自然数に限られること、その自然数自身は分母を割らないこと、外側の分母が定数と分母冪の積を割ることだけが残る。次は「既約分母が 2 を割る形から正の有理点一以外を排除できるか判定する」の記述。直前の具体版のレビュー修正なし。

- 2026-08-25 16:38（本流）: 「点数乗表示が成り立つ正の有理点の既約分母は 2 を割る」の Lean 具体版を閉じた（`lean/Ising3DCut/LimitQuantity/RationalPowerPointDenominatorDividesTwo.lean`）。奇素数が底の既約分母を割らないことから既約分母を割る素数が 2 に限られる段、そこへ 2 の非整除を合わせて既約分母が 1 になる段、法 $b$ の整除 $b\mid2v^{\#V_L}$ へ $v=1$ を入れて $b\mid2$ を得る段を、人手証明の四段と 1 対 1 に並べた（`rational_power_point_denominator_divides_two`）。先行する三主張（奇素数の排除・指数 1 の不可能性・指数 2 以上の不可能性）は本文と同じく結論を仮定として受け取る形にした。`lake build` 通過、未証明依存検査 463 件、`npm run check` 162 ブロック・372 参照すべて解決、linkage 77 件。次は同主張の Lean 必要十分版。レビュー修正なし。まとめ締切のため並行ストリームは見送った。
- 2026-08-25 16:03（本流）: 「点数乗表示が成り立つ正の有理点の既約分母は 2 を割る」の SageMath 層を閉じた。`rational-power-point-denominator-divides-two/check.sage` で、奇素数の排除から底の既約分母が 2 の冪になる段、2 の非整除から底の既約分母が 1 になる段、法 $b$ の整除と $\Omega_L(0)=2$ から $b\mid2$ を得る段、既約な正の有理点が正の自然数または奇数の半分に限られる段を `ZZ`・`QQ` だけで検査し全 PASS。linkage は 77 件。次は同主張の Lean 具体版。レビュー修正なし。
- 2026-08-25 15:35（本流）: 「絞った底の形から $q\ne1$ を排除できるか判定する」を二つへ割り、先頭の記述層を書いた（`claim_rational_power_point_denominator_divides_two`）。第一段で奇素数 $p\mid v$ を `claim_rational_power_base_den_no_prime_missing_zero_mult` と $\Omega_L(0)=2$ で排除し、第二段で $2\mid v$ を $2\mid b$ 経由の $e_b\ge1$ と指数 1・指数 2 以上の二つの不可能性で排除して $v=1$ を確定させ、第四段で `claim_rational_power_base_congruences` の $b\mid\Omega_L(0)v^{\#V_L}$ へ $v=1$ を入れて $b\mid2$ を得た。**これで点数乗表示が成り立つ正の有理点は $q=a$ か $q=a/2$ に限られ、底は正の自然数である。** 検証は `npm run check` と `build:pdf`（55 ページ）を通過。次は同主張の SageMath 検証。レビュー修正なし。
- 2026-08-25 14:33（本流）: 「既約分母の 2 の指数が 1 の場合を判定する」の Lean 具体版を閉じた（`lean/Ising3DCut/LimitQuantity/RationalPowerBaseDenTwoExponentOneImpossible.lean`）。$2\mid b$ から $m+2\le\#E_M$ の項が $b^2$ で割れて $4$ で割れる補題、回文性から従う $\Omega_M(\#E_M-1)=0$ で一つ下の項が消え端係数 2 と底の奇数性から有限和が法 4 で 2 になる補題の二本を新設し、法 4 で 2 なら素数 2 の指数が 1 になる段と $M^2\mid1$ の矛盾の段は指数 2 以上の場合の具体版の同じ補題をそのまま引いた（人手証明でも同じ段を指しているため）。`lake build` 通過、未証明依存検査 463 件。次は同主張の Lean 必要十分版。レビュー修正なし。
- 2026-08-25 14:03（本流）: 「既約分母の 2 の指数が 1 の場合を判定する」の SageMath 層を追加した（`sagemath/check/rational-power-base-den-two-exponent-one-impossible/`）。最高次の二つ下までの項の法 4 での消滅、回文性と破れ数一の多重度零による一つ下の項の消滅、分配多項式値の素数 2 の指数が 1 になる段、箱の一辺の二乗による整除矛盾を四ファイルへ分け、`ZZ` の有限標本ですべて PASS させた。次は同主張の Lean 具体版。レビュー修正なし。
- 2026-08-25 13:37（並行）: `selected_incident_edge_terminal_uncovered` を追加し、所属対応の逆向き（`v` で選ばれた接続辺 `e` に対し端子 `⟨v,e⟩` が覆われずに残ること）を完全マッチングの一意性から導いた。外部辺と内部辺が一致しえないことは、一致すると外部辺の両端子の第一成分がともに `v` になり一元集合となって内部辺の二元性に反することで示した。接続関係と端点写像を結ぶ仮定 `hIncident` だけを新たに置いている。未証明依存検査 463 件 OK。次は順向きと逆向きを束ねて `secondProjection_bijOn_uncovered_selected` の仮定を外す。
- 2026-08-25 13:35（本流）: 「既約分母の 2 の指数が 1 の場合を判定する」の記述層を閉じた（`claim_rational_power_base_den_two_exponent_one_impossible`）。$e_b=1$ なら $m\le\#E_M-2$ の項は $b^2$ で割れて $4$ で割れるので、法 $4$ に残るのは最高次とその一つ下の二項だけである。回文性で $\Omega_M(\#E_M-1)=\Omega_M(1)$ とし、直前 tick で閉じた `claim_one_breakage_multiplicity_is_zero` により $\Omega_M(1)=0$ なので一つ下の項が消え、$P_M\equiv2\pmod4$ から $v_2(P_M)=1$ が再び決まり、釣り合い式で $1+M^3e_v=3M^2(M-1)$ となって $M^2\mid1$ の矛盾に落ちる。**これで $2\mid v$ が排除され、奇素数が $v$ を割らないことと合わせて $v=1$（底は正の整数）が確定した。** 次は同主張の SageMath 層。レビュー修正なし。
- 2026-08-25 13:03（本流）: 「破れ数がちょうど 1 の配位は存在しない」の必要十分版 `NecSuf.NullModel.broken_count_ne_one_of_alternate_chain` と具体導出 `brokenCount_ne_one_from_necSuf` を追加し、四層を閉じた。三次元箱・座標・正方形・スピン値を落とすと、有限辺系、端点写像、頂点上の値、各辺の両端を別の三辺で結ぶ条件だけが残る。次は「既約分母の 2 の指数が 1 の場合を判定する」。並行は覆われずに残る端子と選ばれた接続辺の所属対応の逆向きから。
- 2026-08-25 12:33（本流）: `SquareAroundEdge.lean` に `squareUp_edges_ne` / `squareDown_edges_ne` / `squareUp_connects_chain` / `squareDown_connects_chain` / `alternate_three_edges_exists` / `brokenCount_ne_one` を追加し、一辺が二以上の箱では破れ数がちょうど 1 の配位が存在しないことを Lean 具体版で閉じた（`claim_one_breakage_multiplicity_is_zero` の三層目）。未証明依存検査へ登録済み（460 件）。次は必要十分版。締切のため並行は次の tick。
- 2026-08-25 12:04（本流）: `SquareAroundEdge.lean` に負側の正方形の三辺 `squareDownEdgeToStart`・`squareDownEdgeFromLower`・`squareDownEdgeOpposite` を追加し、一本目が元の始点へ戻り、二本目から三本目へつながり、三本目が元の終点へ着くことを証明した。次は正側・負側を場合分けして `brokenCount_ne_one_of_alternate_three_edges` へ渡し、`claim_one_breakage_multiplicity_is_zero` の Lean 具体版を閉じる。直前成果のレビュー修正なし。
- 2026-08-25 11:36（並行）: `uncovered_terminal_second_mem_selected` を追加し、覆われずに残る端子の第二成分が選ばれた接続辺であることを完全マッチングから導いた（所属対応の片方向）。未証明依存検査へ登録済み（455 件）。次は逆向きを示して `secondProjection_bijOn_uncovered_selected` の仮定を外す。
- 2026-08-25 11:34: 本流の正方形構成へ入り、元の辺の正側に置く三辺 `squareUpEdgeFromStart` / `squareUpEdgeShifted` / `squareUpEdgeOpposite` を定義し、正方形が閉じること `squareUp_closes` と三辺の始点が前の辺の第二端点へ一致することを示した。未証明依存検査へ登録済み（454 件）。次は負側の場合を同じ形で用意し、連鎖の仮定 `brokenCount_ne_one_of_alternate_three_edges` へ渡す。並行の所属対応は次の tick で先に着手する。
- 2026-08-25 11:05: 本流では正方形を正側・負側のどちらへ置くかの座標場合分け `shiftUp_available_or_shiftDown_available` を閉じた。並行では、覆われずに残る端子と選ばれた接続辺の所属対応から第二成分写像の全単射を得る `secondProjection_bijOn_uncovered_selected` を追加し、未証明依存検査へ登録した。次は並行の所属対応を完全マッチングから導き、本流の四隅と三辺を構成する。
- 2026-08-25 10:05（本流）: 「破れ数がちょうど 1 の配位は存在しない」の Lean 具体版を二段へ割り、先頭 `brokenCount_ne_one_of_alternate_three_edges` を追加した。各辺の両端を別の三辺で結べるという仮定だけから、破れ辺集合が一元集合なら三辺の端点等号が唯一の破れ辺の両端も一致させる矛盾を形式化した。次は三次元箱で同じ正方形の残り三辺を構成し、多重度零まで閉じる。
- 2026-08-25 10:02（レビュー修正）: 「破れ数がちょうど 1 の配位は存在しない」で、唯一の破れ辺を含む `f_1,f_2,f_3` を三本の非破れ辺と読める記述を直し、場合ごとに矛盾へ使う三本を明記した。次は Lean 具体版。
- 2026-08-25 09:33（本流）: 「既約分母の 2 の指数が 1 の場合を判定する」を割り、先頭の「破れ数がちょうど 1 の配位は存在しない」を記述と SageMath まで進めた（`claim_one_breakage_multiplicity_is_zero`、`sagemath/check/one-breakage-multiplicity-is-zero/`）。破れ辺がただ一本の $(a,i)$ だと仮定し、方向 $j\ne i$ を取って同じ正方形の面をなす三本の辺 $(c,j),(c,i),(c+\varepsilon_i,j)$（$c=a$ または $c=a-\varepsilon_j$）が破れていないことから$\sigma(a)=\sigma(a+\varepsilon_i)$ を導き矛盾させ、$L\ge2$ で $\Omega_L(1)=0$ を得た。これが要るのは $e_b=1$ のとき法 4 で $P_M\equiv2a^{\#E_M}+\Omega_M(1)a^{\#E_M-1}b$ となり、$\Omega_M(1)=0$ で初めて $v_2(P_M)=1$ が再び決まるためである。SageMath は辺の構成を一辺 2,3,4、配位の列挙を一辺 2 で全 PASS。次は同主張の Lean 具体版。レビュー修正なし。
- 2026-08-25 09:04（本流）: 「既約分母の 2 の指数が 2 以上なら矛盾する」の Lean 必要十分版 `NecSuf.false_of_nontrivial_common_divisor_of_one_plus` と具体導出を追加し、四層を閉じた。必要十分版には「1 より大きい共通因子が補正項と総量を割る一方で差が 1」の不両立だけが残った（lake build 通過、sorry 検査 451 件）。次の本流は「既約分母の 2 の指数が 1 の場合を判定する」。レビュ修正なし。
- 2026-08-25 08:36（本流）: 「既約分母の 2 の指数が 2 以上なら矛盾する」の Lean 具体版を閉じた（`lean/Ising3DCut/LimitQuantity/RationalPowerBaseDenTwoExponentAtLeastTwoImpossible.lean`）。最高次未満の各項が 4 で割れる補題、端係数 2 と底の奇数性から有限和が法 4 で 2 になる補題、法 4 で 2 なら素数 2 の指数が 1 になる補題、点数と辺数を入れた等式から $M^2\mid1$ を出す補題の四本を人手証明の三段と同順に置き、既存の釣り合い式の定理へ接続した（lake build 通過、sorry 検査 444→449 件）。次は同主張の Lean 必要十分版。レビュー修正なし。
- 2026-08-25 08:03（本流）: 「既約分母の 2 の指数が 2 以上なら矛盾する」の SageMath 層を追加した。法 4 の項別簡約、分配多項式値の 2 進指数 1、点数・辺数の代入、箱の一辺の長さの二乗による整除矛盾を五ファイルへ分け、`ZZ` の有限標本ですべて PASS させた。次は同主張の Lean 具体版。レビュー修正なし。
- 2026-08-25 08:06（並行）: `selectedIncidentEdgesAt` と所属条件 `mem_selectedIncidentEdgesAt_iff` を追加し、覆われずに残る端子と個数を突き合わせる相手を有限集合として分離した（対象ビルド通過、sorry 検査 444 件）。次は端子の第二成分を取る写像で全単射を示す。
- 2026-08-25 07:33（本流）: 「既約分母の 2 の指数が 2 以上なら矛盾する」を記述した（`claim_rational_power_base_den_two_exponent_at_least_two_impossible`）。$e_b\ge2$ すなわち $4\mid b$ のもとで $P_M$ の $m<\#E_M$ の項がすべて $4$ で割れるため $P_M\equiv2a^{\#E_M}\equiv2\pmod4$ となり $v_2(P_M)=1$ が確定する。釣り合い式へ入れると $1+M^3e_v=3M^2(M-1)e_b$ で、右辺と左辺第二項がともに $M^2$ で割れるので $M^2\mid1$ となり $M\ge2$ に矛盾する。**予定していた隣接する二つの箱の比較は不要で、一つの箱だけで閉じた。** 次は同主張の SageMath 層。レビュー修正なし。
- 2026-08-25 07:05（本流）: 「素数 2 についての指数の釣り合い式」の Lean 必要十分版 `NecSuf.balance_of_zero_contribution` と具体導出を追加して四層を閉じた。必要十分版には可換加法モノイド上の四項等式と一項の零性だけが残る。次は「既約分母の 2 の指数が 2 以上なら矛盾する」。レビュー修正なし。
- 2026-08-25 06:35（並行）: `mem_matchingUncoveredTerminalsAt_iff` を追加し、覆われずに残る端子であることを「`v` の接続辺から作られ、選ばれたどの内部辺にも属さない」という辺の言葉へ言い換えた（sorry 検査 441 件）。次はこの言い換えで残った端子と復号した辺集合の次数を突き合わせる。
- 2026-08-25 06:33（本流）: 「素数 2 についての指数の釣り合い式を書き下す」の Lean 具体版を閉じた（`lean/Ising3DCut/LimitQuantity/RationalPowerBaseDenTwoExponentBalance.lean`）。互いに素性から分子が奇数であることを取り出す段、整数等式の両辺で素数 2 の指数を取って積と冪の指数の法則で展開する段、両者を束ねて釣り合い式と二つの指数の正値性を出す段の三本を人手証明と同順に置いた。奇素数版と違い $v_2(P_M)$ は消さずに左辺へ残してある。`lake build` 通過、sorry 検査 437→440 件。次は同主張の Lean 必要十分版、そのあと「分母の 2 の指数が 2 以上なら矛盾する」。レビュー修正なし。
- 2026-08-25 06:04（本流）: 「素数 2 についての指数の釣り合い式を書き下す」の SageMath 層を追加した。本文の式変形を七ファイルへ分け、既約性から得る整除・非整除、冪と積の素因子指数、整数等式による移送、$2\nmid u$ による項の消去を `ZZ` の有限標本ですべて PASS させた。次は同主張の Lean 具体版。レビュー修正なし。
- 2026-08-25 05:36（本流）: 「底の既約分母が 2 の冪であることから分母が一かを判定する」を三つへ割り、割った先頭「素数 2 についての指数の釣り合い式を書き下す」を記述した（`claim_rational_power_base_den_two_exponent_balance`）。奇素数では「破れ数ゼロの配位数が $p$ で割れない」から $p\nmid P_M$ が出て指数の項が消えたが、配位数はちょうど 2 なので $p=2$ ではこの一歩が使えない。そこで $v_2(P_M)$ を残したまま $v_2(P_M)+\#V_M e_v=\#E_M e_b$ を得る形へ組み直した。次は同主張の SageMath 層、そのあと「分母の 2 の指数が 2 以上なら矛盾する」。レビュー修正なし（`npm run check` 再実行）。
- 2026-08-25 05:04（レビュー修正）: 直前 tick の必要十分版 `card_eq_of_injective_of_le` と具体導出 `multiplicity_zero_eq_two_from_necSuf` が未証明依存検査へ未登録だったため登録した（433→435 件）。Lean の対象ビルドと未証明依存検査は通過した。
- 2026-08-25 04:33（本流）: 「破れ数ゼロの配位数が 2 であることを確定する」の Lean 必要十分版を二つへ割り、数える段を閉じた（`NecSuf.NullModel.card_eq_of_injective_of_le` と導出 `multiplicity_zero_eq_two_from_necSuf`）。残ったのは単射・写された先の元の個数・下界の三つだけで、箱・辺・端点写像・破れ数・スピン値・次元 3 はすべて落ちた（lake build 通過、sorry 検査 432→433 件）。次は定値性（座標和の強い帰納法）の必要十分版。レビュー修正なし。
- 2026-08-25 04:04（本流）: 「破れ数ゼロの配位数が 2 であることを確定する」の Lean 具体版を閉じた（`multiplicity_zero_eq_two`）。破れ数ゼロの水準集合から原点のスピン値への単射で上界二を出し、既存の全上・全下の二配位による下界と合わせた。次は同主張の Lean 必要十分版。レビュー修正なし。
- 2026-08-25 03:34（本流）: 「破れ数ゼロの配位数が 2 であることを確定する」の Lean 具体版を二つへ割り、先頭を閉じた（`lean/Ising3DCut/NullModel/ZeroBreakageConstant.lean`）。破れ数 $0$ と「全ての辺で両端点の値が等しい」の同値、および座標和の強い帰納法で「破れ数 $0$ の配位は全点で原点と同じ値」を示した（lake build 通過、sorry 検査 430→432 件）。第二段は既存の `brokenCount_constConfig` が担う。残りは第三段（多重度がちょうど二）と必要十分版。レビューで本文の同主張が単位ベクトルと配位の値に同じ記号 $\varepsilon$ を使っていたのを見つけ、配位の値を $t$ へ改めた。
- 2026-08-25 03:03（本流）: 「破れ数ゼロの配位数が 2 であることを確定する」の SageMath 層を閉じた（`sagemath/check/zero-breakage-multiplicity-is-two/`）。箱一・箱二の全配位を有限列挙し、破れ数ゼロなら全点が原点と同じ値であること、二つの定値配位が破れ数ゼロであること、多重度が二で奇素数に割られないことを本文と同順に全 PASS。次は同主張の Lean 具体版。
- 2026-08-25 02:35（並行）: `matchingUncoveredTerminalsAt` と個数・偶奇の二定理を追加した。覆われずに残る端子数は接続辺数から内部辺数の二倍を引いたものなので、接続辺数と同じ偶奇を持つ（sorry 検査 430 件）。次は残った端子と外部辺の対応を通して復号した辺集合の次数へ接続する。
- 2026-08-25 02:35（本流）: 「破れ数ゼロの配位数が 2 であることを確定する」の記述層を書いた（`claim_zero_breakage_multiplicity_is_two`）。破れ数 $0$ は破れ辺の集合が空であることと同値なので、端点写像に沿って値が変わらない。成分の和 $a_1+a_2+a_3$ についての帰納法で定値写像に限られることを示し、逆向きと合わせてすべての $L\ge1$ で $\Omega_L(0)=2$ を得た。これで直前の主張の仮定 $p\nmid\Omega_M(0)$ は「$p$ が奇素数」へ置き換えられる。次はこの行の SageMath 層。
- 2026-08-25 02:04（本流）: 「底の既約分母は破れ数ゼロの配位数を割らない素数では割り切れない」の必要十分版 `NecSuf.false_of_positive_adjacent_balance` と導出 `rational_power_base_den_no_prime_missing_zero_multiplicity_viaNecSuf` を追加し、四層を閉じた。具体版から有限箱・分配多項式・合同式・素因子分解を落とすと、隣接二箱の釣り合い式と共通指数の正値性だけが残る。次は破れ数ゼロの配位が二つだけであることの記述層。
- 2026-08-25 01:36（並行）: `matchingCoveredTerminalsAt` と `card_matchingCoveredTerminalsAt` を追加し、選ばれた内部辺が覆う端子数＝内部辺数の二倍を Lean で閉じた（sorry 検査 426 件）。次は復号した辺集合の次数との突き合わせ。
- 2026-08-25 01:35（本流）: 「底の既約分母は破れ数ゼロの配位数を割らない素数では割り切れない」の Lean 具体版を閉じた（`lean/Ising3DCut/LimitQuantity/RationalPowerBaseDenNoPrimeMissingZeroMultiplicity.lean`）。法 $b$ の合同式からの $p\nmid P_M$、整数等式の素因子指数、点数・辺数の約分、隣接二箱からの $e_b=0$ を人手証明と同順で形式化した（lake build 通過、sorry 検査 419→425 件）。次は同主張の Lean 必要十分版。
- 2026-08-25 01:05（並行）: 完全マッチングに選ばれた内部辺を元頂点ごとの有限集合へ分ける `matchingInternalEdgesAt` と所属条件 `mem_matchingInternalEdgesAt_iff` を Lean 具体版へ追加した。次は選択された内部辺が覆う端子数を内部辺数の二倍として数える。
- 2026-08-25 01:03（本流）: 「底の既約分母は破れ数ゼロの配位数を割らない素数では割り切れない」の SageMath 層を閉じた（`sagemath/check/rational-power-base-den-no-prime-missing-zero-mult/`）。既約な分数からの非整除、法 $b$ の合同式からの $p\nmid P_M$、整数等式の素因子指数比較、隣接二箱の指数等式の不両立を `ZZ` の有限標本で本文と同順に全 PASS。次は同主張の Lean 具体版。
- 2026-08-25 00:41（本流）: 「法 $b$ の整除から底の既約分母を特定する」を三つへ割り、その先頭「底の既約分母は破れ数ゼロの配位数を割らない素数では割り切れない」の記述層を書いた（`claim_rational_power_base_den_no_prime_missing_zero_mult`）。$p\mid v$ を仮定すると $p\mid b$・$p\nmid a$・$p\nmid u$ が出て、回文性から $p\nmid P_M$ となり、整数等式の両辺の $p$ 指数が $Me_v=3(M-1)e_b$ を与える。隣接する二つの箱でこれを比べると $3e_b=0$ となり矛盾する。$\Omega_L(0)=2$ はまだ本文未確定なので、その値を使わず「$p\nmid\Omega_M(0)$」を仮定に置いた（割った二番目でこの仮定を奇素数へ置き換える）。次はこの行の SageMath 検証。
- 2026-08-25 00:06（並行）: `terminals_of_internalEdge_have_same_vertex` を追加し、同じ city 内の二端子の所属一致を terminal graph 全体の内部辺へ持ち上げた。次は完全マッチングの内部辺を元頂点ごとの組として数え、復号した辺集合の各頂点での偶数性へ接続する。
- 2026-08-25 00:04（本流）: 「点数乗表示の底の既約分母は有理点の分子と互いに素である」の Lean 必要十分版 `NecSuf.coprime_of_common_prime_dvd_left` と導出 `rational_power_base_denominator_coprime_to_numerator_viaNecSuf` を追加し、四層を閉じた。合同式・法の移送・冪を落とすと、共通素因子を底の分子へ移す条件と底の既約性だけが残る。`lake build` と sorry 検査 418 件を通過。次は法 $b$ の整除から底の既約分母を特定する記述。
- 2026-08-24 23:34（並行・レビュー修正）: 端子分解の Lean 定理 6 本が sorry 検査の登録配列から漏れていたので登録した（410→416 件）。形式化した定理は必ず登録し、検査件数が定理の増加に追随しているかを毎 tick 見る。
- 2026-08-24 23:33（本流）: 「点数乗表示の底の既約分母は有理点の分子と互いに素である」の Lean 具体版を閉じた（`lean/Ising3DCut/LimitQuantity/RationalPowerBaseDenominatorCoprime.lean`）。共通素因子 $p$ の法へ合同式を移して $p \mid u^N$ を出す補題と、素数性・既約性の矛盾で互いに素性を結論する定理の二本。`lake build` と sorry 検査 410 件を通過。次は同主張の Lean 必要十分版。
- 2026-08-24 23:05（並行）: `terminals_of_internalEdgeAt_have_same_vertex` を追加し、同じ city の内部辺に属する二端子が同じ元頂点に属することを、先に示した端子所属補題の二回適用で束ねた。次はこの二端子組と完全マッチングの一意性から、復号した辺集合の各頂点での偶数性へ接続する。
- 2026-08-24 23:02（本流）: 「点数乗表示の底の既約分母は有理点の分子と互いに素である」の SageMath 層を閉じた（`sagemath/check/rational-power-base-den-coprime-to-numerator/`）。共通素因子、合同式の法の移送、素数が冪を割れば底を割る段、既約性との矛盾を `ZZ` の有限標本で本文と同順に全 PASS。次は Lean 具体版。
- 2026-08-24 22:06（並行）: `terminal_of_mem_internalEdgeAt` を追加し、city の内部辺に属する各端子が同じ元頂点に属することを、内部辺の部分集合条件と端子の所属条件から導いた。次は完全マッチングで覆う内部辺を頂点ごとに組にして、復号した辺集合の次数の偶数性へ接続する。
- 2026-08-24 22:04（本流）: 「破れ数ゼロの項から底に合同式の制約を出す」の Lean 必要十分版 `NecSuf.base_congruences_of_integer_equation` と導出 `rational_power_base_congruences_viaNecSuf` を追加し、四層を閉じた。具体版から有限箱・分配多項式・有理数を落とすと、整数の等式、両端項の二合同式、法と約す因子の互いに素性だけが残る。次は合同式で有理点一以外を排除できるかの判定。
- 2026-08-24 21:36（本流）: 「破れ数ゼロの項から底に合同式の制約を出す」の Lean 具体版を閉じた（`lean/Ising3DCut/LimitQuantity/RationalPowerBaseCongruences.lean`）。有理数表示から整数の等式、法 $a$ の合同式、回文性を使った法 $b$ の整除、二つを束ねる定理の四本。`lake build` と sorry 検査 404 件を通過。次は同主張の Lean 必要十分版。レビューで前 tick の Lean 定理 6 本が sorry 検査の登録配列から漏れていたのを見つけ登録した。
- 2026-08-24 21:02（本流）: 「破れ数ゼロの項から底に合同式の制約を出す」の SageMath 層を閉じた（`sagemath/check/rational-power-base-congruences/`）。箱二の全配位による回文性、両端係数、法 $a$・法 $b$ の合同式、点数乗表示からの二つの結論を `ZZ` だけで全 PASS。次は Lean 具体版。
- 2026-08-24 20:33（本流）: 「破れ数ゼロの項から底に合同式の制約を出す」の記述層を書いた（`claim_rational_power_base_congruences`）。法 $a$ では破れ数ゼロの項だけが残り、法 $b$ では回文性から最高次の項だけが残る。$\Omega_L(0)=2$ は本文未確定（$\ge2$ のみ）なので値を特定せずに書いた。次は同主張の SageMath 層。
- 2026-08-24 20:04: 本流「点数乗表示の底の分母の素因子」の Lean 必要十分版と導出を追加し、四層を閉じた。必要十分版には、非負な整数値が正の自然数倍で表されるなら底も非負になることだけが残った。次は破れ数ゼロの項と回文性から底の合同式を取り出す記述。
- 2026-08-24 19:03: 本流「点数乗表示の底の分母の素因子」の Lean 具体版を二段へ割り、先頭の整数商の付値非負補題を閉じた。次は点数乗表示から底の付値非負と既約分母の非整除を束ねる。
- 2026-08-24 18:37: 本流「末尾で定数になる正の有理点を分類する」を三つへ割った（底の素因子の所在 → 破れ数ゼロと回文性からの合同式 → 有理点一以外を排除できるかの判定）。先頭の記述層と SageMath 検証まで通した。次は Lean 具体版。
- 2026-08-24 18:04（本流）: 必要十分版からの導出 `eventually_cross_power_identity_iff_rational_power_form_viaNecSuf` を追加し、「冪等式の末尾成立を正の有理数の点数乗という形へ言い換える」の四層を閉じた。正の有理数全体の可換群へ有限箱値を移し、正値性・隣接立方数の互いに素性・非零自然数乗の単射性だけで具体版を回収した。次は点数乗表示が有理点一以外で末尾的に成立しうるかの判定。
- 2026-08-24 17:35（本流）: 必要十分版 `NecSuf.crossPowerIdentity_iff_powerForm` を追加した。具体版の素因数分解・有理数・立方数はいずれも不要であり、可換群・閾値以後の隣接指数の互いに素性・非零指数の冪写像の単射性の三つだけで同値性が閉じる（底は互いに素性から得た整数 `u, v` で `a L0 ^ u * a (L0+1) ^ v` と置く）。`lake build` と sorry 検査 393 件を通過。次は必要十分版から具体版を導く接続で、正の有理数の乗法群への移送が要る。
- 2026-08-24 17:06（本流）: `eventually_cross_power_identity_iff_rational_power_form` を追加し、閾値の箱で取り出した正の有理数の底を交差冪等式と正の有理数上の冪の単射性で帰納的に全箱へ接続して、Lean 具体版の同値性を閉じた。次は Lean 必要十分版。
- 2026-08-24 16:33（本流）: 素指数がすべて正整数 `n` で割り切れる正の有理数は、ある正の有理数の `n` 乗として書けること `rat_pow_of_prime_exponents_dvd` を追加した。非零素指数の有限素数集合を素数だけに絞り、素指数を `n` で割った指数の有限積を底に取り、冪の付値が付値の整数倍であることと素指数データによる一意性で等式を閉じた。`lake build` と sorry 検査（392 件）を通過。次はこの底の取り出しを閾値以後の素指数商の不変性へ接続し、具体版の同値性を束ねる。
- 2026-08-24 16:06（本流）: 非零素指数が有限素数集合に収まる正の有理数は、その素指数を指数とする有限積に一致する `primePowerProduct_padicValRat_eq_self` を追加した。次はこの復元を閾値以後の素指数商の不変性へ接続し、具体版の同値性を閉じる。
- 2026-08-24 16:04（レビュー修正）: 直前 tick の `padicValRat_primePowerProduct` は、単独再構築で存在しない有限積用補題と未 import の補題への依存が判明した。有限集合帰納法で各因子へ付値の積法則を適用する証明へ直し、明示 import を追加して再構築を通した。
- 2026-08-24 16:00: launchd の `kickstart -k` 後、専用 worktree の Git 管理領域に保持者のいない空の `index.lock` が残り、15:18 以降の tick が 3 回連続で exit 128 になった。`launchd-error.log` の SSH エラーは最終更新が 2026-08-22 18:30 で今回とは無関係だった。tick 本体は自身の排他ロック取得後、専用 worktree の `index.lock` に保持プロセスが無い場合だけ回収し、保持者がいる場合はエラーで止まるようにした。
- 2026-08-24 15:04（本流）: 復元の有限積について、任意の素数での素指数が有限集合内なら指定値、外なら零になる `padicValRat_primePowerProduct` を追加した。有限積へ付値の積法則を適用し、相異なる素数の寄与が零になることを一項ずつ示した。次は既存の正の有理数の素指数による一意性と束ねて具体版の同値性を閉じる。
- 2026-08-24 14:37（本流）: 同主張の Lean 具体版後半のうち、有限積による復元の第一段を追加した。非零な素指数を持つ素数の有限集合と整数値の指数から `primePowerProduct`（整数冪の有限積）を定義し、その正値性 `primePowerProduct_pos` を証明。`lake build` と sorry 検査（391 件）を通過。次はこの積の素指数が指定した指数に一致することを示して同値性を閉じる。
- 2026-08-24 14:03（本流）: 「冪等式の末尾成立を正の有理数の点数乗という形へ言い換える」の Lean 具体版後半を二段へ割り、先頭の有限性 `finite_prime_support_of_rat` を追加した。正の有理数の非零素指数が分子と分母の素因数分解の台の和集合に収まることを形式化し、`lake build` と sorry 検査（390 件）を通過。次はこの有限集合上の有限積から正の有理数を構成し、具体版の同値性を閉じる。
- 2026-08-24 13:07（並行）: 完全マッチングから外部辺として選ばれなかった元の辺を偶部分グラフ候補として復号する `encodedEvenSubgraph` と、その所属条件 `mem_encodedEvenSubgraph_iff` を Lean 具体版へ追加した。次はこの候補が各頂点で偶数本の辺を持つことを示す。
- 2026-08-24 13:04: 本流「冪等式の末尾成立を正の有理数の点数乗という形へ言い換える」の SageMath 層を閉じた（`sagemath/check/power-identity-iff-rational-power-form/` の三検査を全 PASS）。点数乗表示から交差冪等式を得る段、素指数の交差等式から点数による可除性と商の不変性を得る段、有限個の非零素指数から正の有理数を復元する段を `ZZ`・`QQ` だけで検査した。次は同主張の Lean 具体版。
- 2026-08-24 12:33: 本流の判定セクションを二つに割り、先頭「冪等式の末尾成立を正の有理数の点数乗という形へ言い換える」の記述層を閉じた（`claim_power_identity_iff_rational_power_form`）。素数ごとの指数について $(L+1)^3e_L=L^3e_{L+1}$ を立て、$\gcd(L^3,(L+1)^3)=1$ から $L^3\mid e_L$ を得る 1 論法。次は同主張の SageMath 層。
- 2026-08-24 11:35（本流）: 「末尾定数性は隣接する箱の分配多項式の冪等式に同値である」の Lean 具体版 `eventually_constant_iff_power_identity` を追加した。`lake build` と sorry 検査（383 件）を通過。次は同主張の Lean 必要十分版。
- 2026-08-24 11:07（並行）: Pfaffian 予言の Lean 具体版で、未選択の元の辺の両端子がそれぞれ内部辺で覆われることを `unselected_terminals_are_covered_by_internal_edges` へ束ねた。`lake build` と sorry 検査（382 件）を通過。次は二端子の内部辺配置から polygon–dimer 対応へ進む。
- 2026-08-24 11:03: 本流「末尾定数性を分配多項式の冪等式へ言い換える」の SageMath 層を閉じた（`sagemath/check/eventually-constant-iff-power-identity/` の三検査を全 PASS）。共通値から交差べき等式へ移る段、交差べき等式から隣接有限箱量の等号を得る段、帰納的に末尾定数性へ束ねる段を `QQ`・`ZZ` だけで検査した。次は Lean 具体版。
- 2026-08-24 10:06: 定数列より広く、それでも許されない完備性を持ち込まない次の経路として、有限箱量の末尾定数性を定義した。次はこの性質を持つ正の有理点を分類する。並行の Pfaffian 予言は、未選択辺の両端子が内部辺で覆われる個別定理まで Lean 具体化済み。
- 2026-08-24 09:36: 本流「有限箱の量が定数列になる正の有理点を分類する」の Lean 必要十分版と導出を追加し、四層を閉じた（`lean/Ising3DCut/NecSuf/ConstantFiniteBoxSequenceOnlyAtOne.lean`、`lean/Ising3DCut/LimitQuantity/ConstantFiniteBoxSequenceOnlyAtOneFromNecSuf.lean`）。必要十分版 `eq_of_constant_of_strictMonoOn` の仮定は、定数族であること・添字 $i$ での値・添字 $j$ での値の $n$ 乗が比較写像の値であること・比較写像が集合上で狭義単調であることの四つだけで、モノイドと前順序があれば足りる。具体版はこれに箱 1・箱 2 の有限箱計算と箱 2 の分配多項式の狭義単調性を与えるだけになった。sorry 検査の登録は 381 件。次の本流は台帳の次の未完了セクション。
- 2026-08-24 09:08: 本流「有限箱の量が定数列になる正の有理点を分類する」の Lean 具体版を追加した（`LimitQuantity/ConstantFiniteBoxSequenceOnlyAtOne.lean`）。箱 2 の分配多項式の有限和を項別比較し、非負係数と最高次係数の正値から正の有理数上の狭義単調性を証明したうえで、定数列の箱 1・箱 2 の値から $Z_2(q)=Z_2(1)$、したがって $q=1$ を導いた。次は Lean 必要十分版。
- 2026-08-24 09:02: 着手前レビューで、直前の SageMath 層の狭義単調性が有限標本の比較に留まり本文の全称命題を検証していない不備を修正した。$Z_2(R)-Z_2(Q)=(R-Q)D(Q,R)$ の二変数恒等式、$D$ の非負係数・非零性、正次数項ごとの有限和表示を `ZZ[Q,R]` で検査するため、任意の正の有理数 $q<r$ の狭義単調性に対応する。
- 2026-08-24 08:32: 本流「有限箱の量が定数列になる正の有理点を分類する」の SageMath 層を閉じた（`sagemath/check/constant-finite-box-sequence-only-at-one/` の 3 本を全 PASS）。箱 1 は点 1 個・辺 0 本なので任意の正の有理点で $a_1(q)=2$、定数列の仮定から $Z_2(q)=2^8=Z_2(1)$、$Z_2$ の係数の非負性と 12 次係数の正値から正の有理数上で狭義単調増加、$Z_2(q)-Z_2(1)$ の正の有理解は $q=1$ のみ。乗根は箱 1 では現れず箱 2 では 8 乗した形で扱うため、検証は `ZZ`・`QQ`・`ZZ[X]` だけで閉じている。次は同主張の Lean 具体版。
- 2026-08-24 07:33: 本流「有理点 2 では有限箱の量の列は定数列でない」の Lean 必要十分版と導出を追加し、四層を閉じた（`lean/Ising3DCut/NecSuf/FiniteBoxSequenceAtTwoNotConstant.lean`、`lean/Ising3DCut/LimitQuantity/FiniteBoxSequenceAtTwoNotConstantFromNecSuf.lean`）。具体版が使っているのは「一方の添字で値が $2$ に定まる」「他方の添字の値の $8$ 乗が $Z_2(2)$ に等しい」「その二つが両立しない」の三つだけなので、必要十分版はモノイド上の一般の添字族についての命題 `not_constant_of_pow_ne` にまで落ちた（実数・順序・乗根・分配多項式はすべて不要）。sorry 検査の登録は 374 件。次の本流は台帳の次の未完了セクション。
- 2026-08-24 07:03: 本流「有理点 2 では有限箱の量の列は定数列でない」の Lean 具体版を閉じた。$L=2$ の辺数 $12$、係数の非負性、最高次係数が $2$ 以上であることから $Z_2(2)\ge2\cdot2^{12}>2^8$ を導き、既存の $Z_1(2)=2$ と束ねて非定数性から有限箱計算の仮定をすべて除いた。次は Lean 必要十分版。
- 2026-08-24 06:36: 本流「有理点 2 では有限箱の量の列は定数列でない」の Lean 具体版で、$L=1$ の箱に辺が無いこと（`card_edge_one`）から分配多項式が定数 $2$ になること（`partitionPolynomial_box_one`）を示し、$Z_1(2)=2$（`isingValueSeq_two_at_one`）を仮定から証明へ閉じた。非定数性の定理は $L=2$ の不等式だけを仮定する形（`rootSeq_isingValueSeq_two_not_constant_of_box_two`）へ縮んだ。新ファイルは `lean/Ising3DCut/LimitQuantity/FiniteBoxValueAtTwoForBoxOne.lean`。sorry 検査の登録は 370 件。次は係数の非負性と台の最高次係数から $Z_2(2)>2^8$ を Lean で導き、具体版を閉じる。
- 2026-08-24 06:04: 本流「有理点 2 では有限箱の量の列は定数列でない」の Lean 具体版に着手し、有限箱の値の不等式から正の実数乗根列の非定数性を導く段を形式化した。次は $Z_1(2)=2$ と $Z_2(2)>2^8$ 自体を既存の係数・台の定理から Lean で導き、具体版を閉じる。
- 2026-08-24 05:33: 本流の記述層。有理点 2 では有限箱の量の列が定数列でないことを示した（`claim_finite_box_sequence_at_two_is_not_constant`）。$a_1(2)=2$、$a_2(2)>2$。有理点 1 で極限量の存在を閉じた定数列の経路が有理点 2 に使えないことが、観察ではなく定理になった。箱の大きさの極限は使っていない。SageMath 検証も同 tick で通した（$Z_2(1)=256$、$Z_2(2)=36450$）。次は同セクションの Lean 具体版。
- 2026-08-24 05:05（並行）: Pfaffian 予言の Lean 具体版で、完全マッチングのうち外部辺として選ばれたものに対応する元の辺の集合 `selectedOriginalEdges` を定義し、その外部辺像が完全マッチングと全外部辺の共通部分に等しいことを `selectedOriginalEdges_image_externalEdge` で示した。次は選ばれなかった元の辺が内部辺で覆われる端子配置を決める。
- 2026-08-24 05:02: ゴール文書へ戻って本流を引き直し、実際の Ising 有限箱データ上の最小性は現時点では未決着として保持すると確定した。非十分性の証人条件は四層で閉じているが、実在証人に必要な二つの有理点のうち、極限量の存在を許された道具だけで閉じたのは $q=1$ だけである。第二の有理点で存在を箱の大きさの極限一回だけで閉じる定理が得られるまで、この標的から小主張を派生させない。次は並行ストリームの「完全マッチングに選ばれた外部辺と元の辺の対応」から進める。
- 2026-08-24 04:34: 本流「有理点 2 で極限量の存在が許された道具だけで閉じるか判定する」を判定し、**候補を棄却した**。本文で極限量の存在が閉じているのは有理点 1 だけで（有限箱量が定数列 2 になるため定数列の収束で済む）、有理点 2 では列が定数にならず、既知の経路（劣加法性と Fekete の補題）は極限を上限として与えるので許された脱出を超える。単調有界も Cauchy 列も同じ理由で使えない。$q=1,2$ を証人にする計画全体と、依存していた「証人の分離」の行を閉じた。本文・SageMath・Lean は増えていない（判定の記録のみ）。**次の標的は台帳のセクション表からは引けない。** `docs/discussion/3次元Isingを可算側で書く/可算コアの同定とは何か.md` から引き直す。そのとき、極限量の存在自体が定数列になる有理点でしか閉じないという今回の壁を前提に置く。
- 2026-08-24 04:04: 本流「有理点 1 では極限量が存在して 2 に等しい」の Lean 必要十分版と導出を追加し、四層を閉じた（`lean/Ising3DCut/NecSuf/LimitQuantityAtOneEqualsTwo.lean`、`lean/Ising3DCut/LimitQuantity/LimitQuantityAtOneEqualsTwoFromNecSuf.lean`）。必要十分版は任意の位相空間で最終的に一定な列がその値へ収束することだけを残し、具体版では既存の乗根列の最終的一定性から特殊化した。次は有理点 2 で極限量の存在が許された道具だけで閉じるかを判定する。
- 2026-08-24 03:36: 本流「有理点 1 では極限量が存在して 2 に等しい」の Lean 具体版を通した（`lean/Ising3DCut/LimitQuantity/LimitQuantityAtOneEqualsTwo.lean`）。実際の Ising 分配多項式の有理点 1 での値の実数列 `isingValueSeq` と点の個数の列 `siteCountSeq` を置き、人手証明の四行に対応する `isingValueSeq_one`・`rootSeq_isingValueSeq_one`・`tendsto_rootSeq_isingValueSeq_one` を書いた。正の実数の正の乗根の一意性は既存の具体版補題 `eq_posRoot_of_pow_eq` を使い、mathlib の一般論へ委ねていない。`lake build` 全通過、登録 363 件が sorry 非依存。次は同主張の Lean 必要十分版。
- 2026-08-24 03:03: 本流「有理点 1 では極限量が存在して 2 に等しい」の SageMath 層を閉じた。$Z_L(1)=2^{\#V_L}$、その正の $\#V_L$ 乗根が $2$ であること、有限箱量が定数列 $2$ になることを `ZZ`・`ZZ[X]`・`QQbar` で全 PASS。次は同主張の Lean 具体版。
- 2026-08-24 02:33: 本流の証人作りを三つに割り、先頭「有理点 1 では極限量が存在して 2 に等しい」の記述層を書いた（`claim_limit_quantity_at_one_equals_two`）。$Z_L(1)=2^{\#V_L}$ から箱ごとの量が定数列 2 になり、定数列の極限として存在と値が同時に決まる。残るのは有理点 2 の側の極限の存在で、これが上限・下限なしに閉じなければ候補を棄却して理由を残す。次は本セクションの SageMath 検証、または有理点 2 の存在の判定。
- 2026-08-24 02:03: ゴール文書の未決着点から、本流の次標的を「実際の Ising 有限箱データ上で定数粗視化が十分でない証人を作る」と定めた。候補は有理点 1 と 2。まず既存の $Z_L(1)=2^{\#V_L}$ から $\alpha(1)=2$ を閉じ、次に $q=2$ の極限の存在を許された道具だけで証明済みか確認する。存在が閉じている場合に限り、有限配位族の明示的不等式で二つの極限値を分離する。直前の外部辺対応の単射性はループ辺でも成立するためレビュー修正なし。次は $q=1,2$ の極限の存在について既存主張を検索する。
- 2026-08-24 01:36（並行）: Pfaffian 予言の Lean 具体版で、元の辺から外部辺への対応が単射であることを示した（`externalEdge_injective`）。端点の相異なりは不要。次は選ばれた外部辺と元の辺の対応。
- 2026-08-24 01:34: 本流「実際の Ising 有限箱データ上で十分な粗視化の最小性を判定する」の Lean 必要十分版を追加し、四層を閉じた（`lean/Ising3DCut/NecSuf/InsufficiencyWitnessOnRealizableFamily.lean` と `lean/Ising3DCut/LimitQuantity/InsufficiencyWitnessOnIsingRealizableFamilyFromNecSuf.lean`）。非十分性と証人の存在の同値は、分配多項式・有理数・実数・箱の大きさの順序を一切使わず、点の型・添字の型・データの写像・粗視化・極限量の等号だけで成り立つ。具体版はその特殊化であり、十分性の二つの定義は `Iff.rfl` で一致する。次はゴール文書から本流の次標的を引き直す。
- 2026-08-24 00:35（並行）: Pfaffian 予言の Lean 具体版で、完全マッチングに選ばれた相異なる二辺が端子を共有しないことを、端子を覆う辺の一意性から導いた。次は選ばれていない元の辺と外部辺の対応が単射であることを示す。
- 2026-08-24 00:32: 本流の非十分性の証人条件について SageMath 検証を追加した。極限量と粗視化の値を有限ラベルへ模型化し、模型 512 通りを全数え上げして非十分性と証人の存在の同値を確認した（非十分は 168 通り）。一つの箱でだけ衝突していても他の箱で分かれれば十分性が保たれる例も確認した。次は Lean 具体版。
- 2026-08-24 00:06（並行）: Pfaffian 予言の Lean 具体版で、terminal graph の完全マッチングを、各端子をちょうど一つの選択辺が覆う辺集合として定義した。次は選択辺どうしが端子を共有しないことを導く。
- 2026-08-24 00:05: 本流の実現可能な列の族について、粗視化が十分でないことと、極限量が異なる二つの有理点がすべての箱で同じ粗視化値を持つことの同値を記述した。一つの箱での衝突だけでは非十分性を導けない。次は SageMath 検証。
- 2026-08-24 00:03: 着手前レビューで、前 tick の定義層を一ブロック一定義に従って四ブロックへ分けた。また、一つの箱で衝突値を実現するだけでは全箱での粗視化列の一致にならないため、次の標的を「極限量が異なる二点がすべての箱で同じ粗視化値を持つことと非十分性の同値」へ訂正した。
- 2026-08-23 23:33: 本流「実際の Ising 有限箱データ上で十分な粗視化の最小性を判定する」の定義層を書いた。極限量が存在する有理点の集合、そこから生じる有限箱の列の族、実現値の集合を定義し、その族の上での十分性（すべての箱で粗視化の値が一致すれば極限量が一致する）を述べ直した。一般設定の十分性からこの族の上での十分性が従う片方向と、定数列による衝突の反例がこの族では使えないことを本文へ明記した。次は衝突が実現値の中で極限量の異なる二点の同じ箱の項として起きうるかを一つの主張へ切り分ける。
- 2026-08-23 23:05: 本流をゴール文書「同定の定義」から引き直し、任意の正の有理数列を許す一般設定での最小性と、実際の Ising 有限箱データから生じる列だけに制限した最小性を区別した。既存の四層定理は前者を閉じているが、後者では粗視化の衝突が実現可能な列に現れる保証が無いため未決着である。本文とゴール文書の過大な解釈を修正し、次の本流を実現可能な列の集合と十分性の定義、および逆向きに必要な条件の切り分けへ定めた。
- 2026-08-23 23:02: 着手前レビューで、ゴール文書「可算コアの同定とは何か」の判別式・Galois 群の現状が「未検討」のまま残っていた不整合を修正した。判別式と Galois 群はいずれも、ずらした自由族による極限一致と有限不変量の不一致を束ねた反例が四層で閉じている。次は同文書の「同定の定義」と「最初の三手」の残りから本流標的を引き直す。
- 2026-08-23 22:34: 本流の次標的をゴール文書「極限側で問う言明」の表から引き直そうとしたが、表で「未検討」の判別式は**このプロジェクトで既に四層すべて閉じている**と既存出力の確認で判明した（反例は $\mathrm{disc}(Z_3)=0$ と $\mathrm{disc}(Z_4)\neq0$、検証は `sagemath/check/discriminant-free-vs-periodic-differ/`）。ゴール文書の当該表が古い。次 tick はまず表の判別式の行を実態へ更新する提案を書き、標的は表ではなくゴール文書「同定の定義」「最初の三手」の残りから引く。着手が締切 6 分前だったため本文は未変更。レビュー（`npm run check`、139 ブロック・326 参照すべて解決、TODO 0）で修正なし、PDF 43 ページ再生成。
- 2026-08-23 22:04: 本流「各箱で有限箱データを区別する粗視化の族は極限量に対して十分である」を必要十分版から具体版へ導き直し、四層を閉じた。次 tick はゴール文書から本流の次標的を引き直す。
- 2026-08-23 21:34: 本流「各箱で有限箱データを区別する粗視化の族は極限量に対して十分である」の Lean 必要十分版を追加した（`lean/Ising3DCut/NecSuf/PointwiseCollisionFreeCoarseGrainingFamilySufficient.lean`）。粗視化の単射性を実際に現れるデータの上だけへ弱め、箱の条件をフィルタに沿った最終的な成立へ緩めた。残るのは具体版を必要十分版から導く導出。
- 2026-08-23 21:04: 本流「各箱で有限箱データを区別する粗視化の族は極限量に対して十分である」の Lean 具体版を通し、三層まで進めた。次は Lean 必要十分版。
- 2026-08-23 20:36（並行）: terminal graph の辺集合を内部辺と外部辺の和として Lean に定義し、所属条件を証明した。次は完全マッチングの条件の導入。
- 2026-08-23 20:34: 本流「各箱で有限箱データを区別する粗視化の族は極限量に対して十分である」の SageMath 検証を追加し、記述と SageMath の二層まで進めた。次は Lean 具体版。
- 2026-08-23 20:06（並行）: terminal graph の外部辺を、元の辺の二端点に属する端子の組として Lean に導入し、全外部辺への所属条件を証明した。次は内部辺と外部辺の和として全辺集合を定義する。
- 2026-08-23 20:04: 修正した本流「各箱で有限箱データを区別する粗視化の族は極限量に対して十分である」の記述を書いた。有限箱データ上の衝突なしから列の項別一致を得て、既存の健全性の橋へ渡す。逆向きは主張しない。次は SageMath 検証。
- 2026-08-23 20:02: 着手前レビューで、19:36 に予定した同値性の逆向きが実際の有理点で添字づけた族には移らないことを確認した。任意の定数列による反例は、衝突値が実際の列 $S_q(L)$ に現れることを保証しない。台帳の標的を、成立する「各箱で値の衝突を持たない粗視化の族は極限量に対して十分である」という十分方向だけへ修正した。
- 2026-08-23 19:36: 本流の次標的をゴール文書の「同定の定義」「最初の三手」から引き直し、「十分な粗視化の全体は値の衝突を持たない写像の全体に一致する」を台帳へ立てた。着手前の既存ラベル検索で二点が判明した——同値性の文言自体は既存主張 `claim_collision_free_coarse_graining_is_sufficient_on_general_families` の statement 末尾に散文として既にあること、および合成する二本が値の側の写像 π: ℚ_{>0}→S の設定で述べられているのに対し、十分性の定義は有理点ごとの族 π=(π_L) と 𝒬_α 上の α で述べられていて設定が一致しないこと。次 tick の記述は、この二つの設定を結ぶ段（有理点 q に対し A(L):=S_q(L) と置く対応）を明示したうえで、定義の語による同値性を独立ブロックとして述べることから始める。まとめ締切に当たり記述は未着手。レビュー修正なし。

- 2026-08-23 19:04: 本流「可算コアは素指数データと一対一に対応する」の Lean 必要十分版と具体版への導出を通し、四層を閉じた。次はゴール文書から本流の次標的を引き直す。
- 2026-08-23 18:03: 本流「可算コアは素指数データと一対一に対応する」の SageMath 検証を追加し、本文の六段を有限な正の有理数集合上の厳密計算で確認した。次は同セクションの Lean 具体版。
- 2026-08-23 17:32: 本流「可算コアは素指数データと一対一に対応する」の記述を書き、記述の一層まで進めた。値の衝突を持たない粗視化の像と素指数データの全体との間に、互いに打ち消し合う二つの写像を構成した。次は同セクションの SageMath 検証。
- 2026-08-23 16:37: 「十分な粗視化は素指数データを復元する（左逆写像の構成）」の Lean 具体版を通し、三層まで進めた。次は Lean 必要十分版。
- 2026-08-23 16:06（並行）: 頂点ごとの city の内部辺を terminal graph 全体へ束ね、所属条件を Lean で証明した。次は外部辺を端子集合上へ導入する。

- 2026-08-23 16:04: 「十分な粗視化は素指数データを復元する」の SageMath 検証を通し、記述と SageMath の二層まで進めた。次は Lean 具体版。

- 2026-08-23 16:02: 着手前レビューで、左逆写像の構成に一意性の証明が欠けていた不備を修正した。次は同セクションの SageMath 検証。

- 2026-08-23 15:32: 可算コアの同定を締める本流標的をゴール文書の「同定の定義」から引き直し、二つに割った先頭「十分な粗視化は素指数データを復元する（左逆写像の構成）」の記述を書いた。次は同セクションの SageMath 検証。

- 2026-08-23 15:06（自動ループ）: 本流「一般の族でも、衝突を持たない粗視化は十分である」の **Lean 必要十分版と具体版への導出**を書き、四層を閉じた。必要十分版は良い値を区別する粗視化、添字ごとの観測写像、収束、極限の一意性だけを残し、正の有理数・乗根・順序・代数構造を削った。`lake build` 8833 ジョブ成功、sorry 検査は登録 331 件通過。**次 tick はゴール文書の「最初の三手」「極限側で問う言明」「否定判定」から次の本流標的を引き直す。** レビュー修正なし。並行ストリームはまとめ締切へ向けた検証と反映を優先して見送った。

- 2026-08-23 14:34（自動ループ）: 本流「一般の族でも、衝突を持たない粗視化は十分である」の **Lean 具体版**を書いて通した（status を `Lean 具体版まで` へ）。`lean/Ising3DCut/LimitQuantity/CollisionFreeCoarseGrainingSufficientOnGeneralFamilies.lean` に、人手証明の段と 1 対 1 に対応する三つの定理を置いた——`collision_free_coarse_graining_gives_equal_root_sequences`（任意の $L$ で粗視化の値が一致する段、衝突が無いので $A(L)=B(L)$ を得る段、同じ次数 $M(L)$ の正の乗根を取って二つの乗根列が写像として等しくなる段）、`collision_free_coarse_graining_is_sufficient_on_general_families`（写像としての一致から、一方の箱サイズ極限の存在が他方の存在を与える段）、`collision_free_coarse_graining_limits_agree_on_general_families`（実数列の極限の一意性で両者が一致する段）。定数列に限った版と違い、族への仮定は各項の正値性だけである。`Ising3DCut.lean` へ import 1 件、`check-no-sorry.sh` へ新規 3 件を登録して 325 件が sorry 非依存、`lake build` 8831 ジョブ成功、`npm run check` 136 ブロック・273 参照すべて解決、linkage 58 件。本文（構造化テキスト）は変更していない。**次 tick はこのセクションの Lean 必要十分版から。** レビューでは同セクションの本文・SageMath 検証・台帳の status を突き合わせ、許されない脱出も記号の濫用も見つからなかった。並行ストリームはまとめ締切のため見送った。

- 2026-08-23 14:07（自動ループ・並行）: terminal graph の各頂点の city の内部辺を、同じ頂点に属する相異なる二端子の組 `internalEdgesAt` として定義し、その所属条件 `mem_internalEdgesAt_iff` を Lean で証明した。個別 target の build は成功。次は各頂点の内部辺を terminal graph 全体へ束ねる。

- 2026-08-23 14:04（自動ループ）: 本流「一般の族でも、衝突を持たない粗視化は十分である」の SageMath 検証を新設し、恒等写像と正の有理数の素指数データについて、定数列ではない二つの族の元の値と正の乗根列が項別に一致する有限側を `QQ`・`ZZ` の厳密計算で確認した（status は `記述と SageMath まで`、linkage 58 件）。極限の存在と収束移送は唯一許された箱の大きさの極限なので有限検査の対象外。次 tick は同セクションの Lean 具体版。

- 2026-08-23 14:02（自動ループ）: 本流「一般の族でも、衝突を持たない粗視化は十分である」の着手前レビューで、乗根列の定義・元の値の一致・もう一方の乗根列の定義を一つの等号列へまとめた一ステップ一定理違反を見つけ、三つの独立した段へ分けた。次は同セクションの SageMath 検証。

- 2026-08-23 13:34（自動ループ）: 本流の新しい標的を `docs/discussion/3次元Isingを可算側で書く/可算コアの同定とは何か.md` の「極限側で問う言明」の自由エネルギー密度の行（粗視化として十分な最小の層はどこか）から引き直し、**「値の衝突を持たない粗視化は、定数列に限らない一般の族に対しても箱サイズ極限に十分である」の記述**を書いた（status は `記述まで`）。`structured-latex/content/partition-values.ts` に `claim_collision_free_coarse_graining_is_sufficient_on_general_families` を追加。直前まで示していた十分性は族を定数列に限った形だったが、衝突が無いことは各箱で二つの正の有理数を一致させるので、任意の $A,B,M$ について $a=b$（写像として等しい）が従い、一方の箱サイズ極限が存在すれば他方も存在して一致する。極限の存在は仮定として明示した。逆向きの非十分性の反例は定数列の族で作られており、定数列は一般の族の特殊な場合なので、**族の制限を外した設定でも「十分であること」と「値の衝突を持たないこと」の同値**が得られることを本文に明記した。非可算側の操作は収束の定義の書き換えと極限の一意性だけで、積分・微分・無限和・級数・指数関数・実対数・上限・下限は使っていない。`npm run check` 136 ブロック・273 参照すべて解決、linkage 57 件、PDF 41 ページで未解決参照 0 件。SageMath と Lean は未着手。**次 tick はこのセクションの SageMath 検証から。** レビューでは、三つの切り詰めがすべて四層を満たしているのに親の行が `todo` のままだった台帳の不整合を `done` へ直した（あわせて判別式・Galois 群が極限量に効かない標的は末尾ずらしで既に閉じていることを確認し、重複した引き直しを避けた）。並行ストリームはまとめ締切のため見送った。

- 2026-08-23 13:03（自動ループ）: 本流「定数列の族に限れば、衝突を持たない粗視化は十分である」の Lean 必要十分版と具体版への導出を書き、四層を閉じた。必要十分版は良い値を区別する粗視化、二つの定数列、値を極限空間へ送る写像、位相だけを残し、正の有理数・乗根・順序・代数構造を削った。**次 tick はゴール文書の「最初の三手」「極限側で問う言明」「否定判定」から次の本流標的を引き直す。** レビュー修正なし。並行ストリームはまとめ締切へ向けた検証と反映を優先して見送った。

- 2026-08-23 12:33（自動ループ）: 本流「定数列の族に限れば、衝突を持たない粗視化は十分である」の **Lean 具体版**を書いた（status を `記述と SageMath と Lean 具体版まで` へ）。`lean/Ising3DCut/LimitQuantity/` にファイルを追加し、定理 `collision_free_coarse_graining_is_sufficient_on_constant_sequences` で人手証明の四段（添字 $1$ の一点で $\pi(u)=\pi(w)$／衝突が無いので $u=w$／$M(L)=1$ なので二つの乗根列が定数列／両方の箱サイズ極限が同じ値）を 1 対 1 に対応させた。`lake build` 8828 ジョブ成功、sorry 検査へ新規 1 件を登録して 319 件通過、`npm run check` 135 ブロック・270 参照すべて解決、linkage 57 件、PDF 41 ページ・未解決参照 0 件。**次 tick はこのセクションの Lean 必要十分版から。** レビュー修正なし。並行ストリームはまとめ締切のため見送った。
- 2026-08-23 12:03（自動ループ）: 本流「定数列の族に限れば、衝突を持たない粗視化は十分である」の **SageMath 検証**を書いて通した（status を `記述と SageMath まで` へ）。`sagemath/check/collision-free-coarse-graining-is-sufficient-on-constant-sequences/` で、恒等写像と素指数データについて衝突なしから元の値の一致が従うこと、定数列の帰属、$M(L)=1$ の乗根列、候補値との差が $0$ であることを `QQ`・`ZZ` だけで確認し、一点へ潰す写像では逆向きが破れることも確認した。linkage 57 件、`npm run check` 135 ブロック・270 参照すべて解決、PDF 41 ページ・未解決参照 0 件。**次 tick はこのセクションの Lean 具体版から。** レビュー修正なし。並行ストリームはまとめ締切のため見送った。
- 2026-08-23 11:32（自動ループ）: 本流「定数列の族に限れば、衝突を持たない粗視化は十分である」の**記述**を書いた（status を `記述まで` へ）。`structured-latex/content/partition-values.ts` に `claim_collision_free_coarse_graining_is_sufficient_on_constant_sequences` を追加。値の衝突を持たない粗視化 $\pi$（$\pi(u)=\pi(w)\Rightarrow u=w$）について、定数列の族 $A(L)=u$、$B(L)=w$、$M(L)=1$ を取り、すべての $L$ で $\pi(A(L))=\pi(B(L))$ ならば $L=1$ の一点から $\pi(u)=\pi(w)$、衝突が無いことから $u=w$、よって二つの正の実数列はどちらも定数列 $u$（$=w$）で箱サイズ極限がともに存在して一致する、という四段で示した。第二段落で、直前の逆向きの主張 `claim_colliding_coarse_graining_is_not_sufficient_for_limit_quantity` と合わせて、**定数列の族の上では「箱サイズ極限に対して十分であること」と「値の衝突を持たないこと」が同値である**という必要十分条件を明記した。非可算側の操作は収束の定義の書き換えだけで、積分・微分・無限和・級数・指数関数・実対数・上限・下限は使っていない。`npm run check` 135 ブロック・270 参照すべて解決、linkage 56 件、PDF 41 ページで未解決参照 0 件。SageMath と Lean は未着手。**次 tick はこのセクションの SageMath 検証から。** レビューは直前 tick の必要十分版の主張・参照・台帳との対応を照合し、修正は無かった。並行ストリームはまとめ締切のため見送った。 並行ストリームでは terminal graph の頂点分解に、頂点 `v` に属する端子の集合 `terminalsAt` を定義し、その所属判定 `mem_terminalsAt_iff` と、個数が `v` の接続辺の本数に等しいこと `card_terminalsAt` を Lean へ追加した（`lake build` 8827 ジョブ成功、sorry 検査へ新規 2 件を登録して 318 件通過）。次は同じ頂点に属する端子どうしを結ぶ内部辺の張り方から。
- 2026-08-23 11:05（自動ループ）: 本流「符号への潰しは値の衝突を持つ」の Lean 必要十分版と具体版への導出を書き、このセクションの四層を閉じた。抽象版 `lean/Ising3DCut/NecSuf/SignCollapseCollision.lean` の `coordinatewise_map_has_a_value_collision` は、素数・有理数・付値・符号・整数・順序を落とし、「一つの添字で潰した像が一致し、残りの添字では座標が元から一致する」ことだけを残す。導出 `lean/Ising3DCut/LimitQuantity/SignCollapseCollisionFromNecSuf.lean` は、証人 $2,4$ と既存の素指数計算を与えて具体版と同じ形を取り出す。`lake build` 8827 ジョブ成功、sorry 検査 316 件、`npm run check` 134 ブロック・269 参照すべて解決、linkage 56 件。次 tick は「定数列の族に限れば、衝突を持たない粗視化は十分である」の記述から。レビュー修正なし。並行ストリームはまとめ締切のため見送った。
- 2026-08-23 10:37（自動ループ）: 本流「符号への潰しは値の衝突を持つ」の **Lean 具体版**を書いて通した（status を `Lean 具体版まで` へ）。ファイルは `lean/Ising3DCut/LimitQuantity/SignCollapseCollision.lean`。符号を取る操作は mathlib の既製の符号関数へ委ねず、人手証明と同じ場合分け（負なら $-1$、零なら $0$、正なら $1$）で `intSign` を定義し、零の場合 `intSign_zero` と正の場合 `intSign_of_pos` を独立した補題へ分けた。そのうえで `signCollapse` を素指数データの各成分の符号への潰しとして置き、主定理 `sign_collapse_has_a_value_collision` が人手証明の四段（証人 $2=2^1$・$4=2^2$ が正の有理数であること、素数 $2$ での素指数 $1,2$ がどちらも正なので符号がともに $1$ で一致すること、$2$ 以外の素数では素指数がともに $0$ で符号もともに $0$ であること、$u\ne w$ であること）と 1 対 1 に対応する。素指数の計算は既存の `padicValRat_two_pow`・`padicValRat_ne_two_pow` をそのまま引き、新しい素因数分解の一般論は使っていない。`check-no-sorry.sh` の登録配列へ新規 3 件を追加して 314 件が sorry 非依存、`lake build` 8825 ジョブ成功、`npm run check` 134 ブロック・269 参照すべて解決、linkage 56 件。本文（構造化テキスト）は変更していない。**次 tick はこのセクションの Lean 必要十分版から。** 着手前レビューでは直前 tick の SageMath 検証の記述と本文の証人・段の対応を照合し、修正は無かった。並行ストリームは締切のため今 tick は見送った。
- 2026-08-23 10:04（自動ループ）: 本流「符号への潰しは値の衝突を持つ」の **SageMath 検証**を書いて通した（status を `記述と SageMath まで` へ）。新設した `sagemath/check/sign-collapse-has-a-value-collision/` は、本文と同じ証人 $u=2$・$w=4$ が正の有理数であること、素数 $2$ での素指数が $1$ と $2$ で異なるのに符号はともに $1$ であること、$2$ 以外の $50$ 未満の素数では素指数も符号もともに $0$ であること、検査した全成分で像が一致すること、$w-u=2>0$ より $u\ne w$ であること、潰す前の素指数データはこの証人を区別することを `QQ`・`ZZ` の厳密計算だけで確認して全 PASS。`npm run check` は 134 ブロック・312 参照すべて解決、linkage 56 件、PDF 41 ページで未解決参照 0 件。`lake build` は 8824 ジョブ成功、sorry 検査も通過。本文は変更していない。**次 tick はこのセクションの Lean 具体版から。** 着手前レビューでは直前 tick の本文・台帳・既存検証を照合し、修正なし。並行ストリームでは `Prediction/TerminalVertexDecomposition.lean` に `card_terminalVertices` を追加し、端子総数が各頂点の接続辺数の有限和に等しいことを `Finset.card_sigma` で示した。個別 target の build は成功。次は同じ頂点に属する端子間の内部辺の張り方を導入する。
- 2026-08-23 09:32（自動ループ）: 本流「符号への潰しは値の衝突を持つ」の**記述**を書いた（status を `記述まで` へ）。`structured-latex/content/partition-values.ts` に `claim_sign_collapse_has_a_value_collision` と `remark_sign_collapse_not_sufficient_is_a_specialization` を追加。素指数データを各素数での指数の符号だけへ潰す写像 $\pi_{\operatorname{sgn}}(a)=(\operatorname{sgn}(v_p(a)))_p$（終域は $\prod_p\{-1,0,1\}$）を置き、$u=2$・$w=4$ が値の衝突を与えることを、素数 $2$ での素指数が $1$ と $2$ で異なるのに符号はどちらも $1$ であること、$2$ 以外の素数では両方の素指数が $0$ で符号も $0$ で一致すること、$w-u=2>0$ より $u\ne w$ であることの三段で示した（既存の「大きさによる切り詰め」の主張と同じ骨格で、$\min$ を $\operatorname{sgn}$ に取り替えただけ）。注意では、既に四層で閉じている `claim_sign_of_prime_exponents_is_not_sufficient_for_limit_quantity` が、衝突の判定 `claim_colliding_coarse_graining_is_not_sufficient_for_limit_quantity` にこの衝突を入れるだけで従うことを明記した。`npm run check` 134 ブロック・312 参照すべて解決、linkage 55 件。SageMath と Lean は未着手。**次 tick はこのセクションの SageMath 検証から。** レビューは、セクション台帳の主標的の表で「符号への潰し」の行と「定数列の族に限れば、衝突を持たない粗視化は十分である」の行が改行を欠いて 1 行に連結していたのを分けた（表から次の未完了セクションを読み取る手順が壊れるため。**前 tick の「本流に未完了が無くなった」という現在地の記述はこの連結による誤読で、実際には未完了が 2 行残っていた**）。並行ストリームは締切のため今 tick は見送った。
- 2026-08-23 09:03（自動ループ）: 本流「大きさによる切り詰めは値の衝突を持つ」の **Lean 必要十分版**を書いて通し、このセクションの**四層が揃った**（status を `done` へ）。必要十分版は `lean/Ising3DCut/NecSuf/MagnitudeTruncationCollision.lean` の `magnitude_truncation_has_a_value_collision`。具体版が実際に使っていたのは三つだけだった——(1) 素数 $2$ での成分が $N$ と $N+1$ であることではなく**その添字で二つの座標がいずれも頭打ちの高さ以上であること**（`min_eq_right` が通るのに必要なのはこれだけ）、(2) $2$ 以外の素数で付値がともに $0$ であることではなく**残りの添字では二つの座標が一致すること**、(3) $2^N<2^{N+1}$ ではなく**二つの元が異なること**。素数・自然数・有理数・付値・零元・加法・整数はすべて削れ、値の側に残ったのは $\min$ を取るための `LinearOrder` だけである。添字の型には有限性も無限性も仮定していない（`Infinite` を要した有限素数切り詰めの側とはここが違う）。正値性は主張の飾りなので述語 `Good` として外へ出した。導出は `lean/Ising3DCut/LimitQuantity/MagnitudeTruncationCollisionFromNecSuf.lean` の `magnitude_truncation_has_a_value_collision_fromNecSuf`：**具体版の定理は呼び直さず**、既存の `padicValRat_two_pow`・`padicValRat_ne_two_pow` だけで特殊化を取り出す。`Ising3DCut.lean` へ import 2 件、`check-no-sorry.sh` へ新規 2 件を登録して 310 件が sorry 非依存。`lake build` 8824 ジョブ成功、`npm run check` 132 ブロック・265 参照すべて解決、linkage 55 件。本文（構造化テキスト）は変更していない。**これで本流のセクション表に未完了が無くなった。次 tick は `docs/discussion/3次元Isingを可算側で書く/可算コアの同定とは何か.md` の「最初の三手」「極限側で問う言明」から標的を引き直す（小主張を自作しない）。** 並行ストリームは締切のため今 tick は見送った。
- 2026-08-23 08:33（自動ループ）: 本流「大きさによる切り詰めは値の衝突を持つ」の **Lean 具体版**を書いて通した（status は `Lean 具体版まで`）。`lean/Ising3DCut/LimitQuantity/MagnitudeTruncationCollision.lean` の `magnitude_truncation_has_a_value_collision`。切り詰めの添字を人手証明の素数全体に合わせて素数の部分型で取り、$u=2^N$・$w=2^{N+1}$ の正値性、$2^N<2^{N+1}$ による相違、素数 $2$ での成分がともに $N$、それ以外の素数での成分がともに $0$ になることを、人手証明の四段と 1 対 1 に対応させて書いた。`lake build` 8822 ジョブ成功、`check-no-sorry.sh` 308 件。次は必要十分版。
- 2026-08-23 08:02（自動ループ）: 本流「大きさによる切り詰めは値の衝突を持つ」の **SageMath 検証**を書いて通した（status を `記述と SageMath まで` へ）。新設した `sagemath/check/magnitude-truncation-has-a-value-collision/` は、高さ $N$ を 1,2,3,5,8 と変えて、証人 $u=2^N$・$w=2^{N+1}$ が正の有理数であること、素数 $2$ での素指数が $N$ と $N+1$ で**異なる**こと、高さ $N$ で頭打ちにすると $\min\{N,N\}=\min\{N+1,N\}=N$ でともに $N$ になること、$2$ 以外の $50$ 未満の素数では素指数も切り詰めた成分もともに $0$ であること、検査した範囲の全素数で像が一致すること、$w-u=2^N\ge2>0$ より $u\ne w$ であること、および**対偶の側**として切り詰めない素指数データそのものではこの証人が衝突しないこと（＝衝突は切り詰めが生んだもの）を、`ZZ`/`QQ` の厳密計算だけで確認して全 PASS。無限積の成分は有限個の素数だけを標本にしているが、本文の $2$ 以外の素数の段は $p\ne2$ にしか依らないので有限標本で足りる旨を overview に明記した。`npm run check` 132 ブロック・308 参照すべて解決、linkage 55 件。本文（構造化テキスト）は変更していない。**次 tick はこのセクションの Lean 具体版から。** 並行ストリームは締切のため今 tick は見送った。
- 2026-08-23 07:32（自動ループ）: 本流「大きさによる切り詰めは値の衝突を持つ」の**記述**を書いた（status を `記述まで` へ）。`structured-latex/content/partition-values.ts` に `claim_magnitude_truncation_has_a_value_collision` と `remark_magnitude_truncation_not_sufficient_is_a_specialization` を追加。素指数データを高さ $N$ で頭打ちにする写像 $\pi_N(a)=(\min\{v_p(a),N\})_{p}$ を置き、$u=2^N$ と $w=2^{N+1}$ が衝突を与えることを、素数 $2$ での成分がともに $N$（$\min\{N+1,N\}=N$）、$2$ 以外の素数での成分がともに $0$、そして $w-u=2^N\ge2>0$ より $u\ne w$、の三段で示した。注意では、大きさによる切り詰めの非十分性が衝突の判定 `claim_colliding_coarse_graining_is_not_sufficient_for_limit_quantity` の特殊化であることを明記した。`npm run check` 132 ブロック・308 参照すべて解決、linkage 54 件、PDF 40 ページで未解決参照 0 件。Lean と SageMath は未着手。**次 tick はこのセクションの SageMath 検証から。** 並行ストリームは締切のため今 tick は見送った。
- 2026-08-23 07:03（自動ループ）: 本流「有限個の素数への切り詰めは値の衝突を持つ」の **Lean 必要十分版**を書き、このセクションの**四層が揃った**（status を `四層すべて` へ）。抽象版は `lean/Ising3DCut/NecSuf/FinitePrimeTruncationCollision.lean` の `finite_coordinate_truncation_has_a_value_collision`。具体版が実際に使っていた仮定は三つだけだった——(1) 素数が無限に多いことではなく**添字の型が有限集合で尽くせないこと**（`Infinite ι`、mathlib の `Infinite.exists_notMem_finset`。`exists_not_mem_finset` という名前は存在しないので注意）、(2) 付値が $0$ で一致することではなく**相異なる添字 $i\ne j$ で第 $i$ 座標が `witness j` と `base` とで一致すること**、(3) $r\ge2$ ではなく**二つの元が異なること**。素数・自然数・有理数・付値・値の型の零元・順序はすべて削れた。有理数の正値性は主張の飾り（衝突を作る論法に使っていない）なので、付帯条件の述語 `Good` として外へ出した（`Good := fun _ => True` と置けば落ちる）。`lake build` 成功、`check-no-sorry.sh` へ新規 1 件を登録して 305 件が sorry 非依存、`npm run check` 130 ブロック・261 参照すべて解決、linkage 54 件。本文（構造化テキスト）は変更していない。具体版を抽象版から導き直す `...FromNecSuf` は今回作っていない。**次 tick は本流の次のセクション「大きさによる切り詰めは値の衝突を持つ」の記述から。** 並行ストリームは締切のため今 tick は見送った。
- 2026-08-23 06:34（自動ループ）: 本流「有限個の素数への切り詰めは値の衝突を持つ」の **Lean 具体版**を書いて通した（status を `Lean 具体版まで` へ）。ファイルは `lean/Ising3DCut/LimitQuantity/FinitePrimeTruncationCollision.lean`、主定理は `finite_prime_truncation_has_a_value_collision`。素指数データの有限素数集合 $P$ への切り詰めを `primeTruncation P a = fun p => padicValRat p a`（終域は `{p // p ∈ P} → ℤ`）として置き、人手証明の四段（$P$ に属さない素数 $r$ を取る、$u:=1$・$w:=r$ を置く、$P$ のすべての素数で指数が $0$ で一致する、$r\ge2$ より $u\ne w$）と 1 対 1 に対応させた。**書き始めに第一段と第三段の補題を新規に書いたが、同じものが既に `LimitQuantity/FinitelyManyPrimesNotSufficient.lean` に `exists_prime_not_mem` と `padicValRat_prime_ne` として存在した**（`environment already contains` で発覚）ので、重複を消して既存の 2 本を引く形へ直した。`lake build` 成功、`check-no-sorry.sh` へ新規 2 件を登録して 304 件が sorry 非依存、`npm run check` 130 ブロック・261 参照すべて解決、linkage 54 件。本文（構造化テキスト）は変更していない。**次 tick はこのセクションの Lean 必要十分版から。** 並行ストリームは締切のため今 tick は見送った。
- 2026-08-23 05:33（自動ループ）: 本流「定数列の族に限れば、十分な粗視化は値の衝突を持たない」の **Lean 必要十分版**を書き、このセクションの**四層が揃った**（status を `四層すべて` へ）。抽象版は `lean/Ising3DCut/NecSuf/CollidingMapNotSufficient.lean` の `colliding_map_not_sufficient` で、仮定は「粗視化 $\pi$ が二点 $u,w$ で同じ値を取る」「その二点に対応する値 $\mathrm{val}(u),\mathrm{val}(w)$ が異なる」と行き先が位相空間であることだけである。具体版が使っていた有理数であること・正値性・乗根であること・乗根の一意性・Hausdorff 性・順序・代数構造はすべて削れた（残ったのは定数列の収束 `tendsto_const_nhds` を述べるための位相だけ）。導出は `lean/Ising3DCut/LimitQuantity/CollidingCoarseGrainingNotSufficientFromNecSuf.lean` の `colliding_coarse_graining_is_not_sufficient_for_limit_quantity_viaNecSuf` で、入力の型を有理数、値を取る写像を $M=1$ の乗根 `fun v => posRoot (v : ℝ) 1` と置いて特殊化し、具体版と同じ形の主張を取り出す。**具体版の定理は呼び直していない**——使うのは具体版の証明が使う算術の段、すなわち `posRoot_one_eq`（$M=1$ の乗根は値そのもの）だけである。`check-no-sorry.sh` へ新規 3 件を登録し 302 件が sorry 非依存、`lake build` 8818 ジョブ成功、`npm run check` 128 ブロック・257 参照すべて解決、linkage 53 件。本文（構造化テキスト）は変更していない。**次 tick は本流の次のセクション「三つの切り詰めは衝突の判定の系である」から。** 並行ストリームは締切のため今 tick は見送った。
- 2026-08-23 05:03（自動ループ）: 本流「定数列の族に限れば、十分な粗視化は値の衝突を持たない」の **Lean 具体版**を書き、四層のうち三層まで進めた（status を `Lean 具体版まで` へ）。ファイルは `lean/Ising3DCut/LimitQuantity/CollidingCoarseGrainingNotSufficient.lean`、主定理は `colliding_coarse_graining_is_not_sufficient_for_limit_quantity`。人手証明と 1 対 1 に対応させ、**粗視化の行き先の集合と写像を型変数のまま受け取る**形で書いた（本文が粗視化の作り方に何の仮定も置いていないのをそのまま写した）。段は、三つの列 $A,B,M$ の構成と正値性・$M(L)=1\ne0$、すべての添字での $\pi(A(L))=\pi(B(L))$、$M(L)=1$ ゆえ乗根列が定数列に等しいこと（補題 `posRoot_one_const` へ分けた。正の実数乗根の一意性 `eq_posRoot_of_pow_eq` を使う）、二つの定数列の箱サイズ極限がそれぞれ $u$、$w$ であること、そして $u\ne w$ から極限が一致しないことである。`check-no-sorry.sh` の登録配列へ新規 2 件を追加（登録漏れは検査の穴になる）。`lake build` 8816 ジョブ成功、sorry 検査 299 件、`npm run check` 128 ブロック・257 参照すべて解決、linkage 53 件。本文（構造化テキスト）は変更していない。**次 tick はこのセクションの Lean 必要十分版から。** 並行ストリームは締切のため今 tick は見送った。
- 2026-08-23 04:33（自動ループ）: 本流「定数列の族に限れば、十分な粗視化は値の衝突を持たない」の **SageMath 検証**を新設して全 PASS（status を `記述と SageMath まで` へ）。ディレクトリは `sagemath/check/colliding-coarse-graining-is-not-sufficient-for-limit-quantity/`。本文の構成は衝突する二つの値 $u\ne w$ をそのまま定数列に取るだけで、粗視化 $\pi$ の作り方にも値域にも何の仮定も置かないので、検証も**衝突を持つ粗視化の具体例 5 つを並べ、どの例でも同じ段が通る**形にした（素数 2 と 3 の素指数だけ・高さ 1 での頭打ち・符号だけ・分子と分母の偶奇・一点へ潰す）。確かめた段は、衝突の存在、構成した三つの列 $A,B,M$ の帰属、すべての添字での $\pi(A(L))=\pi(B(L))$、$M(L)=1$ ゆえ乗根を取らず `QQ` の中で $a=u$・$b=w$ が済むこと、定数列であること、幅 $|u-w|/2$ での両立不能、および対偶の側として恒等写像の単射性であり、すべて `QQ`・`ZZ` の厳密比較（浮動小数点なし）。極限の存在と値そのものは箱の大きさの極限を使う実数側の言明なので有限検査の対象外とした。`npm run check` 128 ブロック・257 参照すべて解決、`verify-check-linkage` 53 件。**次 tick はこのセクションの Lean 具体版から。** 並行ストリームは締切のため今 tick は見送った。
- 2026-08-23 04:05（自動ループ）: 本流のセクション表に未完了が無くなったので、ゴール文書 `docs/discussion/3次元Isingを可算側で書く/可算コアの同定とは何か.md` の「最初の三手」の三から標的を引き直し、**切り詰めの形を一つずつ試すのをやめて、粗視化が箱サイズ極限に対して十分であるための条件そのものを定理にする**方針へ切り替えた。直前の三 tick（素数の側・指数の大きさの側・符号だけ）がいずれも同じ抽象定理の特殊化で片づき、効いているのは「相異なる二つの値が同じ像へ潰れるか」だけだと分かったためである。台帳では 3 つに割った（十分ならば衝突を持たない／三つの切り詰めがその系である／衝突が無ければ定数列の族の上で十分である）。割った先頭の**記述までをこの tick で終えた**: `claim_colliding_coarse_graining_is_not_sufficient_for_limit_quantity`（`structured-latex/content/partition-values.ts`）。証明は衝突する二つの値 $u\ne w$ をそのまま定数列に取り、$M(L)=1$ として両方の箱サイズ極限が $u$ と $w$ になることを示すだけで、粗視化の作り方にも値域の集合にも何の仮定も置かない。`npm run check` 128 ブロック・257 参照すべて解決、PDF 39 ページ、linkage 52 件。Lean と SageMath は未着手なので status は `記述まで`。**次 tick はこのセクションの SageMath 検証から。** 並行ストリームは締切のため今 tick は見送った。
- 2026-08-23 03:34（自動ループ）: 本流「素指数の符号だけを見る粗視化は極限量に対して十分でない」の **Lean 必要十分版**を書き、この標的の四層をすべて閉じた（status `done`）。**新しい抽象定理は置いていない**——大きさによる切り詰めのために書いた `NecSuf.truncated_coordinate_data_not_sufficient` は座標の値を潰す写像 `t : V → W` に何の仮定も置いていないので、`t := Int.sign` に取り替えるだけで通る。すなわちあちらの必要十分版は「大きさで切り詰める」ことに一切依存していなかった（必要十分版が過剰な仮定を持たないことの検査になった）。導出は `lean/Ising3DCut/LimitQuantity/SignOfPrimeExponentsNotSufficientFromNecSuf.lean` の `sign_of_prime_exponents_is_not_sufficient_for_limit_quantity_fromNecSuf`。具体版の定理は呼び直さず、素指数の計算（既存の `padicValRat_two_of_two` 等）と正の実数乗根の一意性 `eq_posRoot_of_pow_eq` だけを使う。`Ising3DCut.lean` へ import 登録、sorry 検査へ 1 本追加。`lake build` 8815 ジョブ成功、sorry 検査 297 件、`npm run check` 127 ブロック・254 参照すべて解決、linkage 52 件。本文（構造化テキスト）は変更していない。**これで本流のセクション表に未完了が無くなった。次 tick は `docs/discussion/3次元Isingを可算側で書く/可算コアの同定とは何か.md` の「最初の三手」「極限側で問う言明」から標的を引き直す（小主張を自作しない）。** 並行ストリームは締切のため今 tick は見送った。
- 2026-08-23 03:05（自動ループ）: 本流「素指数の符号だけを見る粗視化は極限量に対して十分でない」の Lean 具体版を `lean/Ising3DCut/LimitQuantity/SignOfPrimeExponentsNotSufficient.lean` に書き、記述・SageMath・Lean 具体版の三層まで進めた。定数列 2 と 4 を取り、素数 2 での素指数が異なるのに符号が一致すること、他の素数では両方 0 であること、二つの極限値が異なることを形式化した。`lake build` 8814 ジョブ成功、sorry 検査 296 件。次は必要十分版。
- 2026-08-23 02:32: 本流「素指数の符号だけを見る粗視化は極限量に対して十分でない」の SageMath 検証を新設して全 PASS（記述と SageMath の二層まで）。次は Lean 具体版。
- 2026-08-23 02:05: 本流の新しい標的「最小性: 素指数の符号だけを見る粗視化は極限量に対して十分でない」を引き直し、**記述の層**まで進めた（`claim_sign_of_prime_exponents_is_not_sufficient_for_limit_quantity`、`structured-latex/content/partition-values.ts`）。素指数データの切り詰めには三つの向きがあり、素数の側（有限個の素数へ落とす）と指数の値の大きさの側（高さ $N$ で頭打ちにする）は既に四層で閉じていたので、残る「指数の大きさを完全に捨てて符号だけを残す」向きを扱った。反例は定数列 $A(L)=2$、$B(L)=4$、$M(L)=1$。素数 $2$ での素指数は $1$ と $2$ で異なるが $\operatorname{sgn}$ はどちらも $1$、$2$ 以外の素数では両方 $0$ なので全素数で符号が一致し、それでも箱サイズ極限は $2$ と $4$ で異なる。着手前に既存ラベルを検索し、符号を扱う主張が無いことを確認した（前々 tick の重複事故を受けた手順）。`npm run check` 127 ブロック・254 参照すべて解決、`verify-check-linkage` 51 件。**次 tick はこの標的の SageMath 検証から。**
- 2026-08-23 01:36: 本流「最小性: 素指数を大きさで切り詰める粗視化は極限量に対して十分でない」の **Lean 必要十分版と導出**を書き、この標的の四層をすべて閉じた。必要十分版は `lean/Ising3DCut/NecSuf/MagnitudeTruncationNotSufficient.lean` の `truncated_coordinate_data_not_sufficient`。具体版が実際に使っている性質だけを残し、切り詰めが $\min$ であること・座標が素数であること・値が整数や正の実数であること・乗根・Hausdorff 性は落とした（残した仮定は「座標ごとに切り詰めた値が一致する」「ある一つの座標では切り詰める前の値が一致しない」「二つの値が異なる」と位相空間だけで、位相は定数列の収束を述べるために要る）。導出は `lean/Ising3DCut/LimitQuantity/MagnitudeTruncatedPrimeExponentsNotSufficientFromNecSuf.lean` の `..._fromNecSuf`。座標を素数の部分型（合成数を入れると $\min$ の一致が壊れる。$N=1$ で $p=4$ が反例になる）、切り詰めを高さ $N$ での $\min$、二つの値を $2^{N}$ と $2^{N+1}$ に特殊化して、具体版と同じ形の主張を取り出す。具体版の定理は呼び直していない（呼び直すと必要十分版の検査にならない）。sorry 検査の登録配列へ 2 本追加。`lake build` 8813 ジョブ成功、sorry 検査 295 件、`npm run check` 126 ブロック・250 参照すべて解決、linkage 51 件。本文（構造化テキスト）は変更していない。レビューは前 tick の Lean 具体版と本文の記号を読み直し、直すところは無かった。**次 tick はセクション表に残る「健全性の橋」の未完了か、ゴール文書からの標的の引き直しから。** 並行ストリーム（2 次元の Pfaffian 予言）は締切のため今 tick も見送った。
- 2026-08-23 01:05: 本流「最小性: 素指数を大きさで切り詰める粗視化は極限量に対して十分でない」の **Lean 具体版**を書き、四層のうち三層まで進めた。ファイルは `lean/Ising3DCut/LimitQuantity/MagnitudeTruncatedPrimeExponentsNotSufficient.lean`。人手証明の段と 1 対 1 に対応させ、2 のべきの素指数の計算を二つの補題へ分けた（`padicValRat_two_pow`: 素数 2 での素指数は指数そのもの、`padicValRat_ne_two_pow`: 2 以外の素数では 0）。そのうえで主定理 `magnitude_truncated_prime_exponents_are_not_sufficient_for_limit_quantity` が、切り詰めの一致・素数 2 での相違・二つの定数列の収束・極限値の相違を別々の段として示す。mathlib へ委ねたのは素因数分解の値の計算（`padicValNat.prime_pow` と割り切れないときの 0）だけで、極限と乗根はプロジェクト側の `posRoot` と `eq_posRoot_of_pow_eq` を使った。**sorry 検査の登録配列へ 3 本を追加した**（登録漏れは検査の穴になる。追加前は 290 件で新定理が検査対象外だった）。`lake build` 8811 ジョブ成功、sorry 検査 293 件、`npm run check` 126 ブロック・250 参照すべて解決、linkage 51 件。レビューでは同じ主張の中で切り詰めの高さ $N$ と収束の閾値 $N_a,N_b$ が同じ文字を別の意味で使っていたので閾値を $L_a,L_b$ へ改名し、最後の根拠を $(\because\ \dots)$ の形へ揃えた。**次 tick はこの標的の Lean 必要十分版から。** 並行ストリーム（2 次元の予言、terminal graph の頂点分解）は締切のため今 tick は見送った。
- 2026-08-23 00:35: 本流の新標的「最小性: 素指数を大きさで切り詰める粗視化は極限量に対して十分でない」を、記述と SageMath の二層まで進めた。前 tick で「引き直した標的が既存主張と重複していた」ため、今回は着手前に本文の既存ラベル（粗視化・極限量に関するもの）を全件検索して重複が無いことを確認してから書いた。素指数データの切り詰めには**素数の側**（既存の `claim_finitely_many_primes_are_not_sufficient_for_limit_quantity`）と**値の大きさの側**（今回）の二つの向きがあり、後者は未着手だった。主張は `claim_magnitude_truncated_prime_exponents_are_not_sufficient_for_limit_quantity`：任意の高さ $N\ge1$ に対し、$\min\{v_p,N\}$ による切り詰めが一致するのに箱サイズ極限が異なる列の組が存在する。反例は定数列 $A(L)=2^{N}$、$B(L)=2^{N+1}$（$M(L)=1$）で、素数 $2$ での指数は $N$ と $N+1$ と異なるが切り詰めるとどちらも $N$ になり、$2$ 以外の素数では両方 $0$ である。極限は $2^{N}$ と $2^{N+1}$ で異なる。`npm run check` 126 ブロック・250 参照すべて解決、SageMath は新設 `magnitude-truncated-prime-exponents-are-not-sufficient-for-limit-quantity/`（高さ 1,2,3,5,8 で ALL PASS、linkage 51 件）。**Lean の二層は未着手なので status は `記述と SageMath まで`。次 tick はこの標的の Lean 具体版から。** 並行ストリーム（2 次元の Pfaffian 予言、terminal graph の頂点分解）は締切のため今 tick は見送った。
- 2026-08-22 23:35: 前 tick で残っていた「最小性: 有限個の素数での指数だけを見る粗視化は極限量に対して十分でない」の Lean 必要十分版の層を、具体版の主張の形へ接続して閉じた。四層すべてが揃った。前 tick の導出は「付値の族と、そこから戻る正の実数」の形で反例を取り出すところまでで、具体版が述べる「有理数列の正の乗根列」の形とは繋がっていなかった。今回そのすき間を `realOfExponents_zero_eq_posRoot`（付値がすべて 0 の族から戻る値は $\mathrm{posRoot}(1,1)$）と `realOfExponents_single_eq_posRoot`（素数 $r$ でだけ 1 の族から戻る値は $\mathrm{posRoot}(r,1)$）で埋め、正の実数乗根の一意性 `eq_posRoot_of_pow_eq` から示した。そのうえで `finitely_many_primes_are_not_sufficient_for_limit_quantity_viaNecSuf` が、具体版と同じ形（有理数列・指数列・乗根列の収束・二つの極限値の相違）の主張を必要十分版の特殊化として取り出す。**接続で具体版の定理そのものを呼び直していない**——使ったのは具体版の証明が使う算術の段、すなわち相異なる素数での付値が 0 であること `padicValRat_prime_ne` と乗根の一意性だけである（呼び直すと必要十分版の検査にならないため）。`lake build` 8810 ジョブ成功・sorry 検査 290 件、`npm run check` 125 ブロック・246 参照すべて解決、linkage 50 件。本文は変更していない。**次 tick は並行ストリーム「2 次元からの事前予言」の Lean 具体版の続き、すなわち terminal graph の頂点分解と内部辺の張り方の導入から進める。**
- 2026-08-22 23:15: 新標的「最小性: 有限個の素数での指数だけを見る粗視化は極限量に対して十分でない」を、記述・SageMath・Lean 具体版の三層まで進めた。極限量の入力である素指数データを、あらかじめ決めた有限個の素数での指数だけへ切り詰めると、どの有限集合を選んでも極限量は決まらない。$S$ が有限なので $S$ に属さない素数 $r$ が取れ、定数列 $A(L)=1$ と $B(L)=r$（指数は $N(L)=1$）は $S$ のすべての素数で素指数が一致するのに、乗根列の箱サイズ極限は $1$ と $r$ で異なるからである。記述は 1 ブロック `claim_finitely_many_primes_are_not_sufficient_for_limit_quantity`、`npm run check` は 125 ブロック・246 参照すべて解決、PDF 38 ページ。SageMath は新設 `finitely-many-primes-are-not-sufficient-for-limit-quantity/`（$S$ を 6 通り変えて全 PASS、linkage 50 件）。Lean は具体版 `LimitQuantity/FinitelyManyPrimesNotSufficient.lean`、必要十分版 `NecSuf/FinitePrimeTruncationNotSufficient.lean`（仮定はどの有限集合の外にも述語を満たす添字が残ること・切り詰めた座標での一致・値の相異と位相空間だけ）、導出 `…FromNecSuf.lean` を置き、`lake build` 8810 ジョブ成功・sorry 検査 290 件通過。**ただし導出は付値の族と値の形の反例までで、具体版の乗根列の形の主張へ接続していないので必要十分版の層は閉じていない。次 tick はその接続を書く（具体版を呼び直して形だけ整えることはしない）。**
- 2026-08-22 22:37: 新標的「最小性: 有限個の添字でしか成り立たない交差べき等式は極限量に対して十分でない」を四層すべて 1 tick で閉じた。直前 tick で交差べき等式の仮定を共終性まで弱めたので、その弱め方が限界であることを反対側から挟んだ。すなわち、成り立つ添字が空でない有限集合（最小の添字ただ一つ）でしかないときは、二つの乗根列の箱サイズ極限がともに存在しても値が異なりうることを、一方が定数列 1・他方が最初の添字だけ 1 で以降 2 を取る列という反例で示した。記述は 1 ブロック `claim_finitely_many_cross_power_equalities_are_not_sufficient_for_limit_quantity`、`npm run check` は 124 ブロック・243 参照すべて解決。SageMath は新設 `finitely-many-cross-power-equalities-are-not-sufficient-for-limit-quantity/`（全 PASS、linkage 49 件）。Lean は具体版 `FinitelyManyCrossPowerEqualitiesNotSufficient.lean`、必要十分版 `NecSuf/FinitelyManyAgreementsNotSufficient.lean`（仮定は位相空間と二値の相異だけ）、導出 `…FromNecSuf.lean` で、`lake build` 8806 ジョブ成功・sorry 検査 281 件通過。あわせて並行（Pfaffian 予言）も 1 件進め、terminal graph の内部辺の重みが 1 であることと外部辺が元の辺と単射に対応することから、完全マッチングの重みが選ばれていない辺の上の $(1+x)/(1-x)$ の積になる段を `TerminalMatchingInternalWeight.lean` に形式化した（sorry 検査 283 件）。次は並行ストリーム（Pfaffian 予言の Lean 具体版。terminal graph の構造導入）か、ゴール文書から新しい本流標的を引き直すかを着手前レビューで判断する。
- 2026-08-22 21:41: 新標的「最小性: 共終な添字での交差べき等式は極限量に対して十分である」を四層すべて 1 tick で閉じた。直前 tick で「ある添字 $L_0$ 以降のすべて」へ弱めた十分性を、さらに「成り立つ添字が共終である」（破れる添字がいくらでも大きいところにあってよい）まで弱めても、両方の箱サイズ極限が存在する限り値の一致は保たれることを示した。あわせて、この弱め方では一方の極限の存在そのものは導けないことを反例（定数列と、奇数で 1・偶数で 2 を取る列）で明示し注意として置いた。記述 3 ブロック（`claim_cofinal_equal_positive_real_sequences_share_limit`・`remark_cofinal_agreement_does_not_give_existence`・`claim_cofinal_cross_power_equality_is_sufficient_for_limit_quantity`）で 123 ブロック・240 参照すべて解決、PDF 37 ページ。SageMath は新設 `cofinal-cross-power-equality-is-sufficient-for-limit-quantity/`（成立する添字を奇数だけに取り、尾部版の仮定を満たさないことも同時に検査。全 PASS、linkage 48 件）。Lean は具体版 2 本・必要十分版 2 本・導出 1 本を追加し `lake build` 8802 ジョブ成功、sorry 検査 275 件通過。並行（Pfaffian 予言）も 1 件進め、符号の括り出しと分母消去の有限恒等式を束ねる `fisherBoundaryResponse_clearedPfaffian_eq_evenSubgraphSum` を新設した（sorry 検査 276 件）。次は弱められる限界を反対側から挟む「有限個の添字でしか成り立たない交差べき等式は十分でない」の反例か、並行ストリーム（Pfaffian 予言の Lean 具体版）を着手前レビューで選ぶ。
- 2026-08-22 20:35: 新標的「最小性: 有限個の例外を除いた交差べき等式（尾部の交差べき等式）は極限量に対して十分である」を、着手からこの tick 内で四層すべて閉じた。既存の「有限箱値の交差べき等式は極限量に対して十分である」（すべての箱 $L$ で交差べき等式 $A_L^{M_L}=B_L^{N_L}$ を要求する主張）の証明が、実際には各添字ごとの一箱の乗根一致の適用（全添字への依存なし）と、乗根列の項別一致から極限へ渡す収束移送の合成でしかないことに着目し、仮定を「すべての箱」からある添字 $L_0$ 以降だけへ弱めても十分性が保たれることを示した（$L_0$ 未満での成立・不成立は問わない）。記述は二つの新主張：`claim_tail_equal_positive_real_sequences_transfer_limit`（既存の `claim_pointwise_equal_positive_real_sequences_transfer_limit` の一般化。$\varepsilon$-$N$ 論法で $N:=\max\{L_0,N_\varepsilon\}$ を取るだけ）と、それを一箱ごとの乗根一致主張と合成した `claim_tail_cross_power_equality_is_sufficient_for_limit_quantity`。`npm run check` 118→120 ブロック・230→234 参照すべて解決。SageMath は `sagemath/check/tail-cross-power-equality-is-sufficient-for-limit-quantity/` を新設：$L_0=2$ とし、$L=1$（$L_0$ 未満）ではあえて交差べき等式が破れ乗根も不一致な例を混ぜたうえで、$L\ge L_0$ の各項の乗根一致・項別一致・収束移送の等式書き換えを `QQ` 上で確認（全 PASS。linkage 46→47 件）。Lean 具体版は、既存の一般補題 `tailAgreement_tendsto`（実数列版。仮定 `∃ N, ∀ n≥N, a n=b n` がすでに一般の添字 $N$ で書かれていたため、`claim_tail_equal_positive_real_sequences_transfer_limit` 用の新規補題は複製と判断して置かなかった）をそのまま転用し、新規 `tail_cross_power_equality_is_sufficient_for_limit_quantity`（`TailCrossPowerEqualitySufficientForLimitQuantity.lean`）だけを追加した。Lean 必要十分版は `tail_cross_power_equality_is_sufficient_for_limit_quantity_abstract`（モノイド・位相空間だけを仮定し、既存の `NecSuf.cross_power_equality_implies_root_equality_abstract` と `tailAgreement_tendsto_abstract` の合成）と、具体版からの特殊化 `_fromNecSuf` で揃えた。`Ising3DCut.lean` へ import 登録、`check-no-sorry.sh` に 3 定理登録、`lake build` 8797 ジョブ成功、sorry 検査 268→270 件通過。着手前レビューは直前 tick（20:07）の否定判定記録が台帳・ゴール文書と一致していることを確認し修正なし。並行（Pfaffian 予言）は時間内に着手できず見送り。次 tick の本流は、ゴール文書「可算コアの同定とは何か」の自由エネルギー密度についての最小性の続き（今回の尾部一般化からさらに条件を弱められるか、または交差べき等式以外の粗視化の候補）を選ぶか、並行ストリーム（Pfaffian 予言。terminal graph 構造の導入）を優先するかを着手前レビューで判断する。
- 2026-08-22 20:07: 本流のセクション表に未完了が無くなった後、ゴール文書「可算コアの同定とは何か」の「極限側で問う言明」の唯一未着手だった行「臨界点（実軸に最も近い零点の列で決まるか）」を候補として引き直したが、着手前に否定判定「2 次元から事前に予言が出ない」に該当すると判定して落とした。根拠は既存の研究ノート `docs/discussion/臨界指数をFisher零点列で書く/何が厳密で何が非厳密か.md` で、この候補の核心である関係式 $\lvert u_1(L)-u_c\rvert\sim L^{-1/\nu}$（実軸最近接零点列と臨界点の隔たりの漸近形）が、道具の最も揃った 2 次元 Ising（$u_c=\sqrt2-1$ が自己双対性から厳密に分かる）についてすら「一般の模型について証明された定理ではない」「不明［要調査］」と既に記録されていたこと。2 次元の閉形式から測定前に導出できる代数的命題が無いため、新たな SageMath 計算はせず判定のみで候補を落とした（台帳と可算コアの同定とは何か.md の該当行へ記録）。ゴール文書の他の 2 行（自由エネルギー密度・判別式/Galois 群）は主標的表で扱い済みで、自由エネルギー密度の「最小性が本題」は継続深化中（次 tick が引き継ぐ）。着手前レビューは `npm run check`（118 ブロック・230 参照すべて解決）・`lake build`（8794 ジョブ成功）・sorry 検査（267 件）・`verify-check-linkage`（46 件）を再実行して修正なし。並行（Pfaffian 予言）は文献調査に時間を使ったため本 tick は見送り。
- 2026-08-22 19:11: 本流「交差べき等式は極限量に対して必要でない反例」の Lean 必要十分版を閉じ status `done`（四層完了）。既存の必要十分版 `value_invariant_does_not_determine_limit_quantity`（不変量の値の不一致・フィルタを保つ添字写像・項別一致・Hausdorff 極限一意性だけ。値の型は任意）がそのまま抽象形を担うと判断し、新しい抽象定理は置かず、具体版を `cross_power_equality_is_not_necessary_for_limit_quantity_fromNecSuf` として特殊化した（値の型 ℕ、二つの値は `freeBoxTwoValueAtTwo^27`・`shiftedFreeBoxTwoValueAtTwo^8`、不一致は `crossPowerEquality_fails_at_two`、添字写像は末尾ずらし。`Ising3DCut.lean` へ import 登録、`check-no-sorry.sh` へ登録、sorry 検査 266 件通過）。本流のセクション表に未完了が無いので、次 tick はゴール文書「可算コアの同定とは何か」から標的を引き直す。並行では `Prediction.fisherMatchingWeight_cleared` を辺の部分集合全体 `A.powerset` 上の和へ束ねた `Prediction.fisherBoundaryResponse_clearedWeightSum_eq_evenSubgraphSum` を形式化した（完全マッチング辺集合を動く添字 `S⊆A` と選ばれていない辺の集合 `F:=A\S` の間の全単射 `S↦A\S` で `Finset.sum_nbij'` を適用。`Finset.sdiff_sdiff_eq_self` で対合性を示す。sorry 検査 267 件通過）。まだ「偶」の条件・Pfaffian の定義・実際の terminal graph 構造（`Edge`・向き付け・符号）は Lean に置いていないので Pfaffian 具体版は未完。次は構造導入か、コストが大きすぎると分かれば並行の標的自体を見直す。着手前レビューは `npm run check`（118 ブロック・230 参照すべて解決）・`lake build`（8793 ジョブ成功）・sorry 検査（265 件）・`verify-check-linkage`（46 件）を再実行して修正なし。
- 2026-08-22 14:52: 本流「交差べき等式は極限量に対して必要でない反例」の Lean 具体版を閉じ、status を `記述・SageMath・Lean 具体版まで` へ上げた。`Ising3DCut/LimitQuantity/CrossPowerEqualityNotNecessaryForLimitQuantity.lean` を新設し、$Z_2(2)=36450$・$Z_3(2)=942223653336523266$ を「2 で割った奇数部分」への分解で表し、27 乗・8 乗後の偶奇の食い違いから交差べき等式の破れ `crossPowerEquality_fails_at_two` を示した（`padicValNat` は well-founded 再帰で `decide` が展開できないため、素因数 2 の指数比較の代わりに奇数判定＋偶奇矛盾で同内容を示す形にした）。既存の末尾ずらし極限定理と束ねて `cross_power_equality_is_not_necessary_for_limit_quantity` を形式化（`Ising3DCut.lean` へ import 登録、`check-no-sorry.sh` に新規 5 定理を登録、sorry 検査 265 件通過）。前進前レビューは記述済みブロックの habitat・realEscape と禁止語の非混入を確認し修正なし。次 tick の本流は Lean 必要十分版。並行（Pfaffian 予言）は今 tick は見送り。
- 2026-08-22 15:00: 自動ループが 2026-08-20 07:36 の公開を最後に 2 日以上まったく前進していなかったのを直した。原因は tick の Claude 側が `claude-fable-5` に固定されており、このループ専用アカウント（coding-agent-0004）の Fable 5 の枠が尽きて毎時 2 秒で異常終了していたこと（実測 60 回）。同アカウントで sonnet / opus / haiku は応答することを確認したうえで、固定モデルを `claude-opus-5` へ変更した（当初 sonnet にしたが、同日中に人の指示で opus へ）（実行時に別モデルへ落とすフォールバックは引き続きしない）。あわせて期限切れの `claude-blocked-until` の目印を消した。codex 側は 08-23 07:00 頃まで上限中で、これは待つしかない。
- 2026-08-20 07:34: 本流「交差べき等式は極限量に対して必要でない反例」の SageMath 層を閉じ status `記述と SageMath まで`。check `cross-power-equality-not-necessary/` 新設：末尾ずらしの項別一致（$L=1,2,3$ で $Z'_L(2)=Z_{L+1}(2)$・箱点数一致・特徴づけの有限べき等式の同一性）と、破れの結論 $Z_2(2)^{27}\ne Z_3(2)^{8}$ の独立再計算による受け取りを `ZZ` 上で全 PASS（linkage 46 件。対象ラベル付けも同時に閉じた）。レビュー（`npm run check`、118 ブロック・230 参照）修正なし。次 tick は Lean 具体版、その後 Lean 必要十分版。並行は締切のため見送り。
- 2026-08-20 07:03: 開始が締切 8 分前。レビュー（`npm run check` 再実行、118 ブロック・230 参照）修正なし。本文未変更、PDF 再生成。本流「交差べき等式は極限量に対して必要でない反例」の残りを二つへ割った：先頭は check `cross-power-equality-not-necessary/` の新設（束ね主張の証明の可算側の合成を本文と同順に `ZZ`/`QQ` 上で確認）、次に対象ラベル付けと linkage 登録。次 tick は割った先頭から。並行は締切のため見送り。
- 2026-08-20 06:33: 本流「交差べき等式は極限量に対して必要でない反例」の破れの主張の SageMath 検証を閉じた。check `cross-power-equality-fails-at-two/` 新設：$Z_2(2)=36450$、$Z_3(2)=942223653336523266$ の厳密評価（層転送＋$L=2$ 全列挙）、素因数 $2$ の指数 $27\ne8$、$Z_2(2)^{27}\ne Z_3(2)^{8}$、$q=1$ で両辺 $2^{216}$ の確認をすべて `ZZ` 上で全 PASS（linkage 45 件）。レビュー（`npm run check`、118 ブロック・230 参照）修正なし。次 tick は束ね主張側の SageMath 検証と対象ラベル付け・linkage、その後 Lean 具体版・必要十分版。並行は締切のため見送り。
- 2026-08-20 06:02: 開始が締切 8 分前。レビュー（`npm run check` 再実行、118 ブロック・230 参照）修正なし。本文未変更、PDF 再生成。本流「交差べき等式は極限量に対して必要でない反例」の SageMath 検証を二つへ割った：先頭は check `cross-power-equality-fails-at-two/` の新設（評価点 $2$・箱 $L=2$ の分配多項式値の厳密計算と素因数 $2$ の指数 $27\ne8$、交差べき等式の破れ、$q=1$ 不可の確認を `ZZ` 上で行う）、次に束ね主張側の検証と対象ラベル付け・linkage。次 tick は割った先頭から。並行は締切のため見送り。
- 2026-08-20 05:33: 本流「交差べき等式は極限量に対して必要でない反例」の記述層を閉じた。評価点 $2$・箱 $L=2$ での破れの主張と、判別式反例の証明後半で示した末尾ずらしの極限一致を束ね、交差べき等式が極限量の存在と一致に十分だが必要でないことを `claim_shifted_free_family_cross_power_equality_is_not_necessary_for_limit_quantity` として記述（habitat R、新たな脱出なし）。レビュー（`npm run check`、117→118 ブロック・230 参照）修正なし。check・PDF 35 ページ・linkage 44 件通過。次 tick は束ね主張の SageMath 検証、その後 Lean 具体版・必要十分版。並行の次は接続補題を束ね定理へ適用して Pfaffian 予言の Lean 具体版を閉じる。
- 2026-08-20 05:08: 本流「交差べき等式は極限量に対して必要でない反例」の先頭を閉じた。$q=2,L=2$ で $Z_2(2)=36450$、$Z_3(2)=942223653336523266$ を厳密計算し、素因数 2 の指数 $27\ne8$ から破れの主張 `claim_shifted_free_family_cross_power_equality_fails_at_two` を記述（可算側・脱出なし。$q=1$ は両辺 $2^{216}$ で不可を確認）。レビュー（`npm run check`、116→117 ブロック・225 参照）修正なし。check・PDF 35 ページ・linkage 44 件・Lean 255 件通過。次 tick は破れと末尾ずらし極限一致を束ねる反例主張の記述、その後 SageMath 検証。並行では接続補題 `Prediction.fisherMatchingWeight_cleared`（共通分母を掛けた 1 マッチングの重み＝マッチング辺 $1+x$×非マッチング辺 $1-x$ の積）を閉じ、レビューで並行の Lean 補題 4 本の sorry 検査未登録を登録（260 件通過）。並行の次は接続補題を束ね定理へ適用して Pfaffian 予言の Lean 具体版を閉じる。
- 2026-08-20 04:36: 開始が締切 8 分前。レビュー（`npm run check` 再実行、116 ブロック・221 参照）修正なし。本文未変更、PDF 再生成。ゴール文書の自由エネルギー密度の最小性から新標的「交差べき等式は極限量に対して必要でない反例」を台帳へ追加した。ずらした自由族 $Z'_L=Z_{L+1}$ で極限量は一致するが、$q=2,L=2$ で $Z_2(2)^{27}\ne Z_3(2)^8$ が破れる見込み（$q=1$ は両辺が一致して使えないので評価点の厳密判定を先頭に含めた）。台帳の前進の記録が 29 件に膨れていたのを規約どおり 5 件へ整理した。次 tick は評価点の判定と本文の主張ブロック記述から。並行は Fisher 外部辺の有限積を全完全マッチング重み和へ接続する特殊化。
- 2026-08-20 03:33: 本流「有限箱値の交差べき等式は極限量に対して十分である」の Lean 必要十分版を閉じ status `done`（四層完了）。具体版を各箱の累乗単射性だけを渡す特殊化 `_fromNecSuf` として導出。レビューで 02:03 の具体版束ね定理が sorry 検査に未登録だったのを登録（255 件通過）。次 tick はゴール文書から本流の標的を引き直す。並行は Fisher 外部辺の有限積を全完全マッチング重み和へ接続する特殊化。
- 2026-08-20 03:04: 本流の最終束ね定理の Lean 必要十分版の抽象版を閉じた。既存の交差べき抽象補題と尾部一致の収束移送抽象補題を合成し、正値性・実数・正の乗根を落とした。次 tick は具体版をこの抽象版から特殊化で導出し、本流の status を `done` へ上げる。
- 2026-08-20 02:33: 開始が締切 7 分前。レビュー（`npm run check` 再実行、116 ブロック・相互参照 221 件）修正なし。本文未変更、PDF 再生成。本流「有限箱値の交差べき等式は極限量に対して十分である」の Lean 必要十分版を二つへ割った：先頭は「最終束ね定理が実際に使う仮定だけを残した抽象版の設置（既存の `cross_power_equality_implies_root_equality_abstract` と収束移送補題の再利用可否を判定）」、次に「具体版の特殊化としての導出と `done` への更新」。次 tick は割った先頭から。並行は締切のため見送り。
- 2026-08-20 02:03: 本流「交差べき等式は極限量に対して十分」の最終束ね主張の Lean 具体版を閉じた。項別一致補題と既存の実数列収束移送を一度ずつ合成した。並行では Fisher 外部辺の分母消去を有限積へ束ねた。次 tick の本流は最終束ね主張の Lean 必要十分版、並行は有限積から全完全マッチング重み和への接続。
- 2026-08-20 01:36: 分割済み先頭「収束移送の適用形」を再利用の判定で閉じた。既存の `tendsto_iff_of_pointwise_eq` が全添字一致の実数列の収束の同値を既に担うため、新補題（build・sorry 検査 252 件通過まで確認）は複製として撤去。次 tick は仮定充足補題とこの既存補題を合成して最終束ね主張の Lean 具体版を閉じる。
- 2026-08-20 01:32: 開始が締切 8 分前。レビュー（`npm run check` 再実行、116 ブロック・264 参照）修正なし。本文未変更、PDF 再生成。本流の最終束ね主張の Lean 具体版の残りを二つへ割った：先頭は「項別一致した乗根列へ既存の収束移送補題 `tailAgreement_tendsto` を適用できるかの判定と適用形の補題」、次に「仮定充足補題との合成で Lean 具体版を閉じ status を `Lean 具体版まで` へ」。次 tick は割った先頭から。並行は締切のため見送り。
- 2026-08-20 01:04: 本流「有限箱値の交差べき等式は極限量に対して十分である」の Lean 具体版の分割済み先頭を閉じた。全箱の交差べき等式へ既存の一箱の補題を各添字で適用し、二つの正の乗根列の項別一致を得る `pointwise_cross_power_equality_implies_root_sequence_equality` を形式化した。次 tick はこの項別一致と収束移送を合成して最終の束ね主張の Lean 具体版を閉じる。並行は各辺の分母消去等式を有限積と完全マッチング全体へ束ねる。
- 2026-08-20 00:47: 開始が締切 8 分前。レビュー（`npm run check` 再実行、116 ブロック・264 参照）修正なし。本文未変更、PDF 再生成。本流「有限箱値の交差べき等式は極限量に対して十分である」の束ね主張の Lean 具体版を二つへ割った：先頭は「交差べき等式の仮定から二つの正の乗根列の全添字での項別一致を得る補題（既存の一箱の乗根一致 `cross_power_equality_implies_posRoot_equality` を各添字へ適用）」、次に「収束移送（既存 `tailAgreement_tendsto` の再利用可否を判定）と合成して Lean 具体版を閉じる」。次 tick は割った先頭から。並行は締切のため見送り。
- 2026-08-19 22:33: 本流「有限箱値の交差べき等式は極限量に対して十分である」の最終の束ね主張を SageMath で検証し、status を `記述と SageMath まで` へ進めた。三項の有限列について、交差べき等式から乗根の項別一致を得て収束移送へ渡す可算側の合成を `QQ` 上で本文と同順に確認した（linkage 44 件）。全検証と PDF 再生成を通過。次 tick の本流は束ね主張の Lean 具体版、並行は各辺の分母消去等式を有限積と完全マッチングへ束ねる特殊化。
- 2026-08-19 22:04: 本流「有限箱値の交差べき等式は極限量に対して十分である」の最終の束ね主張を記述し、記述層が揃った（仮定充足主張と収束移送主張の合成で、一方の箱サイズ極限の存在から他方の存在と値の一致を結論）。レビューは `npm run check` 再実行で修正なし。次 tick の本流は束ね主張の SageMath 検証、並行は各辺の分母消去等式を有限積と全完全マッチングへ束ねる特殊化。
- 2026-08-19 21:32: 本流で、交差べき等式から作る二つの正の乗根列が既存の収束移送主張の項別一致仮定を満たすことを独立主張として記述した。レビューは `npm run check` 再実行で修正なし。並行では Fisher 外部辺重みの具体的な分母消去等式を Lean で閉じた。次 tick の本流は極限量の存在と一致を結論する最終の束ね主張、並行は各辺の等式を有限積と完全マッチングへ束ねる特殊化。
- 2026-08-19 21:02: 開始が締切 8 分前。レビュー（`npm run check` 再実行、114 ブロック・214 参照）修正なし。本文未変更、PDF 再生成。本流「有限箱値の交差べき等式は極限量に対して十分である」の残りの束ね主張の記述を二つへ割った：先頭は「交差べき等式が全箱で成り立てば既存の項別一致主張により二つの乗根列が収束移送主張の仮定を満たすことの主張の記述」、次に「一方の箱サイズ極限の存在から他方の存在と値の一致を結論する最終の束ね主張の記述」。次 tick は割った先頭から。並行は締切のため見送り。
- 2026-08-19 20:34: 本流で、項別一致する正の実数列の一方の箱サイズ極限を他方へ移し値が一致する主張を記述した。既存の尾部一致の十分性は有限箱の素指数列に型を限定しているため直接再利用せず、収束移送部分を独立させた。並行では、terminal graph の完全マッチング重み和へ共通分母を分配し、項ごとの分母消去済み重み等式から偶部分グラフ重み和を得る Lean 補題を閉じた。次 tick の本流は交差べき等式から極限量までの束ね、並行は各辺の具体的な分母消去等式への特殊化。
- 2026-08-19 20:02: 開始が締切 10 分前。レビュー（`npm run check` 再実行、113 ブロック）修正なし。本文未変更、PDF 再生成。本流「有限箱値の交差べき等式は極限量に対して十分である」の極限側の束ね主張の記述を二つへ割った：先頭は「全添字で項別一致する二つの正の実数の乗根列に対する収束移送の主張の記述（既存の尾部一致の十分性は有限箱量の列に型を限定しているため再利用可否の判断を含む）」、次に「交差べき等式が全箱で成り立てば極限量の存在と一致が従う十分性の束ね主張の記述」。次 tick は割った先頭から。並行は締切のため見送り。
- 2026-08-19 19:36: 本流「有限箱値の交差べき等式は極限量に対して十分である」の分割済み先頭を記述した。正の乗根列の全添字での項別一致から、一致開始添字 $1$ の尾部一致の等式条件を得た。既存の尾部一致の定義は $\mathbb N\times\Lambda$ 値の列に型を限定しているため、正の実数列へ定義そのものを直接適用せず、同じ等式条件であることを明記した。並行では terminal graph の全単射が重みを保つとき完全マッチング重み和と偶部分グラフ重み和が一致する Lean 補題を閉じた。次 tick は本流の極限側の束ねと、並行の具体的な重み等式への接続から進める。
- 2026-08-19 19:04: 開始が締切 8 分前。レビュー（`npm run check` 再実行、112 ブロック・211 参照）修正なし。本文未変更、PDF 再生成。本流「有限箱値の交差べき等式は極限量に対して十分である」の極限側の主張の記述を二つへ割った：先頭は「全ての箱での乗根列の項別一致がずらし無し（一致開始添字 1）の尾部一致になるという主張の記述」、次に「既存の尾部一致の十分性との合成で箱サイズ極限の存在と一致へ渡す束ね主張の記述」。次 tick は割った先頭から。並行は締切のため見送り。
- 2026-08-19 18:32: 本流「有限箱値の交差べき等式は極限量に対して十分である」の割った先頭 `claim_pointwise_cross_power_equality_implies_root_sequence_equality` を記述した。各箱の交差べき等式へ既存の一箱の乗根一致を適用し、二つの正の乗根列が全添字で項別一致する。着手前レビューは `npm run check`（111 ブロック・210 参照）で修正なし。次 tick は、この項別一致を既存の尾部一致の十分性と合成して箱サイズ極限の存在と一致へ渡す極限側の主張を記述する。並行はまとめ締切を優先して見送り。
- 2026-08-19 18:04: 開始が締切 8 分前。レビュー（`npm run check` 再実行、111 ブロック・210 参照）修正なし。本文未変更、PDF 再生成。本流「有限箱値の交差べき等式は極限量に対して十分である」の十分性の主張の記述を二つへ割った：先頭は「各箱で交差べき等式が成り立つ二組の列の乗根列が全ての $L$ で項別一致するという可算側の主張の記述」、次に「項別一致を尾部一致の特別な場合として既存の尾部一致の十分性と合成し、箱サイズ極限へ渡す極限側の主張の記述」。次 tick は割った先頭から。並行は締切のため見送り。
- 2026-08-19 17:35: 本流「有限箱値の交差べき等式は極限量に対して十分である」先頭主張の Lean 必要十分版を閉じた。具体版を、対象二元での正の自然数乗の単射性だけを抽象版へ渡す特殊化 `cross_power_equality_implies_posRoot_equality_fromNecSuf` として導出した。次 tick は各箱での交差べき等式から乗根列の項別一致を得て箱サイズ極限へ渡す十分性の主張を記述する。並行はまとめ締切を優先して見送り。
- 2026-08-19 17:33: 前 tick の交差べき等式の Lean 必要十分版をレビューし、`N*M` 乗写像のモノイド全体での単射性は偶数乗の実数上で成り立たず、具体版を特殊化できない不備を修正した。仮定を対象の二元における局所的な単射性へ縮め、抽象証明の六段は維持した。修正を main へ反映後、本流の具体版からの導出へ進む。
- 2026-08-19 17:05: 締切内に割った先頭も閉じた。交差べき主張の Lean 必要十分版の抽象版 `cross_power_equality_implies_root_equality_abstract` を、モノイドのべき乗則と `N*M` 乗写像の単射性だけで形式化（正値性・順序・実数・可換性を落とした。build・sorry 検査 249 件通過）。次 tick は具体版を特殊化として導出し status を `Lean 必要十分版まで` へ。
- 2026-08-19 17:03: 開始が締切 8 分前。レビュー（`npm run check` 再実行、111 ブロック・210 参照）修正なし。本文未変更、PDF 再生成。本流「有限箱値の交差べき等式は極限量に対して十分である」先頭主張の Lean 必要十分版を二つへ割った：先頭は「べき乗が単射になる順序構造だけを仮定に残す抽象版 `cross_power_equality_implies_root_equality_abstract` を置けるか判断して形式化（既存の必要十分版の再利用可否も判断）」、次に「具体版の特殊化としての導出と status 更新」。次 tick は割った先頭から。並行は締切のため見送り。
- 2026-08-19 16:32: 本流「有限箱値の交差べき等式は極限量に対して十分である」の先頭主張の Lean 具体版を閉じ status `Lean 具体版まで`。`cross_power_equality_implies_posRoot_equality` で、正の乗根の $NM$ 乗を本文と同じ六段で一致させ、正の自然数乗の単射性から結論した。レビューは本文・SageMath・既存乗根補題の照合で修正なし。次 tick は Lean 必要十分版、並行は terminal graph への特殊化と分母消去。
- 2026-08-19 16:03: 本流「有限箱値の交差べき等式は極限量に対して十分である」の先頭主張の SageMath 検証を通し status `記述と SageMath まで`。check `cross-power-equality-implies-root-equality/` で乗根が正有理数の三例の証明各行・単射性の有限標本・負例検出を `QQ` で厳密確認（linkage 43 件）。レビュー（`npm run check` 再実行、111 ブロック・210 参照）修正なし。次 tick の本流は Lean 具体版、並行は terminal graph への特殊化と分母消去（締切のため見送り）。
- 2026-08-19 15:37: 本流「有限箱値の交差べき等式は極限量に対して十分である」の先頭 `claim_cross_power_equality_implies_root_equality` を本文へ記述した。$A^M=B^N$ から二つの正の乗根の $NM$ 乗を一行ずつ一致させ、正の自然数乗の単射性で乗根一致を得る。交差べき等式自体は正有理数の有限算術で判定可能。並行では一定符号の Pfaffian 有限展開から符号を括り出す `Prediction.constantSign_finiteExpansion` を Lean で形式化した。レビュー修正なし。次 tick の本流は SageMath 検証、並行は terminal graph への特殊化と分母消去。
- 2026-08-19 14:35: 本流の未完了が尽きたため、自由エネルギー密度の最小性から新標的「有限箱値の交差べき等式は極限量に対して十分である」を台帳へ追加した。正有理数値 $A_L,B_L$ と正の箱点数 $N_L,M_L$ について $A_L^{M_L}=B_L^{N_L}$ なら対応する乗根が一致するという、有限算術で判定可能かつ値の尾部一致より粗い条件である。先頭は可算側の交差べき等式から乗根一致まで、その次に箱サイズ極限への十分性へ分割した。前進前レビューでは直前の零点集合反例の Lean コメントが実数列の収束仮定を持つのに「ℝ への脱出は無い」としていた不整合を直し、修正 commit を main へ反映済み。並行の Pfaffian 予言の Lean 具体版は、一定符号の有限展開の補題と terminal graph への特殊化・分母消去へ分割した。次 tick の本流は先頭の本文記述、並行は割った先頭の形式化。
- 2026-08-19 14:05: 本流「零点集合は極限量に必要でない反例」の Lean 必要十分版を閉じ status `done`。既存の `value_invariant_does_not_determine_limit_quantity` が抽象形を担うと判断し、特殊化 `root_set_does_not_determine_limit_quantity_fromNecSuf`（値の型 `Finset ℕ`、添字写像は末尾ずらし）を導出。build・sorry 検査 247 件通過。本流のセクション表に未完了が無いので、次 tick はゴール文書から標的を引き直す。並行は締切のため見送り。
- 2026-08-19 14:03: 開始が締切 8 分前。レビュー（`npm run check` 再実行、110 ブロック・209 参照）修正なし。本文未変更、PDF 再生成。本流「零点集合は極限量に必要でない反例」の Lean 必要十分版を二つへ割った：先頭は既存の `value_invariant_does_not_determine_limit_quantity` が抽象形を担うかの判断と特殊化 `root_set_does_not_determine_limit_quantity_fromNecSuf` の導出、次に `done` へ閉じる。次 tick は割った先頭から。並行は締切のため見送り。
- 2026-08-19 13:04: 本流「零点集合は極限量に必要でない反例」の SageMath 層を閉じ status `記述と SageMath まで`。check `root-set-shifted-free-family-differs/` で $X^2+1\mid Z_2$・既約、$Z_3$ の既約因子次数 $\{1,40\}$、$\gcd(Z_3,X^2+1)=1$ を `QQ` 上で厳密判定（linkage 42 件）。レビュー（`npm run check` 再実行、110 ブロック・209 参照）修正なし。次 tick は Lean 具体版。並行は締切のため見送り。
- 2026-08-19 12:32: 本流「零点の集合は極限量に必要でない反例」を本文へ記述した。$Z_2$ は最小多項式次数 2 の零点を持つ一方、$Z'_2=Z_3$ の零点の最小多項式次数は 1 または 40 なので零点集合は異なり、末尾ずらしにより極限量は一致する。レビュー修正なし。次 tick は SageMath 検証、並行は Pfaffian 予言の Lean 具体版。
- 2026-08-19 12:03: 本流の未完了が尽きたため、ゴール文書の自由エネルギー密度についての最小性から新標的「ずらした自由族は零点の集合が極限量に必要でないことの反例」を台帳へ追加した（$L=2$ で $Z_2$ は 2 次既約因子を持つが $Z_3$ の零点の最小多項式次数は 1 か 40 のみ。極限一致は末尾ずらし）。レビュー（`npm run check` 再実行、109 ブロック・202 参照）修正なし、本文未変更。次 tick は主張ブロックの記述。並行は Pfaffian 予言の Lean 具体版（締切のため見送り）。
- 2026-08-19 11:34: 本流「有限接頭部を忘れる粗視化は十分」の Lean 必要十分版を閉じ、四層を揃えて status `done`。位相空間値の二列の尾部一致と `atTop` での収束だけを残した収束移送、Hausdorff 性だけを追加した極限一致を形式化し、実数列の具体版を特殊化へ接続した。レビュ修正なし。次 tick はゴール文書の問いから本流の次標的を引き直す。並行は Pfaffian 予言の Lean 具体版。
- 2026-08-19 11:05: 本流「有限接頭部を忘れる粗視化は十分」の Lean 具体版を閉じた（status `Lean 具体版まで`）。有限箱の値の列の尾部一致から乗根列の尾部一致を導き、一般補題 `tailAgreement_tendsto` と極限の一意性で収束の移送と極限の一致を束ねた（`TailAgreementSufficient.lean`）。レビュー（`npm run check` 再実行、109 ブロック・202 参照）修正なし。Lean build・sorry 検査 243 件通過。次 tick は Lean 必要十分版。並行は締切のため見送り。
- 2026-08-19 10:37: 本流「有限接頭部を忘れる粗視化は十分」の Lean 具体版の先頭 `tailAgreement_tendsto` を形式化した。ある添字以降で項ごとに一致する二つの実数列について、`Filter.Tendsto.congr'` で一方の収束を他方へ移す。既存の末尾ずらし補題は添字写像との合成を仮定するため直接再利用できないと判定した。並行では、2 次元境界応答多項式を Fisher terminal graph の分母消去済み Kasteleyn Pfaffian で表す全称命題を本文へ記述し、$L'=1,L=2$ の有限例を多変数整数係数多項式として再検証した。Lean build・sorry 検査 240 件、本文 check 109 ブロック・202 参照、linkage 41 件を通過。次 tick の本流は有限箱量への特殊化と十分性の束ね、並行は Pfaffian 予言の Lean 具体版。
- 2026-08-18 21:02: 開始が締切 8 分前。レビュー（`npm run check` 再実行、108 ブロック・201 参照）修正なし。本文未変更、PDF 再生成。本流「有限接頭部を忘れる粗視化は十分」の Lean 具体版を二つへ割った：先頭は「ある添字以降で項ごとに一致する二実数列の収束の合同の一般補題（既存 `TailShiftLimitAbstract` の再利用可否を判定）」、次に「有限箱量の列への特殊化と十分性の主張の束ねで Lean 具体版を閉じる」。次 tick は割った先頭から。並行は締切のため見送り。
- 2026-08-18: **公開する論文 HTML の冒頭に「進捗の要約」を出すようにした**（人間の指示）。
  正本は `docs/tasks/進捗の要約.md`（「目指していること」「済んだこと」「いま試していること」
  「次に試すこと」の四組。1 項目 1 文・数式なしの日本語）。生成器 `tools/build-html.ts` が読み、
  書式が外れたら**生成ごと失敗する**（黙って空にしない）。**毎 tick 更新する**——手順は runbook の
  「進捗の要約を更新する」で、台帳更新（実行手順の 6）と同じ場所で行う。
  本文へ進捗を混ぜない方針は維持し、冒頭の要約だけを例外とする。
- 2026-08-18 20:03: 本流「有限接頭部を忘れる粗視化は十分」の SageMath 層を閉じ、status `記述と SageMath まで`。有限接頭部だけ異なる二列と実際の $L=2$ 分配多項式評価を使い、尾部の列の項・正有理数値・有限箱量を特徴づける有限べきの等式を `ZZ[X]` と `QQ` で厳密確認した。初回失敗（$Z_1=2$ は評価点に依らない）も記録済み。レビューは本文・定義・参照先の照合と `npm run check` で修正なし。次 tick は Lean 具体版。並行はまとめ締切を優先して見送り。
- 2026-08-18 19:32: 本流の十分性の主張 `claim_tail_agreement_is_sufficient_for_limit_quantity` を記述した（尾部一致した二つの有理点の列は、一方の極限量が存在すれば他方も存在して一致する。新たな脱出なし）。これで「有限接頭部を忘れる粗視化は十分」の記述三分割（定義・同値関係・十分性）が揃い status `記述まで`。着手前レビュー（`npm run check` 再実行、107 ブロック・194 参照）修正なし。記述後 check 108 ブロック・201 参照、PDF 32 ページ。次 tick は SageMath 検証。並行はまとめ締切のため見送り。
- 2026-08-18 19:03: 前進前レビューで尾部一致の定義ブロックに同値関係の主張と証明が混在している不備を修正し、main へ反映した。そのうえで本流を定義・同値関係・極限量への十分性へ分割し、尾部一致の反射性・対称性・推移性を独立主張 `claim_tail_agreement_is_equivalence_relation` として記述した。次 tick は十分性の主張の記述。並行はまとめ締切のため見送り。
- 2026-08-18 18:36: 本流「有限接頭部を忘れる粗視化は十分」の先頭を二つへ割り、割った先頭の定義 `def_tail_equivalence_of_finite_box_sequences`（有限箱の列の尾部同値。すべて可算側）を記述した。レビュー（`npm run check` 再実行、105 ブロック・189 参照）修正なし。記述後 check 106 ブロック・190 参照、PDF 31 ページ。次 tick は十分性の主張ブロック（尾部同値な二列は極限量が存在すれば一致）の記述から。並行は締切のため見送り。
- 2026-08-18 18:02: 本流の次標的を、有限箱量の列の有限接頭部を忘れた尾部同値類が極限量に対して十分であることへ定めた。ゴール文書の自由エネルギー密度についての最小性から引き直したもので、次は「ある添字以降で二列が項ごとに一致すれば極限量が一致する」を本文の一定理として記述する。着手前レビューは直前の分配多項式値反例の本文と Lean 必要十分版を照合し、`npm run check` を再実行して修正なし。並行の Pfaffian 予言の本文記述は次 tick へ残した。
- 2026-08-18 17:39: 本流「分配多項式値は極限量に必要でない反例」の Lean 必要十分版を閉じ status `done`。既存の `value_invariant_does_not_determine_limit_quantity` が抽象形を担うと判断し、具体版を特殊化 `partition_value_does_not_determine_limit_quantity_fromNecSuf` として導出（build・sorry 検査 239 件通過）。レビュー（`npm run check` 再実行、105 ブロック・189 参照）修正なし、本文未変更、PDF 再生成。本流のセクション表に未完了が無いので、次 tick はゴール文書「極限側で問う言明」から標的を引き直す。並行は締切のため見送り。
- 2026-08-18 17:05: 本流「分配多項式値は極限量に必要でない反例」の Lean 具体版を閉じた。`partition_value_does_not_determine_limit_quantity` が有限不変量の不一致、ずらした有限箱量と元の列の末尾との項別一致、末尾ずらしによる極限量の一致を束ねる（build・sorry 検査 238 件通過）。次 tick は Lean 必要十分版。並行は締切のため見送り。
- 2026-08-18 16:35: 本流「分配多項式値は極限量に必要でない反例」の Lean 具体版の先頭、$\iota_2$ の不一致 $Z_2(1)=2^8\ne2^{27}=Z_3(1)$ を `PartitionValueInvariantDiffersAtTwo.lean` で形式化（build・sorry 検査 237 件通過）。次 tick は有限箱量の項別一致と末尾ずらし極限定理の束ねで Lean 具体版を閉じる。
- 2026-08-18 16:31: 開始が締切 7 分前。レビュー（`npm run check` 再実行、105 ブロック・189 参照）修正なし。本文未変更、PDF 再生成。本流「分配多項式値は極限量に必要でない反例」の Lean 具体版を二つへ割った：先頭は $\iota_2(Z_2)=2^8\ne2^{27}=\iota_2(Z'_2)$ の決定計算の補題（$Z_L(1)=2^{\#V_L}$ の既形式化から）、次に有限箱量の項別一致と末尾ずらし極限定理の束ね。次 tick は割った先頭から。並行は締切のため見送り。
- 2026-08-18 16:04: 本流「分配多項式値は極限量に必要でない反例」の SageMath 層を閉じた。$Z_2(1)=2^8\ne2^{27}=Z'_2(1)$ と有限箱量が $2$ になる根拠の有限べき等式を `ZZ` 上で検証し、linkage 39 件を通過。並行では $L'=1,L=2$ の terminal lattice で Kasteleyn Pfaffian の分母消去後の多項式一致を厳密検証した。次 tick は本流の Lean 具体版、並行の全称予言命題の本文記述。
- 2026-08-18 15:32: 本流の極限側の束ね `claim_shifted_free_family_partition_value_does_not_determine_limit_quantity` を記述し、「分配多項式値は極限量に必要でない」反例の主張が揃った（不変量 $\iota_L(P)=P(1)$ の $L=2$ での不一致＋末尾ずらしの極限一致の参照）。レビュー（`npm run check` 再実行）修正なし。check 105 ブロック・189 参照・linkage 38 件・PDF 31 ページ。次 tick はこの主張の SageMath 検証、並行は Kasteleyn 向き付けと分母消去後の Pfaffian 多項式一致。
- 2026-08-18 15:13: 本流の有限側 `claim_shifted_free_family_partition_values_differ_but_finite_box_quantities_agree` を記述した。$q=1,L=2$ で分配多項式値は $2^8$ と $2^{27}$ で異なるが、全 $L\ge1$ の有限箱量は両族とも $2$。次は末尾ずらしの極限一致と束ねて「必要でない」の反例を閉じる。並行では $L'=1,L=2$ の terminal lattice を有限構成し、偶部分グラフ 2 個と完全マッチング 2 個の往復写像が全単射であることを SageMath で確認した。次は Kasteleyn 向き付けと分母消去後の Pfaffian 多項式一致。
- 2026-08-18 15:06: 着手前レビューで、箱の定義だけが $L\ge2$ に限定されている一方、極限列・既存の $L=1$ 校正・台帳が $L\ge1$ を用いる不整合を確認した。$L=1$ は空の辺集合として全定義が成立するため、`def_box` の定義域を $L\ge1$ へ修正した。
- 2026-08-18 14:31: 開始が締切 8 分前。レビュー（`npm run check` 再実行、103 ブロック・177 参照）修正なし。本文未変更、PDF 再生成。本流「ずらした自由族は有限箱の分配多項式値が極限量に必要でないことの反例」の主張ブロック記述を二つへ割った：先頭は有限側（$q=1$ で `claim_partition_value_at_one` から $Z_2(1)\ne Z'_2(1)$ だが有限箱量は全 $L$ で $2$ に一致）、次に極限側の束ね（末尾ずらし定理と併せて反例の一主張へ）。次 tick は割った先頭から。並行は締切のため見送り。
- 2026-08-18 14:02: 本流の未完了が尽きたため、ゴール文書「極限側で問う言明」の自由エネルギー密度についての最小性から、新標的「ずらした自由族は有限箱の分配多項式値が極限量に必要でないことの反例」を台帳へ追加した。$q=1,L=2$ で $Z_2(1)=2^8\ne2^{27}=Z'_2(1)$ だが、正規化値と極限量は両族とも $2$。次 tick は本文の主張ブロックを記述する。レビューは既約分解型の本文・SageMath・Lean 二層を照合し、`npm run check`（103 ブロック・177 参照）で修正なし。並行の terminal lattice 有限検証は、先に $L'=1,L=2$ の polygon–dimer 全単射を有限集合で確認し、次に Kasteleyn 向き付けと分母消去後の多項式一致を確認する二件へ割った。
- 2026-08-18 13:34: 本流「既約分解の型は極限量に効かないか」の Lean 必要十分版を閉じ status `done`。`value_invariant_does_not_determine_limit_quantity`（不変量の値の不一致・フィルタを保つ添字写像・項別一致・Hausdorff 極限一意性だけ。値の型は任意）と具体版からの導出 `_fromNecSuf` を形式化（Lean build・sorry 検査 234 件）。レビューは `npm run check` 再実行（103 ブロック・177 参照）で修正なし。本流のセクション表に未完了が無いので、次 tick はゴール文書「極限側で問う言明」から標的を引き直す。並行は締切のため見送り（次は terminal lattice の有限例による Pfaffian 分母消去の SageMath 検証）。
- 2026-08-18 13:05: 本流「既約分解の型は極限量に効かないか」の Lean 具体版を閉じ `Lean 具体版まで` へ。$Z_2$ と $Z'_2=Z_3$ の因子型を次数・重複度の正規化済みリストとして置き、組 $(2,2)$ の有無による不一致を決定計算し、末尾ずらしの極限一致と束ねた `factorization_type_does_not_determine_limit_quantity` を形式化した（Lean build・sorry 検査 232 件）。レビューは本文・SageMath・linkage・`npm run check` の再実行で修正なし。次 tick は有限不変量の不一致と末尾ずらしだけを残す Lean 必要十分版と具体版からの導出。並行は締切のため見送り。
- 2026-08-18 12:36: 本流「既約分解の型は極限量に効かないか」の SageMath 層を閉じ `記述と SageMath まで` へ。linkage は 1 check 1 ラベルなので check `factorization-type-shifted-free-family-differs/` を新設し、$Z_2$ の型 $\{(1,4),(2,2),(4,1)\}$ と $Z'_2=Z_3$ の型 $\{(1,14),(40,1)\}$ の決定と非一致を `QQ` 上の厳密因数分解で確認（linkage 38 件）。レビュー（`npm run check` 再実行、103 ブロック・177 参照）修正なし。次 tick は Lean：既存の有限不変量抽象版 `finite_invariant_does_not_determine_limit_quantity` の再利用を判断して具体版を書く。並行は締切のため見送り。
- 2026-08-18 11:33: 開始が締切 8 分前。レビュー（`npm run check` 再実行、102 ブロック・214 参照）修正なし。本文未変更、PDF 再生成。本流のセクション表に未完了が無いため、ゴール文書「極限側で問う言明」の「既約分解の型は効くか」から新標的「潰れる候補: 既約分解の型は極限量に効かないか」を台帳へ追加した。ずらした自由族 $Z'_L=Z_{L+1}$ の判定枠で、$L=2$ の既約分解の型 $\{(1,4),(2,2),(4,1)\}$ と $Z_3$ の $\{(1,14),(40,1)\}$ の非一致は既存の厳密因数分解から従う。先頭の小分けは本文の主張ブロックの記述。次 tick はそこから。並行は締切のため見送り。
- 2026-08-18 11:04: 本流「Galois 群は極限量に効かないか」の Lean 必要十分版を閉じた。`GaloisGroupDoesNotDetermineLimitQuantityAbstract.lean` で、有限型の位数について $m$ が一方だけを割ること、添字写像がフィルタを保つこと、二列の項別一致、Hausdorff 空間での極限一意性だけへ抽象化し、具体版を特殊化として導出した。Lean 全体 build・未証明依存検査通過、status `done`。次 tick の本流はゴール文書の「極限側で問う言明」へ戻って標的を引き直す。並行は terminal lattice の有限例による Pfaffian 分母消去の SageMath 検証から。
- 2026-08-18 10:40: 本流「Galois 群は極限量に効かないか」の Lean 具体版を閉じた。前 tick 打ち切りの残留（可除性補題 `forty_dvd_card_galois_group_of_irreducible`）を検証・コミットした後、非同値と極限一致を束ねた `galois_group_does_not_determine_limit_quantity` を形式化（lake build・sorry 検査 229 件）。status `Lean 具体版まで`。次 tick は Lean 必要十分版（位数の一般化と `TailShiftLimitAbstract` の再利用判断）。並行は締切のため見送り。
- 2026-08-18 10:06: 本流の Lean 具体版で、既約 40 次多項式の分解体上の Galois 群が根へ推移的に作用することと軌道・固定部分群の位数公式から $40\mid\#\mathrm{Gal}(g)$ を導く `forty_dvd_card_galois_group_of_irreducible` を形式化した。次 tick はこの補題、有限位数比較、末尾ずらし極限定理を束ねて Lean 具体版を閉じる。レビュー修正なし。並行はまとめ締切のため見送り。
- 2026-08-18 09:35: 開始が締切 8 分前。レビュー（`npm run check` 再実行、102 ブロック・214 参照）修正なし。本文未変更、PDF 再生成。本流の Lean 具体版の残り（推移的作用・極限一致との束ね）を二つへ割った：先頭は「既約 40 次因子から $40\mid\#G_3$ を得る補題（mathlib の Galois 作用＋軌道数え上げを同定。閉じられなければ可除性を仮定に置く形へ後退し記録）」、次に「位数比較と末尾ずらし極限定理の束ねで Lean 具体版を閉じる」。次 tick は割った先頭から。
- 2026-08-18 09:04: 本流「Galois 群は極限量に効かないか」の Lean 具体版を「有限位数比較」と「推移的作用・極限一致との束ね」に割り、先頭 `no_equiv_of_card_four_of_forty_dvd_card` を形式化した（位数 4 と、位数が 40 の倍数である有限群は非同型。Lean build・sorry 検査 226 件通過）。次 tick は既約 40 次因子への推移的作用から $40\mid\#G_3$ を得る段を形式化し、末尾ずらし極限定理と束ねて Lean 具体版を閉じる。レビューでは台帳の誤記 $4\nmid40$ を $40\nmid4$ へ訂正し、前進前に main へ反映済み。
- 2026-08-18 08:37: 本流「Galois 群は極限量に効かないか」の SageMath 検証を通し `記述と SageMath まで` へ。check `galois-group-shifted-free-family-nonisomorphic/`：$G_2$ は位数 4・可換・非巡回（$C_2\times C_2$）、$Z_3$ の 40 次因子は既約なので $40\mid\#G_3$、$4$ は $40$ の倍数でないので非同型。対象ラベル付けと linkage（37 件）も完了。次 tick は Lean の扱いの判断と分割。
- 2026-08-18 08:31: 開始が締切 8 分前。レビュー（`npm run check` 再実行、102 ブロック・214 参照）修正なし。本文未変更、PDF 再生成。本流「Galois 群非同型主張の SageMath 検証」を二つへ割った：先頭は check `galois-group-shifted-free-family-nonisomorphic/` の新設（$G_2\cong C_2\times C_2$ の厳密決定、$Z_3$ の因数分解と 40 次因子の既約性、位数 4 が 40 の倍数でないこと）、次に対象ラベル付けと linkage。次 tick は割った先頭から。
- 2026-08-18 08:06: 本流「Galois 群は極限量に効かないか」を記述まで進めた。ずらした自由族 $Z'_L=Z_{L+1}$ について、$L=2$ で $G_2$ は位数 4、$G'_2=G_3$ は既約 40 次因子への推移的作用から位数が 40 の倍数なので非同型だが、末尾ずらしにより極限量は一致する。次はこの主張の SageMath check と対象ラベル付け。並行は Fisher 1966 原論文の terminal lattice 構成・polygon–dimer 一対一対応・辺重み・平面性を文献台帳へ記録済み。次は $v_e=(1-X_e)/(1+X_e)$ の分母を Fisher の単項式因子で消して多項式環内の Pfaffian 恒等式にできるかを判定する。
- 2026-08-18 07:36: 本流「Galois 群は極限量に効かないか」の先頭照合を完了。$Z_2$ の分解体の Galois 群は $C_2\times C_2$（位数 4、厳密決定）、$Z_3=c(x+1)^{14}g$（$g$ 既約 40 次）の群は完全決定不能だが推移性から位数が 40 の倍数。位数比較で非同型が有限判定でき、判定可能な最初の組を $L=2$（$Z_2$ 対 $Z'_2=Z_3$）に固定した。$Z_4$ は $\mathbb Z$ 上の厳密係数が無いので使わない。次 tick は本文の主張ブロックの記述、その次に SageMath check と対象ラベル付け。レビューは `npm run check` 再実行で修正なし。並行は Kasteleyn の定理の言明（Pfaffian 向き付けと $Z=|\mathrm{Pf}(A^K)|$）を Cimasoni 講義録から二次文献の格付け付きで `文献と確認状況.md` へ記録した。残りは Fisher の Ising→ダイマー構成の言明の確認。
- 2026-08-18 07:02: 本流の次の標的を、ゴール文書の未検討候補「Galois 群は極限量に効くか」から引き直した。判別式と同じずらした自由族 $Z'_L=Z_{L+1}$ を使えば極限一致は既存定理で済むため、次 tick は $Z_3,Z_4$ から Galois 群を厳密に決定できるかの照合から。レビュは `npm run check`（101 ブロック・168 参照）再実行で修正なし。
- 2026-08-18 06:34: 本流「十分性と必要でないことの判定を極限量へ具体化する（定義）」を再点検して done へ閉じた（定義の判定述語は実例側セクションの Lean 四層で形式化済み。独立の `def` は参照されない複製になるため置かない）。レビューは `npm run check` 再実行で修正なし。本文未変更。本流のセクション表に未完了が無いので、次 tick はゴール文書「極限側で問う言明」（Galois 群は極限量に効くか）から標的を引き直す。並行は Kasteleyn–Fisher 表示の一次文献照合。
- 2026-08-18 06:04: 本流「判別式が極限量に効かないことの判定」の Lean 必要十分版を閉じた。`TailShiftLimitAbstract.lean` で、添字写像が極限フィルタを保つこと・項ごとの一致・Hausdorff 空間での極限の一意性だけへ抽象化し、具体版を特殊化として導出した（lake build・sorry 検査 225 件）。並行では 2 次元偶部分グラフ和を $L'=1,L=2$ の全配位・全辺部分集合について SageMath で検証した（linkage 36 件）。レビュー修正なし。次 tick の本流はゴール文書へ戻って標的を引き直し、並行は Kasteleyn–Fisher 表示の一次文献照合。
- 2026-08-18 05:33: 本流「判別式が極限量に効かないことの判定」の Lean 具体版を閉じた。末尾ずらしの一致補題と `tendsto_tail_one` を合成した `shiftedFreeFiniteBoxQuantitySeq_tendsto`・`shiftedFreeFiniteBoxQuantitySeq_limit_eq` を `TailShiftLimit.lean` に追加（lake build・sorry 検査 222 件通過、PDF 29 ページ）。レビュー修正なし。次 tick は同セクションの Lean 必要十分版を割る。
- 2026-08-18 05:03: 本流の Lean 具体版で、ずらした自由族の有限箱量の列を定義し、元の有限箱量の列の末尾ずらしに項ごとに一致する補題を形式化した。着手前レビューは check・Lean build・未証明依存検査で修正なし。次 tick はこの等式と `tendsto_tail_one` を合成し、ずらした族の極限量の存在と一致を導く定理で Lean 具体版を閉じる。
- 2026-08-18 04:31: 開始が締切 8 分前。レビュー（`npm run check` 再実行、101 ブロック・168 参照）修正なし。本文未変更、PDF 再生成。本流の Lean 具体版の束ねを二つへ割った：先頭は「ずらした自由族の有限箱量の列が元の列の末尾ずらしに項ごとに一致する補題」、次に「`tendsto_tail_one` との合成で $\alpha'(q)=\alpha(q)$ を導き Lean 具体版を閉じる定理」。次 tick は割った先頭から。
- 2026-08-18 04:04: 本流の Lean 具体版を二段へ割り、先頭 `tendsto_tail_one`（収束する実数列の末尾を一つずらしても同じ極限へ収束）を追加した。並行では 2 次元境界応答多項式の偶部分グラフ有限和を整数多項式の等式として本文へ記述した。次 tick は本流をずらした自由族へ束ね、並行は偶部分グラフ和を SageMath で検証する。
- 2026-08-18 03:31: check `discriminant-free-vs-periodic-differ` の対象ラベルを、ずらした自由族の反例の主張 `claim_shifted_free_family_discriminant_does_not_determine_limit_quantity` へ付け替えた（overview に旧主張も同じ計算で確かめている旨を併記）。check・linkage 通過、本文未変更。次 tick は末尾をずらした列の極限一致の段の Lean 具体版を割る。
- 2026-08-18 03:08: ずらした自由族 $Z'_L:=Z_{L+1}$ が判別式は異なるが極限量は等しい反例になる主張を本文へ記述した。$\mathrm{disc}(Z_3)=0\ne\mathrm{disc}(Z_4)$ と、末尾を一つずらした列の極限一致を結んだ。check・PDF・判別式の SageMath 検証・linkage は通過。次 tick は判別式 check の対象ラベルを新しい主張へ付け替える。
- 2026-08-18 02:34: 開始が締切 8 分前。レビュー（`npm run check` 再実行）修正なし。本文未変更、PDF 再生成。todo 先頭を二つへ割った：先頭は「ずらした自由族 $Z'_L:=Z_{L+1}$ が判定枠の反例になる主張ブロックの記述（$L=3$ で $\mathrm{disc}(Z_3)=0\ne\mathrm{disc}(Z_4)$、極限一致は末尾ずらしの初等論法）」、次に「check の対象ラベル付け替え」。次 tick は主張ブロック記述から。
- 2026-08-18 02:06: 並行ストリームの Pfaffian 候補を再導出し、台帳にあった「$R^{(2)}$ は $2^{\#V}$ 倍と単項式倍で Pfaffian」という係数形を棄却した。先頭を、辺ごとの有限恒等式から得る偶部分グラフ和 $R^{(2)}=2^{\#V-\#A}\sum_{F\,\mathrm{even}}\prod_{F}(1-X_e)\prod_{A\setminus F}(1+X_e)$ の本文証明へ差し替えた。Pfaffian はこの和へ後段で適用し、一次文献の定理と照合する。
- 2026-08-18 02:03: 本流「判別式が極限量に効かないことの判定」で、法 $65537$ 上の高速層転送により $Z_4$ を 145 点から補間した。次数 144 が保たれ、$Z_4(1)=2^{64}$、$\gcd(Z_4,Z'_4)=1$ を確認したため、$\mathrm{disc}(Z_4)\ne0$ が $\mathbb Z$ 上で従う。次はずらした自由族 $Z'_L:=Z_{L+1}$ を用いる反例を本文の主張ブロックにし、check の対象ラベルを付け替える。
- 2026-08-18 01:35: 開始が締切 8 分前。レビュー（`npm run check` 再実行）修正なし。本文は変えず、$Z_4$ の係数復元を台帳で二つへ割った：先頭は法素数 $p$ 上で butterfly 核により 145 整数点を評価・Lagrange 補間して $Z_4 \bmod p$ を復元し、次数 144 の保存と $\gcd(Z_4,Z_4')=1 \pmod p$ を確認する check（一つの素数で square-free なら $\mathrm{disc}(Z_4)\ne0$ が $\mathbb Z$ で従う。全係数復元は不要）。次はその check の実装から。
- 2026-08-18 00:55: 本流「判別式が極限量に効かないことの判定」で、ずらした自由族の反例に必要な $Z_4$ へ進むため、自由境界の層転送を高速化した。層間行列 $T[s,t]=x^{\operatorname{Hamming}(s,t)}$ を密行列として作らず、$2\times2$ 行列の Kronecker 積の butterfly として整数ベクトルへ作用させる。$L=2,3$・$x=0,1,2$ で既存の密行列＋補間版の厳密多項式と一致。次はこの核による $Z_4$ の係数復元（係数ベクトルまたは法素数上の評価・補間）と square-free 判定。
- 2026-08-18: **主定理／サブ定理の身分をこのプロジェクトへ入れた**（人間の指示）。HTML 生成器が
  システム側の既定 UI（`renderers/html/theorem-standing.ts`）を使い、各章の冒頭にその章の主定理を
  列挙し、サブ定理は題名だけ見せて既定で閉じる（`details`/`summary` なので JavaScript 非依存）。
  印を付けたのは各章の到達点 18 件で、残り 24 件はサブ定理。**宣言が無ければサブ定理**なので、
  新しい主張は原則そのままにし、章の到達点になったときだけ `standing: "mainTheorem"` を付ける。
  規則は README「章の到達点だけに主定理の印を付ける」。LaTeX / PDF は印で変わらない。
- 2026-08-17 21:30: 本流「潰れる候補: 判別式」の (b) を検討。自由族×周期族の組は $\alpha(q)=\alpha^{\mathrm{per}}(q)$ 自体が未証明で挟み込みが無い。自由族をずらした組 $Z'_L:=Z_{L+1}$ は極限の一致は自明に閉じるが $\mathrm{disc}(Z_2)=\mathrm{disc}(Z_3)=0$（既知）のため反例にならず $\mathrm{disc}(Z_4)$ が要る（層転送は状態数 $2^{16}$ でこの tick 内には計算不可）。本文未変更、check・PDF は前 tick と一致。次 tick は層転送の高速化を用意して $\mathrm{disc}(Z_4)$ を計算するか、Galois 群へ標的を変える。
- 2026-08-17 20:30: 開始時点で締切まで 8 分しかなくレビューのみ実施。`npm run check`（99 ブロック・163 参照）・`npm run build:pdf`（28 ページ）を再実行し前 tick から不一致なしを確認。修正・前進なし。次 tick は (b)（$\alpha(q)=\alpha^{\mathrm{per}}(q)$ を健全性の橋へ割れるか）または並行 (1)（Pfaffian 表示の候補命題を本文へ）。
- 2026-08-17 19:30: 本流「潰れる候補: 判別式」の (a) を本文の主張 `claim_discriminant_free_vs_periodic_differ_at_L3`（$L=3$ で $\mathrm{disc}(Z_3)=0\ne\mathrm{disc}(Z^{\mathrm{per}}_3)$、$L=2$ は一致）として閉じ、check `discriminant-free-vs-periodic-differ` の対象ラベルを付け替えた。check 99 ブロック・163 参照、PDF 28 ページ、linkage 35 件。次 tick は (b)（極限量の一致を健全性の橋の定理へ割れるか）。
- 2026-08-17 19:00: 本流「潰れる候補: 判別式」の (a) の先頭を進めた。共通 sage 定義に箱の分配多項式（自由・周期、列挙版と層転送＋補間版）を追加し、check `discriminant-free-vs-periodic-differ` を置いた。**$L=2$ は $Z^{\mathrm{per}}_2(x)=Z_2(x^2)$ で判別式が一致（両方 $0$）**、$L=3$ は $\mathrm{disc}(Z_3)=0\ne\mathrm{disc}(Z^{\mathrm{per}}_3)$ で不一致（約 5 分）。本文未変更。次 tick は $L=3$ の不一致を主張ブロックとして本文へ書き、check の対象ラベルを付け替える。
- 2026-08-17 18:30: 開始が締切 8 分前。レビュー（check・build:pdf 再実行）修正なし。本文は変えず、(a) を台帳でさらに割った：先頭は共通 sage 定義に自由・周期境界の小箱の分配多項式を返す関数を追加し $L=2,3$ で判別式の不一致を check で確認、次に本文の主張ブロック。次 tick はこの先頭から。
- 2026-08-17 18:00: 開始が締切 8 分前。レビュー修正なし。本文は変えず、「潰れる候補: 判別式は極限量に効かない、を判定できる形に定義する」の残りを台帳で二つに割った：(a) 二つ目の族＝周期族 $Z^{\mathrm{per}}_L$（`def_periodic_multiplicity` から作る）で判別式が異なる $L$ の存在を有限計算の主張＋SageMath で閉じる、(b) $\alpha(q)=\alpha^{\mathrm{per}}(q)$ は極限側の言明で有限計算では判定できないので健全性の橋の定理として有限箱側の挟み込みへ割れるか検討。次 tick は (a) から。
- 2026-08-17 17:30: 開始が締切 8 分前。レビュー修正なし。「潰れる候補: 判別式は極限量に効かない、を判定できる形に定義する」の先頭の定義 `def_constant_coarse_graining_from_q_independent_invariant` を記述（$q$ に依らない不変量の列が定める定数粗視化は既存の粗視化の定義に適合するが判定が退化する——十分性は $\alpha$ が定数であることと同値、必要でないことは成立不能——ので、判定枠を「二つの分配多項式の族の組で、ある $q,L$ で $\iota_L(Z_L)\ne\iota_L(Z'_L)$ かつ $\alpha(q)=\alpha'(q)$」へ置き直した）。check 98 ブロック・160 参照、PDF 27 ページ。次は二つ目の族の選定（周期境界か 2 次元か）と判別式が異なる $L$ の有限計算の主張。
- 2026-08-17 17:00: 開始が締切 8 分前。レビュー修正なし。本流に未完了が無いので、`可算コアの同定とは何か.md` の「極限側で問う言明」（判別式・Galois 群は極限量に効くか＝未検討）と「最初の三手」の三手目から標的を引き直し、本流の新セクション「潰れる候補: 判別式は極限量に効かない、を判定できる形に定義する」を台帳へ追加した（先頭は定義だけ。本文は未変更）。次の tick はその定義ブロックを本文へ書く。
- 2026-08-17 16:30: 開始が締切 8 分前。レビュー（`npm run check` 97 ブロック・154 参照）修正なし。「極限量に対して必要でない粗視化を一つ同定する」を、割った 2 つが四層で揃ったことを確認して `done` に閉じた。**本流のセクション表に未完了が無い。** 次の tick は小主張を自作せず、`可算コアの同定とは何か.md` の「最初の三手」「極限側で問う言明」「否定判定」から標的を引き直して台帳へ書く。並行ストリーム「2 次元の閉形式から代数的命題を 1 つ導く」は todo のまま。
- 2026-08-17 16:00: 開始が締切 8 分前。レビュー修正なし。「対称化した極限量に対して粗視化は必要でない」の Lean 必要十分版 `SymmetrizedNoCoarseningAbstract.lean`（`symmetrized_no_coarsening_abstract`：任意の非負係数・次数 $\ge1$・最高次係数正の $f\in\mathbb Q[X]$ と項ごとに等しい二実数列。sorry 検査 218 件）。セクションを **完了** に。次はセクション表の次の未完了、無ければ「最初の三手」から引き直す。
- 2026-08-17 15:30: 開始が締切 8 分前。レビュー修正なし。「対称化した極限量に対して粗視化は必要でない」の Lean 具体版を束ねた `NullModelSymmetrizedNoCoarsening.lean`（`nullModel_symmetrized_no_coarsening`）で主張全体が揃い `Lean 具体版まで` へ。lake build・sorry 検査 217 件通過。次は同主張の Lean 必要十分版。
- 2026-08-17 15:00: 開始が締切 8 分前。レビュー修正なし。「対称化した極限量に対して粗視化は必要でない」の $Z_L(q)\neq Z_L(1/q)$ を零モデルで閉じた `NullModelEvalNeInv.lean`（`one_le_card_edge`・`nullModel_eval_polyOfMultiplicity_ne_eval_inv`）。lake build・sorry 検査 216 件通過。次は実数側の第 2 段とこれを 1 定理に束ねて `Lean 具体版まで` へ。
- 2026-08-17 14:30: 開始が締切 8 分前。レビュー修正なし。「対称化した極限量に対して粗視化は必要でない」の $Z_L(q)\neq Z_L(1/q)$ の準備として三前提を束ねた `eval_polyOfMultiplicity_ne_eval_inv`（`PolyOfMultiplicityEvalNeInv.lean`）を通した。lake build・sorry 検査 214 件通過。次は零モデルで $\Omega(\#E_L)\ge1$ を示して適用し `Lean 具体版まで` へ。
- 2026-08-17 14:00: 開始が締切 8 分前。レビュー修正なし。「対称化した極限量に対して粗視化は必要でない」の $Z_L(q)\neq Z_L(1/q)$ の準備として次数 $\ge1$・最高次係数 $>0$（`PolyOfMultiplicityDegree.lean`、仮定 $E\ge1$・$\Omega(E)\neq0$）を通した。lake build・sorry 検査 213 件通過。次は零モデルで $\Omega(\#E_L)\ge1$ を示し三前提を束ねて `eval_ne_eval_inv_of_nonneg_coeff` を適用、`Lean 具体版まで` へ。
- 2026-08-17 13:30: 開始が締切 8 分前。レビュー修正なし。「対称化した極限量に対して粗視化は必要でない」の $Z_L(q)\neq Z_L(1/q)$ の準備として係数非負 `coeff_polyOfMultiplicity_nonneg`（`PolyOfMultiplicityCoeffNonneg.lean`）を通した。lake build・sorry 検査 209 件通過。次は次数 $\ge1$・最高次係数 $>0$ を零モデルで示し `eval_ne_eval_inv_of_nonneg_coeff` を適用して `Lean 具体版まで` へ。
- 2026-08-17 13:00: 開始が締切 8 分前。レビュー修正なし。「対称化した極限量に対して粗視化は必要でない」の Lean 具体版・実数側の第 2 段 `SymmetrizedRealSeqReciprocalInvariantNullModel.lean`（列に束ねて極限の同値・一致）を通した。lake build・sorry 検査 208 件通過。status は `SageMath まで` のまま。次は $Z_L(q)\neq Z_L(1/q)$ の零モデル適用（`eval_ne_eval_inv_of_nonneg_coeff`）と束ねて `Lean 具体版まで` へ。
- 2026-08-17 12:30: 開始が締切 8 分前。レビュー修正なし。「対称化した極限量に対して粗視化は必要でない」の Lean 具体版・実数側の第 1 段 `SymmetrizedRealTermReciprocalInvariantNullModel.lean`（`nullModel_symmetrized_real_term_reciprocal_invariant`：可算側の等式を ℝ へ写し実指数 $s$ 乗も一致）を通した。lake build・sorry 検査 206 件通過。status は `SageMath まで` のまま。次は $\tilde a_L$ の定義に合わせて極限の一意性へ渡し、$Z_L(q)\neq Z_L(1/q)$ と束ねて `Lean 具体版まで` へ。
- 2026-08-17 12:00: 開始が締切 8 分前。レビュー修正なし。「対称化した極限量に対して粗視化は必要でない」の Lean 具体版を可算側と実数側へ割り、可算側 `SymmetrizedValueReciprocalInvariantNullModel.lean`（`nullModel_symmetrized_value_reciprocal_invariant`：$Z_L(q)^2/q^{\#E_L}$ が $q\leftrightarrow1/q$ で一致、$\mathbb Q$ の等式）を通した。lake build・sorry 検査 205 件通過。次は実数側（極限の一意性との合成）と $Z_L(q)\neq Z_L(1/q)$ を束ねて `Lean 具体版まで` へ。
- 2026-08-17 11:30: 開始が締切 8 分前。レビュー修正なし。「対称化した極限量に対して粗視化は必要でない」の主張 `claim_coarse_graining_not_necessary_for_symmetrized_limit_quantity` の SageMath 検証を通した（`sagemath/check/coarse-graining-not-necessary-for-symmetrized-limit-quantity/`、$L=2$・有理点 6 点。$L=3$ は $2^{27}$ 配位のため含めず。linkage 34 件）。status `SageMath まで`。次は Lean 具体版（回文対称化の Lean と極限の一意性の合成）。
- 2026-08-17 10:30: 開始が締切 8 分前。レビュー修正なし。「対称化した極限量に対して粗視化 $q\mapsto\varepsilon_{L,q}(\mathcal Z_L)$ は必要でない」を定義と主張の 2 つへ割り、先頭の定義 `def_symmetrized_limit_quantity`（$\tilde S_q=(L\mapsto(\#V_L,\sigma_L(q)))$、$\tilde a_L(q)=(Z_L(q)^2/q^{\#E_L})^{1/(2\#V_L)}$、$\tilde\alpha(q)=\lim\tilde a_L(q)$）を記述。check 96 ブロック・149 参照、build:pdf 27 ページ。次は後半の主張「$q\neq1$ で $Z_L(q)\neq Z_L(1/q)$ かつ $\tilde\alpha(q)=\tilde\alpha(1/q)$」を記述から。
- 2026-08-17 09:30: 開始が締切 8 分前。レビュー修正なし。「対称化した列は $q\leftrightarrow1/q$ で不変である」の Lean 具体版を零モデル $Z_L$ で完成 `SymmetrizedReciprocalInvariantNullModel.lean`（`eval_polyOfMultiplicity_pos`・`nullModel_symmetrized_padicValRat_reciprocal_invariant`。sorry 検査 202 件。status `Lean 具体版まで`）。次は Lean 必要十分版（`NecSuf/` に一般の回文多項式版を置き零モデル版を導出）。
- 2026-08-17 09:15: 開始が締切 8 分前。レビュー修正なし。「対称化した列は $q\leftrightarrow1/q$ で不変である」の $Z_L$ への特殊化 `SymmetrizedReciprocalInvariantSpecialized.lean`（零モデル・構造コアの分配多項式の `reflect` 不変と次数 $\le E$。sorry 検査 200 件）。次は束ね定理に渡して $Z_L(1/q)\neq0$ を足し `Lean 具体版まで` へ。
- 2026-08-17 09:00: 開始が締切 8 分前。レビュー修正なし。「対称化した列は $q\leftrightarrow1/q$ で不変である」の橋渡し続き `SymmetrizedReciprocalInvariantPolyOfMultiplicity.lean`（`polyOfMultiplicity E Ω` の係数確定と、`Ω` の回文性から `reflect E f = f`。sorry 検査 197 件）。次は `Ω := multiplicity S` で特殊化し束ねて `Lean 具体版まで` へ。
- 2026-08-17 08:45: 開始が締切 8 分前。レビュー修正なし。「対称化した列は $q\leftrightarrow1/q$ で不変である」の $Z_L$ 特殊化への橋渡し `SymmetrizedReciprocalInvariantReflectOfCoeff.lean`（`reflect_eq_of_coeff_palindrome`：係数の回文性から `reflect E f = f`。次数仮定不要。sorry 検査 195 件）。次は `multiplicity_palindrome` を係数の等式へ翻訳し $f=Z_L$ に特殊化して `Lean 具体版まで` へ。
- 2026-08-17 08:30: 開始が締切 8 分前。レビュー修正なし。「対称化した列は $q\leftrightarrow1/q$ で不変である」の Lean 具体版・第一〜第三歩の束ね `SymmetrizedReciprocalInvariantBundle.lean`（`symmetrized_padicValRat_eval_reciprocal_invariant`、一般の多項式 $f$。sorry 検査 194 件）。次は $f=Z_L$・$E=\#E_L$ へ特殊化して `Lean 具体版まで` へ。
- 2026-08-17 08:15: 開始が締切 8 分前。レビュー修正なし。「対称化した列は $q\leftrightarrow1/q$ で不変である」の Lean 具体版・第四歩の橋渡し `SymmetrizedReciprocalInvariantStepFourEval.lean`（`eval_strictMono_of_nonneg_coeff`・`eval_ne_eval_inv_of_nonneg_coeff`：`Polynomial.eval_eq_sum_range` で係数和へ移し前半・後半を束ねた。sorry 検査 193 件）。次は第一〜第四歩を $Z_L$ について一つの定理に束ねて `Lean 具体版まで` へ。
- 2026-08-17 08:00: 開始が締切 8 分前。レビュー修正なし。「対称化した列は $q\leftrightarrow1/q$ で不変である」の Lean 具体版・第四歩後半 `SymmetrizedReciprocalInvariantStepFourMonotone.lean`（`strictMono_sum_of_nonneg_coeff`：非負係数・正の最高次係数・次数 $\ge1$ の係数和が $(0,\infty)$ 上で狭義単調増加。sorry 検査 191 件）。次は `Polynomial.eval_eq_sum_range` で橋渡しして四歩を束ね、`Lean 具体版まで` へ。
- 2026-08-17 07:45: 開始が締切 8 分前。レビュー修正なし。「対称化した列は $q\leftrightarrow1/q$ で不変である」の Lean 具体版・第四歩前半 `SymmetrizedReciprocalInvariantStepFour.lean`（`ne_eval_inv_of_strictMonoOn`：狭義単調性から $Z_L(q)\neq Z_L(1/q)$。sorry 検査 190 件）。次は後半（非負係数・正の最高次係数・次数 $\ge1$ から狭義単調性）`…StepFourMonotone.lean`、その次に束ねて `Lean 具体版まで`。
- 2026-08-17 07:30: 開始が締切 8 分前。レビュー修正なし。「対称化した列は $q\leftrightarrow1/q$ で不変である」の Lean 具体版・第一歩 `SymmetrizedReciprocalInvariantStepOne.lean`（`eval_eq_pow_mul_eval_inv_of_reflect_eq`、mathlib `eval₂_reflect_mul_pow` のみ。sorry 検査 189 件）。次は第四の $Z_L(q)\neq Z_L(1/q)$ と束ねを書いて `Lean 具体版まで` へ上げる。
- 2026-08-17 07:15: 開始が締切 8 分前。レビュー修正なし。「対称化した列は $q\leftrightarrow1/q$ で不変である」の Lean 具体版・第二歩 `SymmetrizedReciprocalInvariantStepTwo.lean`（`padicValRat_of_pow_mul`。sorry 検査 188 件）。次は第一歩（回文性の $X=q$ 代入）と $Z_L(q)\neq Z_L(1/q)$ の段を Lean で書き具体版を揃える。
- 2026-08-17 07:00: 開始が締切 8 分前。レビューは `lake build`・sorry 検査（185 件）再実行で修正なし。「対称化した列は $q\leftrightarrow1/q$ で不変である」の Lean 具体版・第三歩 `SymmetrizedReciprocalInvariantStepThree.lean`（`symmetrized_eq_of_palindrome_step`・`symmetrized_padicValRat_reciprocal_invariant`。sorry 検査 187 件）。次は第一・第二歩と $Z_L(q)\neq Z_L(1/q)$ の段を Lean で書き具体版を揃える。
- 2026-08-17 06:30: 開始が締切 8 分前。レビューは同期確認のみで修正なし。「粗視化 $q\mapsto\varepsilon_{L,q}(\mathcal Z_L)$ は極限量に対して十分である」の Lean 必要十分版 `PartitionValueCoarseGrainingSufficientAbstract.lean`（`coarseGraining_eq_of_data_eq`・`limitQuantity_tendsto_of_coarseGraining_eq`・`limitQuantity_eq_of_coarseGraining_eq`。`lake build` 通過、sorry 検査 185 件 OK。四層が揃い status `done`）。次は本流の次「極限量に対して必要でない粗視化を一つ同定する」（todo）。
- 2026-08-17 06:17: 開始が締切 8 分前。レビューは同期確認のみで修正なし。「粗視化 $q\mapsto\varepsilon_{L,q}(\mathcal Z_L)$ は極限量に対して十分である」の Lean 具体版 `PartitionValueCoarseGrainingSufficient.lean`（`partitionValueCoarseGraining`・`partitionValueCoarseGraining_eq_of_prime_exponents_eq`・`limitQuantity_eq_of_partitionValueCoarseGraining_eq`。`lake build` 通過、sorry 検査 182 件 OK。status `記述・SageMath・Lean 具体版まで`）。次は同セクションの Lean 必要十分版（`limitQuantity_eq_of_data_eq` からの導出）。
- 2026-08-17 06:03: 並行「2 次元での対応物を書き下す」を記述（`def_two_dimensional_boundary_response_polynomial`。check 94 ブロック・139 参照、build:pdf 26 ページ）。次の並行は「閉形式から代数的命題を 1 つ導く」。
- 2026-08-17 06:00: 開始が締切 8 分前。レビューは `npm run check`（92 ブロック）再実行で修正なし。「粗視化 $q\mapsto\varepsilon_{L,q}(\mathcal Z_L)$ は極限量に対して十分である」を SageMath で検証（`sagemath/check/partition-value-coarse-graining-is-sufficient-for-limit-quantity/`、$L=1,2$・有理点 6 点 PASS、linkage 32 件。status `記述と SageMath まで`）。次は同セクションの Lean 具体版（粗視化であることは `rat_eq_of_prime_exponents_eq` 再利用、十分性は既存 2 定理の合成）。
- 2026-08-17 05:45: 開始が締切 8 分前。レビューは `npm run check`（91 ブロック）再実行で修正なし。「粗視化 $q\mapsto\varepsilon_{L,q}(\mathcal Z_L)$ は極限量に対して十分である」を記述（`claim_partition_value_coarse_graining_is_sufficient_for_limit_quantity`：$\pi_L(q)=Z_L(q)$ が $\lambda(Z_L(q))$ から決定可能に復元されるので粗視化であること、値の一致 ⇒ $Z_L$ の等式 ⇒ 極限量の等式の合成で十分性）。check 92 ブロック・137 参照、build:pdf 通過。次は同セクションの SageMath 検証か Lean 具体版。
- 2026-08-17 05:31: 開始が締切 8 分前。レビューは `npm run check`（91 ブロック・相互参照 128 件）再実行で修正なし。「十分性と必要でないことの判定を極限量へ具体化する」を定義・十分性の実例・必要でないことの実例の 3 つへ割り、先頭の定義 `def_coarse_graining_sufficient_and_not_necessary_for_limit_quantity` を記述（有理点における粗視化＝列 $S_q$ の第 $L$ 項から決定可能に定まる写像の族、$\alpha$ が存在する有理点の集合上で十分／必要でないを判定。実数の等式は $\alpha$ の等式だけ）。check・build:pdf 通過。次は「粗視化 $q\mapsto\varepsilon_{L,q}(\mathcal Z_L)$ は極限量に対して十分である」を記述から。
- 2026-08-17 05:17: 開始が締切 8 分前。レビューは sorry 検査（180 件）再実行で修正なし。本流の先頭未完了「有限の主張から極限量の言明へ渡す定理」を再点検し、割った 2 つが四層で済んでいて後者（有限箱の等式の族の移送）が求める定理そのものなので残余なしと判定して done にした（本文・Lean 変更なし）。次は「十分性と必要でないことの判定を極限量へ具体化する」（記述から）。
- 2026-08-17 05:00: 開始が締切 8 分前。レビューは `lake build`・sorry 検査（178 件）再実行で修正なし。「有限箱の等式の族は極限量の等式へ渡る」の Lean 必要十分版 `FiniteBoxEqualitiesTransferAbstract.lean`（`limitQuantity_tendsto_of_family_eq`・`limitQuantity_eq_of_family_eq`。既存の必要十分版で $D:=X$、$D_q:=Z_q$ と置いた特殊化）。sorry 検査 180 件 OK。status `四層すべて`、セクション完了。次は表の先頭未完了「有限の主張から極限量の言明へ渡す定理」の再点検（残余が無ければ done）。
- 2026-08-17 04:45: 開始が締切 8 分前。レビューは `lake build`・sorry 検査（175 件）再実行で修正なし。「有限箱の等式の族は極限量の等式へ渡る」の Lean 具体版・極限の段の束ねを `FiniteBoxEqualitiesTransfer.lean` に追記（`finiteBoxValueSeq q`（添字を 1 ずらし実数へ埋め込む）、`finiteBoxValueSeq_eq_of_eq`、`limitQuantity_tendsto_of_finiteBox_eq`、`limitQuantity_eq_of_finiteBox_eq`。既存の束ねへ帰着。脱出は `atTop` の極限だけ）。sorry 検査へ登録、`lake build` 通過、sorry 検査 178 件 OK。status を `Lean 具体版まで` へ。次はこのセクションの Lean 必要十分版（`LimitQuantityDeterminedBySequenceAbstract` へ帰着）。
- 2026-08-17 04:30: 開始が締切 8 分前。レビューは sorry 検査（174 件）再実行で修正なし。本流の先頭未完了「有限箱の等式の族は極限量の等式へ渡る」の Lean 具体版・可算側の段 `lean/Ising3DCut/LimitQuantity/FiniteBoxEqualitiesTransfer.lean`（等式 $Z_L(q)=Z_L(q^\prime)$ から各素数での $p$ 進付値の一致 `prime_exponent_sequence_eq_of_partitionPolynomial_evalAtRational_eq`）を形式化。入口・sorry 検査へ登録、`lake build` 通過、sorry 検査 175 件 OK。status は `記述と SageMath まで`（Lean 具体版は途中）。次は極限の段の束ね（`limitQuantity_tendsto_of_pointwise_eq` へ帰着）を書いて `Lean 具体版まで` へ上げる。
- 2026-08-17 04:15: 開始が締切 8 分前。レビューは `lake build`・sorry 検査（171 件）再実行で修正なし。本流の先頭「極限量が有限箱の列だけの関数であること」の Lean 必要十分版を `lean/Ising3DCut/LimitQuantity/LimitQuantityDeterminedBySequenceAbstract.lean`（`tendsto_congr_of_pointwise_eq`・`limitQuantity_tendsto_of_data_eq`・`limitQuantity_eq_of_data_eq`。仮定は「値の列がデータの列で決まる」と位相空間・フィルタ（一致には Hausdorff・NeBot）だけ）として形式化。入口・sorry 検査へ登録、`lake build` 通過、sorry 検査 174 件 OK。status を `四層すべて` へ。次は本流の次セクションを表から選ぶ（無ければ「可算コアの同定とは何か」の「最初の三手」から標的を引き直す）。
- 2026-08-17 04:00: 開始が締切 8 分前。レビューは `lake build`・sorry 検査（168 件）再実行で修正なし。本流の先頭「極限量が有限箱の列だけの関数であること」の Lean 具体版・束ねの段を `lean/Ising3DCut/LimitQuantity/LimitQuantityDeterminedBySequence.lean`（乗根列 `rootSeq`、`rootSeq_eq_of_pointwise_eq`・`limitQuantity_tendsto_of_pointwise_eq`・`limitQuantity_eq_of_pointwise_eq`。唯一の ℝ 脱出は最後の `Tendsto`）として形式化。入口・sorry 検査へ登録、`lake build` 通過、sorry 検査 171 件 OK。Lean 具体版が揃い status を `Lean 具体版まで` へ上げた。次は Lean 必要十分版か本流の次セクションを台帳の表で判断。
- 2026-08-17 03:45: 開始が締切 8 分前。レビューは `lake build`・sorry 検査（164 件）再実行で修正なし。本流の先頭「極限量が有限箱の列だけの関数であること」の Lean 具体版・中段「正の実数乗根の一意性」を `lean/Ising3DCut/LimitQuantity/PositiveRealRootUnique.lean`（`posRoot`・`posRoot_pos`・`posRoot_pow`・`eq_posRoot_of_pow_eq`・`posRoot_congr`）として形式化。入口・sorry 検査へ登録、`lake build` 通過、sorry 検査 168 件 OK。残りは三段の束ね。揃えば status を `Lean 具体版まで` へ。
- 2026-08-17 03:30: 開始が締切 8 分前。レビューは `lake build`・sorry 検査（161 件）再実行で修正なし。本流の先頭「極限量が有限箱の列だけの関数であること」の Lean 具体版・実数側の段（唯一の ℝ 脱出）を `lean/Ising3DCut/LimitQuantity/RealLimitOfEqualSequences.lean`（`tendsto_iff_of_pointwise_eq`・`limit_unique`・`limit_eq_of_pointwise_eq`。`Filter.Tendsto` で書き、可算側からは項ごとの等式だけを受け取る）として形式化。入口・sorry 検査へ登録、`lake build` 通過、sorry 検査 164 件 OK。残りは「正の実数乗根の一意性」の段と三段の束ね。揃えば status を `Lean 具体版まで` へ。
- 2026-08-17 03:15: 開始が締切 8 分前。レビューは `lake build`・sorry 検査（160 件）再実行で修正なし。本流の先頭「極限量が有限箱の列だけの関数であること」の Lean 具体版・第三歩の補足「$\#V_L$ は $q$ に依らず $L^3$」を `lean/Ising3DCut/LimitQuantity/SiteCountIndependentOfQ.lean` の `card_site` として形式化。入口・sorry 検査へ登録、`lake build` 通過、sorry 検査 161 件 OK。次は Lean 具体版の実数側の段の扱い（`Filter.Tendsto` で書くか概要のみか）を決め、status を `Lean 具体版まで` へ。
- 2026-08-17 03:00: 開始が締切 8 分前。レビューは `lake build`・sorry 検査（159 件）再実行で修正なし。本流の先頭「極限量が有限箱の列だけの関数であること」の Lean 具体版・第三歩の後半（列の素指数データが各 $L\ge1$ で一致 ⇒ $Z_L(q)=Z_L(q')$ 全 $L\ge1$）を `lean/Ising3DCut/LimitQuantity/PartitionValuesAgreeFromSequence.lean` の `partitionPolynomial_evalAtRational_eq_of_prime_exponent_sequence_eq` として形式化（正値性＋第二歩）。入口・sorry 検査へ登録、`lake build` 通過、sorry 検査 160 件 OK。可算側の三歩が揃った。次は Lean 具体版の残り（実数側の段の扱いを決め、status を `Lean 具体版まで` へ）。
- 2026-08-17 02:45: 開始が締切 8 分前。レビューは `lake build`・sorry 検査（158 件）再実行で修正なし。本流の先頭「極限量が有限箱の列だけの関数であること」の Lean 具体版・第三歩の前半「$L>0$・$q>0$ なら $Z_L(q)>0$」を `lean/Ising3DCut/LimitQuantity/PartitionValuePositive.lean` の `partitionPolynomial_evalAtRational_pos` として形式化（各項非負・$m=0$ 項が $\Omega_L(0)\ge2$、`Finset.sum_pos'`）。入口・sorry 検査へ登録、`lake build` 通過、sorry 検査 159 件 OK。次は第三歩の後半（列の各成分の一致＋正値性に第二歩を当てて $Z_L(q)=Z_L(q')$ を全 $L$ で）。
- 2026-08-17 02:15: 開始が締切 8 分前。レビューで台帳のセクション表の連結行（`||`）を分割して先にコミット・push。本流の先頭「極限量が有限箱の列だけの関数であること」の Lean 具体版（可算側の段）を三歩（正の自然数が素指数データで決まる／正の有理数が素指数データで決まる／列の一致から $Z_L(q)=Z_L(q')$）に割り、先頭 `lean/Ising3DCut/LimitQuantity/PrimeExponentDataDeterminesNat.lean` の `nat_eq_of_prime_exponents_eq`（`Nat.eq_of_factorization_eq` に帰着）を形式化。入口・sorry 検査へ登録、`lake build` 通過、sorry 検査 157 件 OK。次は第二歩（正の有理数、`padicValRat` か分子・分母の `factorization`）。
- 2026-08-17 02:00: 開始が締切 8 分前。レビューは Lean `lake build`・sorry 検査（152 件）再実行のみ（不一致なし）。「粗視化の値の一致から $Z_L$ の等式へ」の Lean 必要十分版（`lean/Ising3DCut/NecSuf/CoarseGrainingValuesAgree.lean`：環構造も多項式環も置かず、写像の合成 $e=v\circ\kappa$ と一点の値 $\kappa(z)=Z$ だけの主張 `apply_eq_of_eq_comp`・`values_eq_of_comp_values_eq`）と導出（`CoarseGrainingValuesAgreeFromNecSuf.lean`、`Config L`・`ℤ`・`ℚ` へ特殊化）で四層が揃い status `done`。sorry 検査 156 件。次は本流の次の標的を「可算コアの同定とは何か」の「最初の三手」「極限側で問う言明」から引き直す（主標的表の本流に未完了が無いか先に確認）。
- 2026-08-17 01:45: 開始が締切 8 分前。レビューは Lean `lake build`・sorry 検査再実行のみ（不一致なし）。「粗視化の値の一致から $Z_L$ の等式へ」の Lean 具体版の第二歩（`lean/Ising3DCut/CoarseGrainingValuesAgreeStepTwo.lean`：`Config L` で $\varepsilon_{L,q}(\mathcal Z_L)=Z_L(q)$ を第一歩と $\kappa_L(\mathcal Z_L)=Z_L(X)$ の合成で示し、値の一致⇒$Z_L(q)=Z_L(q')$ を導出。sorry 検査 152 件）。status `SageMath まで`→`Lean 具体版まで`。次は Lean 必要十分版（可換環 $R$・任意の環準同型の合成へ一般化し具体版へ特殊化）。
- 2026-08-17 01:30: 開始が締切 8 分前。レビューは Lean `lake build`・sorry 検査（150 件）再実行のみ（不一致なし）。「粗視化の値の一致から $Z_L$ の等式へ」の Lean 具体版の第一歩（`lean/Ising3DCut/CoarseGrainingValuesAgree.lean`：$\varepsilon_{L,q}$・$\mathrm{ev}_q$ を定義し $\varepsilon_{L,q}=\mathrm{ev}_q\circ\kappa_L$ を普遍性で証明。入口・sorry 検査へ登録）。次は第二歩 $\varepsilon_{L,q}(\mathcal Z_L)=Z_L(q)$ と値の一致⇒等式を `Config L` で書く。
- 2026-08-17 01:15: 開始が締切 8 分前。レビューは `npm run check`（90 ブロック・126 参照）再実行のみ（不一致なし）。「粗視化の値の一致から $Z_L$ の等式へ」の SageMath 検証を書いて PASS（`sagemath/check/coarse-graining-values-agree-implies-partition-values-agree/`：$L=1,2$ × 有理点 5 点で $\varepsilon_{L,q}=\mathrm{ev}_q\circ\kappa_L$、$\varepsilon_{L,q}(\mathcal Z_L)=Z_L(q)$、含意を厳密検査。linkage 31 件）。status `記述まで` → `SageMath まで`。次は Lean 具体版。
- 2026-08-17 01:00: 開始が締切 8 分前。レビューは `npm run check`（89 ブロック・122 参照）再実行のみ（不一致なし）。本流の先頭「粗視化の値の一致から $Z_L$ の等式へ」を記述した（`claim_coarse_graining_values_agree_implies_partition_values_agree`。$\varepsilon_{L,q}=\mathrm{ev}_q\circ\kappa_L$ を普遍性で置き $Z_L(q)=\varepsilon_{L,q}(\mathcal Z_L)$ の一続きの式変形。status `todo`→`記述まで`。check 90 ブロック・126 参照）。次は同セクションの SageMath 検証（$L=1,2$・有理点数点で厳密比較）。
- 2026-08-17 00:45: 開始が締切 8 分前。レビューは `npm run check`（89 ブロック・122 参照）再実行のみ（不一致なし）。「全辺変数を一つの不定元へ置くと自由境界の分配多項式になる」の Lean 必要十分版の合成（`NecSuf.allEdgesToOneIndeterminate_multivariatePartitionPolynomial_eq_sum_levelSet_card_smul`）と `ℤ`・`Config L` への特殊化（`..._eq_partitionPolynomial_fromNecSuf`）で四層が揃い status `done`。`lake build` 成功、sorry 検査 149 件。次は本流の次「粗視化の値の一致から $Z_L$ の等式へ」の記述。
- 2026-08-17 00:30: 開始が締切 8 分前。レビューは `npm run check`（89 ブロック・122 参照）・linkage 検査（30 件）再実行のみ（不一致なし）。「全辺変数を一つの不定元へ置くと自由境界の分配多項式になる」の Lean 必要十分版の第二歩：`lean/Ising3DCut/NecSuf/AllEdgeVariablesToOneIndeterminateStepTwo.lean` の `NecSuf.sum_X_pow_eq_sum_levelSet_card_smul`（有限型上の任意の $f:\Sigma\to\mathbb N$ と上界 $N$ で $\sum_\sigma X^{f(\sigma)}=\sum_{m\le N}\#f^{-1}(m)\cdot X^m$、可換半環係数）。`lake build` 成功、sorry 検査 147 件。次は必要十分版の合成と `ℤ`・`Config L` への特殊化（具体版との一致）。
- 2026-08-17 00:15: 開始が締切 8 分前。レビューは `npm run check`（89 ブロック・122 参照）・linkage 検査（30 件）再実行のみ（不一致なし）。「全辺変数を一つの不定元へ置くと自由境界の分配多項式になる」の Lean 必要十分版の第一歩：`lean/Ising3DCut/NecSuf/AllEdgeVariablesToOneIndeterminate.lean`（可換半環 `R`、`Fintype Edge`・`DecidableEq Edge` 不要）と `AllEdgeVariablesToOneIndeterminateFromNecSuf.lean`（`R := ℤ` 特殊化。`Fintype Configuration` だけで導出）。`lake build` 成功、sorry 検査 146 件。次は第二歩（水準集合の束ね）と合成の必要十分版。
- 2026-08-17 00:00: 開始が締切 8 分前。レビューは `npm run check`（89 ブロック・122 参照）・linkage 検査（30 件）再実行のみ（不一致なし）。「全辺変数を一つの不定元へ置くと自由境界の分配多項式になる」の Lean 具体版を一つの定理へ合成：`lean/Ising3DCut/AllEdgeVariablesToOneIndeterminateComposed.lean` の `NullModel.allEdgesToOneIndeterminate_multivariatePartitionPolynomial_eq_partitionPolynomial`（`Config L` で $\kappa_L(\mathcal Z_L)=Z_L(X)$）。`lake build` 成功、sorry 検査 142 件。次は Lean 必要十分版。
- 2026-08-16 23:45: 開始が締切 8 分前。レビューは `npm run check`・linkage 検査再実行のみ（不一致なし）。「全辺変数を一つの不定元へ置くと自由境界の分配多項式になる」の Lean 具体版の第二歩：`lean/Ising3DCut/AllEdgeVariablesToOneIndeterminateStepTwo.lean` の `NullModel.sum_X_pow_brokenCount_eq_partitionPolynomial`（$\sum_\sigma X^{\#B(\sigma)}$ を `Finset.sum_fiberwise_of_maps_to` で水準集合ごとに束ね、`multiplicity` の定義と `C_mul_X_pow_eq_monomial` で `partitionPolynomial L` に一致。`lake build` 成功、sorry 検査 141 件 OK。status「Lean 具体版まで」）。次は第一歩・第二歩を `Config L` 上で合成した一つの定理 $\kappa_L(\mathcal Z_L)=Z_L(X)$ を置き、その後 Lean 必要十分版（係数環を可換半環へ、水準集合の束ねは任意の有限型の写像で）。
- 2026-08-16 23:30: 開始が締切 8 分前。レビューは `npm run check`（89 ブロック・122 参照）・linkage 検査（30 件）再実行のみ（不一致なし）。「全辺変数を一つの不定元へ置くと自由境界の分配多項式になる」の Lean 具体版の第一歩：`lean/Ising3DCut/AllEdgeVariablesToOneIndeterminate.lean` に全辺変数を単一不定元へ置く環準同型 `allEdgesToOneIndeterminate`（`eval₂Hom C (fun _ ↦ X)`）、破れ辺の単項式が $X^{\#B(\sigma)}$ へ写る補題、多変数分配多項式の像が $\sum_\sigma X^{\#B(\sigma)}$ になる定理（`lake build` 成功、sorry 検査 140 件 OK。status は「記述と SageMath まで（Lean 具体版は第一歩まで）」）。次は第二歩：$\sum_\sigma X^{\#B(\sigma)}$ を破れ数の水準集合で束ねて `NullModel.partitionPolynomial L` に一致させる（`Finset.sum_fiberwise` と `multiplicity` の定義。具体箱型 `Config L`・`brokenSet` は `NullModel/BrokenComplement.lean`）。
- 2026-08-16 23:15: 開始が締切 8 分前。レビューは `npm run check`・linkage 検査再実行のみ（不一致なし）。本流の todo「有限箱の主張の族の形を一般化する（粗視化の値の一致から等式へ）」に着手し、本文に辺変数付き分配多項式の定義が無いことを確認したので「辺変数付き分配多項式 $\widetilde Z_L$ を定義し全辺変数を一つの不定元へ置く代入で $Z_L$ が得られる」と「粗視化の値の一致から $Z_L$ の等式へ」の二つに割って台帳へ書き、先頭を主張「全辺変数を一つの不定元へ置く環準同型で $\mathcal Z_L$ は $Z_L(X)$ に写る」として記述した（`claim_all_edge_variables_to_one_indeterminate_gives_partition_polynomial`、`npm run check` 89 ブロック・122 参照）。SageMath 検証も同 tick で PASS（$L=1,2$、linkage 30 件）。次の tick は Lean 具体版か割った 2 番目の記述。
- 2026-08-16 23:00: 開始が締切 8 分前。レビューは `npm run check` 再実行（不一致なし）。runbook の「最初の未完了セクションの足りない層」に従い「極限量は有限箱の列だけの関数である」を SageMath 検証（`limit-quantity-depends-only-on-finite-box-sequence`、列の一致→素指数データからの復元→$Z_L(q)=Z_L(q')$・$\#V_L$ の一致、$L=1,2$・有理点対 3 組 PASS、linkage 29 件。`記述と SageMath まで`）。次は Lean での極限量の定義の形式化（`Real` の `Filter.Tendsto`）、または割った 2 番目「有限箱の主張の族の形を一般化する」の記述。
- 2026-08-16 22:45: 開始が締切 8 分前。レビューは `npm run check` 再実行と前 tick の主張の再読（不備なし）。「有限箱の等式の族は極限量の等式へ渡る」を SageMath 検証（`finite-box-equalities-transfer-to-limit-quantity`、$L=1,2$・有理点対 3 組 PASS、linkage 28 件。`記述と SageMath まで`）。次は Lean での極限量の定義の形式化、または割った 2 番目「有限箱の主張の族の形を一般化する」の記述。
- 2026-08-16 22:00: 開始が締切 8 分前。レビューは `npm run check` 再実行と前 tick の主張の再読（不備なし）。懸案「正の実数乗根 vs 実対数」は正の実数乗根を正本と決めた（実対数の記号は禁止）。本流「有限の主張から極限量の言明へ渡す定理」を割り、先頭「有限箱の等式の族は極限量の等式へ渡る」を記述（`claim_finite_box_equalities_transfer_to_limit_quantity`、habitat R、新たな脱出なし。88 ブロック・相互参照 119 件）。次は同主張の SageMath 検証（または割った 2 番目「有限箱の主張の族の形を一般化する」の記述）。
- 2026-08-16 21:15: 開始が締切 8 分前。レビューは `npm run check` 再実行のみ（不一致なし）。本流の先頭「健全性の橋: 極限量を定義する」を三つに割り、先頭「極限量の入力となる有限箱の列を定義する」を記述（`def_finite_box_prime_exponent_sequence`、$S_q\colon L\mapsto(\#V_L,\lambda(Z_L(q)))$、可算側）。次は割った 2 番目「極限量を定義する（脱出はここだけ）」。
- 2026-08-16 21:00: 開始が締切 8 分前。レビューは Lean `lake build`・sorry 検査の再実行のみ（不一致なし）。「増えた辺の変数を 1 に置いた境界応答多項式は配位ごとの元の外箱の破れ辺の単項式の有限和」の Lean 必要十分版（可換半環 $R$、辺型の有限性不要）と導出版を形式化し done。sorry 検査 137 件 OK。次は本流「健全性の橋: 極限量を定義する」（大きければ割って先頭のみ）。
- 2026-08-16 20:45: 開始が締切 8 分前。レビューは Lean `lake build`・sorry 検査の再実行のみ（不一致なし）。「増えた辺の変数を 1 に置いた境界応答多項式は配位ごとの元の外箱の破れ辺の単項式の有限和」の Lean 具体版 `fullBoundaryResponse_outer_edges_to_one_is_sum_of_inner_monomials`（`map_sum` と前主張の項ごとの適用。sorry 検査 135 件 OK、`Lean 具体版まで`）。次は Lean 必要十分版（可換半環 $R$ 上で NecSuf 版を項ごとに適用し $R:=\mathbb Z$ で具体版を導く）。
- 2026-08-16 20:30: 開始が締切 8 分前。レビューは `npm run check` 再実行のみ（不一致なし）。「増えた辺の変数を 1 に置いた境界応答多項式は配位ごとの元の外箱の破れ辺の単項式の有限和」を SageMath 検証（`full-boundary-response-outer-edges-to-one-is-sum-of-inner-monomials`、4096 項 PASS、linkage 27 件。`記述と SageMath まで`）。次は同主張の Lean 具体版（`map_sum` と `brokenMonomial_maps_to_monomial_under_outer_edges_to_one` の項ごとの適用）。
- 2026-08-16 20:15: 開始が締切 8 分前。レビューは `npm run check` 再実行のみ（不一致なし）。主標的の todo が無かったので「増えた辺の変数を 1 に置いた境界応答多項式は配位ごとの元の外箱の破れ辺の単項式の有限和」（$\pi_{L'',L}(\widetilde R_{L'',L'})=\sum_\sigma\prod_{e\in B(\sigma)\cap E_L}X_e$）を台帳へ置き記述（`claim_full_boundary_response_outer_edges_to_one_is_sum_of_inner_monomials`。`npm run check` 83 ブロック・相互参照 107 件、`記述まで`）。次は SageMath 検証（内箱 1 点・外箱 $\{0,1\}^3$・広い外箱で両辺を `ZZ` 上比較）。
- 2026-08-16 20:00: 開始が締切 8 分前。レビューは `lake build`・sorry 検査再実行のみ（不一致なし）。「各配位の単項式は増えた辺の変数を 1 に置く代入で単項式に写る」の Lean 必要十分版 `NecSuf.monoidHom_prod_eq_prod_preimage_of_outside_eq_one`（可換モノイド間のモノイド準同型・単射 $\iota$・像外の因子 1 だけで成立）と `NecSuf.brokenMonomial_maps_to_monomial_under_outer_edges_to_one`（可換半環 $R$）・`_fromNecSuf`（`done`。sorry 検査 134 件 OK）。四層が揃った。次は主標的表の次の todo（無ければ $\widetilde R$ の単項式構造の次の小主張を割って記述）。
- 2026-08-16 19:45: 開始が締切 12 分前。レビューは `npm run check`・linkage 検査再実行のみ（不一致なし）。「各配位の単項式は増えた辺の変数を 1 に置く代入で単項式に写る」の Lean 具体版 `brokenMonomial_maps_to_monomial_under_outer_edges_to_one`（単射 $\iota$ と `map_prod`・`Finset.prod_preimage`・`prod_congr`。`Lean 具体版まで`。sorry 検査 131 件 OK）。次は同主張の Lean 必要十分版（可換半環へ一般化）。
- 2026-08-16 19:30: 開始が締切 8 分前。レビューは `npm run check`・linkage 検査再実行のみ（不一致なし）。「各配位の単項式は増えた辺の変数を 1 に置く代入で単項式に写る」を SageMath 検証（`full-boundary-response-monomial-maps-to-monomial-under-outer-edges-to-one`、4096 配位 PASS、linkage 26 件。`記述と SageMath まで`）。次は同主張の Lean 具体版。
- 2026-08-16 19:15: 開始が締切 8 分前。レビューは `npm run check`・linkage 検査再実行のみ（不一致なし）。主標的の todo が無かったので「各配位の単項式は増えた辺の変数を 1 に置く代入で単項式に写る」（$\pi_{L'',L}(\prod_{e\in B(\sigma)}X_e)=\prod_{e\in B(\sigma)\cap E_L}X_e$）を台帳へ置き記述した（`claim_full_boundary_response_monomial_maps_to_monomial_under_outer_edges_to_one`。`記述まで`。82 ブロック・相互参照 102 件）。同主張の SageMath 検証 PASS（L=1 で Z_1=2 が定数という例外を検査が発見し、主張に L≥2 の条件を追加）。status `記述と SageMath まで`。次は同主張の Lean 具体版。
- 2026-08-16 19:00: 開始が締切 8 分前。レビューは Lean の `lake build`・sorry 検査再実行のみ（不一致なし）。「増えた辺の変数を 1 に置いてから全変数を 1 に置くことは全変数を 1 に置くことに等しい」の Lean 必要十分版 `NecSuf.eval_one_comp_outer_edges_to_one`・`NecSuf.fullBoundaryResponse_outer_edges_to_one_then_eval_one`（可換半環 `R`。ℤ の一意性の代わりに $\pi$ を `R`-代数準同型に取り `algHom_ext`）と導出 `_fromNecSuf`（`π.toIntAlgHom`。`done`。sorry 検査 130 件 OK）。四層が揃った。次は主標的表の次の todo（無ければ $\widetilde R$ の単項式構造の次の小主張——各配位の単項式が $\pi_{L'',L}$ で単項式に写ること等——を割って記述）。
- 2026-08-16 18:45: 同主張の Lean 具体版 `eval_one_comp_outer_edges_to_one`（`ringHom_ext`、定数項は `RingHom.ext_int`）・`fullBoundaryResponse_outer_edges_to_one_then_eval_one`（`Lean 具体版まで`。sorry 検査 127 件 OK）。
- 2026-08-16 18:30: 開始が締切 8 分前。レビューは前 tick の記述の読み直しと linkage 検査のみ（不一致なし）。「増えた辺の変数を 1 に置いてから全変数を 1 に置くことは全変数を 1 に置くことに等しい」を SageMath で検証（`sagemath/check/full-boundary-response-outer-edges-to-one-then-value-at-one/`、全不定元での値の一致・普遍性による準同型の等式・$\varepsilon_L(\pi_{L'',L}(\widetilde R_{L'',L'}))=4096=2^{12}$、PASS、検証対応 25 件。`記述と SageMath まで`）。次はこの主張の Lean 具体版（`lean/Ising3DCut/BoundaryResponsePolynomial.lean` に、外側辺を 1 に送る代入と `eval (fun _ ↦ 1)` の合成が全不定元で一致することから `MvPolynomial.ringHom_ext` で等式、値は `fullBoundaryResponse_eval_one_eq_card_configuration` へ帰着）。
- 2026-08-16 18:15: 開始が締切 8 分前。レビューは前 tick の Lean の `lake build`・sorry 検査再実行のみ（125 件 OK、不一致なし）。主標的の todo が無かったので「増えた辺の変数を 1 に置いてから全変数を 1 に置くことは全変数を 1 に置くことに等しい」（$\varepsilon_L\circ\pi_{L'',L}=\varepsilon_{L''}$、$\varepsilon_L(\pi_{L'',L}(\widetilde R_{L'',L'}))=2^{\#V_{L''}}$）を台帳へ置き記述した（`claim_full_boundary_response_outer_edges_to_one_then_value_at_one`。`記述まで`。81 ブロック・相互参照 100 件）。次はこの主張の SageMath 検証（内箱 1 点・外箱二つで不定元ごとの一致と $\widetilde R$ での値を `ZZ` 上で比較）。
- 2026-08-16 18:00: 開始が締切 8 分前。レビューは前 tick の Lean の `lake build`・sorry 検査再実行のみ（不一致なし）。「全変数を 1 に置いた値は配位の総数」の Lean 必要十分版 `NecSuf.fullBoundaryResponse_eval_one_eq_card_configuration`（可換半環 `R`。`Fintype Edge`・`DecidableEq Edge` を外す）と導出 `_fromNecSuf`（`done`。sorry 検査 125 件 OK）。四層が揃った。次は主標的表の次の todo（無ければ $\widetilde R$ の単項式構造の次の小主張、例えば $\pi_{L'',L}$ と $\varepsilon_L$ の合成が $\varepsilon_{L''}$ になること、を割って記述）。
- 2026-08-16 17:48: 開始が締切 12 分前。レビューは前 tick の SageMath 検証と `npm run check` 再実行のみ（不一致なし）。「全変数を 1 に置いた値は配位の総数」の Lean 具体版 `fullBoundaryResponse_eval_one_eq_card_configuration`（`eval (fun _ ↦ 1)` が有限和・有限積を保ち各不定元を 1 へ写すので像は `#Configuration`。`lake build` 成功、sorry 検査 123 件 OK。`Lean 具体版まで`）。次はこの主張の Lean 必要十分版（`NecSuf/BoundaryResponsePolynomial.lean` に可換半環 `R` 版と `_fromNecSuf` 導出）。
- 2026-08-16 17:31: 開始が締切 8 分前。レビューは `npm run check` 再実行のみ（不一致なし）。「全変数を 1 に置いた値は配位の総数」を SageMath で検証（`sagemath/check/full-boundary-response-value-at-one/`、$\varepsilon_L(\widetilde R_{L,L'})=256=2^8$、PASS、検証対応 24 件。`記述と SageMath まで`）。次はこの主張の Lean 具体版（`MvPolynomial.eval` または `aeval` で全不定元を 1 に置き、配位の有限和の像が `Fintype.card` になることを `lean/Ising3DCut/BoundaryResponsePolynomial.lean` に置く）。
- 2026-08-16 17:18: 開始が締切 8 分前。レビューは sorry 検査再実行のみ（122 件 OK）。主標的の todo が無かったので「全変数を 1 に置いた値は配位の総数」（$\varepsilon_L(\widetilde R_{L,L'})=2^{\#V_L}$）を台帳へ置き記述した（`claim_full_boundary_response_value_at_one`。`記述まで`。80 ブロック・相互参照 97 件）。次はこの主張の SageMath 検証（小さい箱で $\widetilde R$ の全変数を 1 に置いた値と $2^{\#V_L}$ を `ZZ` 上で比較）。
- 2026-08-16 17:02: 「全次数は辺の総数に等しい」の Lean 必要十分版の後半 `NecSuf.fullBoundaryResponse_totalDegree_eq_card_edge`（可換半環 `R`・係数非零に `CharZero R`）と導出 `_fromNecSuf`（`done`。sorry 検査 122 件 OK）。四層が揃った。次は主標的表の次の todo（無ければ $\widetilde R$ の単項式構造の次の小主張を割って記述）。
- 2026-08-16 16:48: 「全次数は辺の総数に等しい」の Lean 必要十分版を割り、前半 `NecSuf.fullBoundaryResponse_totalDegree_le_card_edge`（可換半環 `R`・`Nontrivial R` は `totalDegree_X` が要求・`Fintype Edge` は結論の $\#E_L$ のため残る）と導出 `_fromNecSuf`（`Lean 必要十分版の途中`。sorry 検査 120 件 OK）。次は後半（全次数 $=\#E_L$ の必要十分版。係数非零に `CharZero R`）と導出。
- 2026-08-16 16:17: 「全次数は辺の総数に等しい」の Lean 具体版の後半 `fullBoundaryResponse_totalDegree_eq_card_edge`（全辺を破る配位を仮定に取り、その単項式が台に属し `le_totalDegree` で下界。`Lean 具体版まで`。sorry 検査 118 件 OK）。次は同主張の Lean 必要十分版（可換半環・`Nontrivial R`、`Fintype Edge` は結論に残るか要検討）と具体版からの導出。
- 2026-08-16 15:47: 「全次数は辺の総数に等しい」を SageMath 検証（`sagemath/check/full-boundary-response-total-degree-is-edge-count/`、PASS。$\Omega_L(12)=2$、全次数 12。`記述と SageMath まで`。検証対応 23 件）。次は同主張の Lean 具体版（`MvPolynomial.totalDegree`、単項式の全次数 ≤ #E_L と全辺単項式の係数 ≥ 2）。
- 2026-08-16 15:34: 主標的の todo が無かったので「全次数は辺の総数に等しい」を台帳へ置き記述（`claim_full_boundary_response_total_degree_is_edge_count`。単項式の全次数 $\#B(\sigma)\le\#E_L$ と $\prod_{e\in E_L}X_e$ の係数 $\Omega_L(\#E_L)\ge2$。`記述まで`。79 ブロック・相互参照 94 件）。次は同主張の SageMath 検証（小さい箱で各単項式の全次数と全辺単項式の係数を `ZZ` 上で確認）。
- 2026-08-16 15:19: 「真に依存する」主張の Lean 必要十分版 `NecSuf.fullBoundaryResponse_degreeOf_eq_one`（可換半環 `R`・`Nontrivial R`・`CharZero R`・`Fintype Edge` 除去。`CharZero` は配位の個数が `R` で 0 でないために必要）と導出 `fullBoundaryResponse_degreeOf_eq_one_fromNecSuf`（`done`。sorry 検査 116 件 OK。前 tick の未登録 2 本も登録）。次は主標的の次セクション（todo が無ければ次の小主張を割って台帳へ書き先頭を記述する）。
- 2026-08-16 15:00: 「真に依存する」主張の Lean 具体版を閉じた（`fullBoundaryResponse_degreeOf_eq_one`：係数 1 以上で support に属する $\tau$ の単項式の $e_0$ 指数 1 が `monomial_le_degreeOf` で次数以下、`≤ 1` と合わせて `= 1`。`lake build` 成功・sorry 検査 112 件 OK。`Lean 具体版まで`）。次は同主張の Lean 必要十分版（可換半環・`Nontrivial R`・`Fintype Edge` 除去）と具体版からの導出。
- 2026-08-16: 「真に依存する」主張の Lean 具体版の第一歩 `brokenMonomial_exponent_at_broken_edge` を追加（台帳「現在地」参照。sorry 検査の再実行は次 tick で確認）。
- 2026-08-16 14:17: 「増えた辺の変数に真に依存する」を SageMath で検証（`sagemath/check/full-boundary-response-degree-exactly-one/` PASS。各辺 $e_0$ の一端だけ $-1$ の配位 $\tau$ が $e_0$ を破ること・破れ辺集合ごとの自然数係数が $1$ 以上・次数がちょうど $1$ を証明と同順に `ZZ` 上で確認。`記述と SageMath まで`。検証対応 22 件）。次は同主張の Lean 具体版（`lean/Ising3DCut/BoundaryResponsePolynomial.lean` に、一端反転の配位の単項式の係数が `≥ 1` で `degreeOf` が `1` 以上、`≤ 1` と合わせて `= 1` を人手証明と同順に）。
- 2026-08-16 14:02: 「増えた辺の変数に真に依存する」を記述（`claim_full_boundary_response_degree_exactly_one`。$e_0$ の一端だけ $-1$ の配位 $\tau$ が $e_0$ を破り、破れ辺集合ごとにまとめた自然数係数が $1$ 以上で次数がちょうど $1$。`記述まで`。78 ブロック・相互参照 87 件）。次は同主張の SageMath 検証（小さい箱で $\tau$ の単項式の係数と各辺の次数を `ZZ` 上で確認）。
- 2026-08-16 13:35: 「各辺変数についての次数は高々 1」の Lean 具体版 `fullBoundaryResponse_degreeOf_le_one`（`degreeOf_sum_le`・`degreeOf_prod_le`・`degreeOf_X` を人手証明と同順に。`lake build` 成功・sorry 検査 109 件 OK。`Lean 具体版まで`）。次は同主張の Lean 必要十分版（係数環を可換半環へ一般化・`Fintype` 除去）と具体版からの導出。
- 2026-08-16 13:47: 「各辺変数についての次数は高々 1」の Lean 必要十分版 `NecSuf.fullBoundaryResponse_degreeOf_le_one`（可換半環 `R`・`Nontrivial R`・`Fintype Edge` 除去）と `R := ℤ` からの導出 `fullBoundaryResponse_degreeOf_le_one_fromNecSuf`（`lake build` 成功・sorry 検査 109 件 OK。`done`）。次は残りの「増えた辺の変数に真に依存する」（次数がちょうど 1。$e$ の一端反転の配位と非負係数）を記述する。
- 2026-08-16 13:20: 「各辺変数についての次数は高々 1」を SageMath で検証（`sagemath/check/full-boundary-response-degree-at-most-one/` PASS。単項式ごとの指数・有限和の全指数列挙・全 12 辺の次数を証明と同順に `ZZ` 上で確認。`記述と SageMath まで`。検証対応 21 件）。次は同主張の Lean 具体版（`lean/Ising3DCut/` に `MvPolynomial` の `degreeOf` で各配位の単項式の指数と有限和の次数評価を人手証明と 1 対 1 に）。
- 2026-08-16 13:05: 「真に依存する」を 2 つに割り、先頭「各辺変数についての次数は高々 1」を記述（`claim_full_boundary_response_degree_at_most_one`。単項式が $B(\sigma)$ 上の相異なる不定元の積であることと有限和の次数の最大値評価。`記述まで`。77 ブロック・相互参照 84 件）。次は同主張の SageMath 検証（小さい箱で各単項式の指数と次数を `ZZ` 上で列挙）。
- 2026-08-16 12:53: 「辺変数を 1 に置かない境界応答多項式の共通の外箱を経由した比較」の Lean 必要十分版 `NecSuf.fullBoundaryResponse_common_outer_box_comparison`（可換半環、二外箱の辺型の有限性・可判定同値性不要）と導出 `fullBoundaryResponse_common_outer_box_comparison_fromNecSuf`（`done`。lake build 成功・sorry 検査 108 件 OK。前 tick の書きかけ差分を検証してコミット）。次は台帳の次の todo「辺変数を 1 に置かない境界応答多項式は増えた辺の変数に真に依存する」の記述。
- 2026-08-16 12:18: 「辺変数を 1 に置かない境界応答多項式の共通の外箱を経由した比較」の Lean 具体版 `fullBoundaryResponse_common_outer_box_comparison`（外箱依存性の 2 回適用と配位数の積の可換性。`Lean 具体版まで`。lake build 成功・sorry 検査 104 件 OK）。次は同セクションの Lean 必要十分版と具体版からの導出。
- 2026-08-16 12:02: 「辺変数を 1 に置かない境界応答多項式の共通の外箱を経由した比較」を SageMath で検証（`sagemath/check/full-boundary-response-common-outer-box-comparison/` PASS。互いに含まない二外箱 $3\times2\times2$・$2\times3\times2$ で外箱依存性の 2 回適用と 2 冪の積を証明と同順に確認。`記述と SageMath まで`。検証対応 20 件）。次は同セクションの Lean 具体版（`lean/Ising3DCut/` に `fullBoundaryResponse_outer_edges_to_one` を 2 回使う形で置く）。
- 2026-08-16 11:48: 主標的の todo が尽きたので「$\widetilde R$ の安定性・非依存性」を 2 セクション（共通の外箱を経由した比較／増えた辺の変数への真の依存）に割り、先頭「辺変数を 1 に置かない境界応答多項式の共通の外箱を経由した比較」を記述（`claim_full_boundary_response_common_outer_box_comparison`。外箱依存性の 2 回適用。`記述まで`。76 ブロック・相互参照 83 件）。次は同セクションの SageMath 検証（外箱依存性の検証と同じ箱に第二の外箱を加える）。
- 2026-08-16 11:33: 「辺変数を 1 に置かない境界応答多項式の外箱依存性」の Lean 必要十分版 `NecSuf.fullBoundaryResponse_outer_edges_to_one`（可換半環、辺型の有限性不要）と導出 `fullBoundaryResponse_outer_edges_to_one_fromNecSuf`（`done`。sorry 検査 103 件）。次は主標的の次セクション（todo が無ければ $\widetilde R$ の安定性・非依存性に相当する主張を分割して台帳へ書き、先頭を記述する）。
- 2026-08-16 11:17: 「辺変数を 1 に置かない境界応答多項式の外箱依存性」の Lean 具体版 `fullBoundaryResponse_outer_edges_to_one`（環準同型 π による有限和の分配。`Lean 具体版まで`。sorry 検査 103 件）。次は同セクションの Lean 必要十分版（`NecSuf/BoundaryResponsePolynomial.lean` に可換半環版）と `FromNecSuf` での導出。
- 2026-08-16 11:02: 「辺変数を 1 に置かない境界応答多項式の外箱依存性」を SageMath で検証（`sagemath/check/full-boundary-response-outer-edges-to-one/` PASS。代入 $\pi_{L'',L}$ を `PolynomialRing.hom` で作り環準同型と $2^4$ 倍を `ZZ` 上で確認。`記述と SageMath まで`。検証対応 19 件）。次は同セクションの Lean 具体版（`lean/Ising3DCut/` に、辺型を分割した代入で外側辺を 1 に送る形で置く）。
- 2026-08-16 10:47: 「辺変数を 1 に置かない境界応答多項式の外箱依存性」を記述（`claim_full_boundary_response_outer_edges_to_one`。外側の増分辺の変数だけ 1 に置く代入で $2^{\#V_{L''}-\#V_L}\widetilde R_{L,L'}$ に戻る。`記述まで`。75 ブロック・相互参照 78 件）。次は同セクションの SageMath 検証（`sagemath/check/` に安定性の検証と同じ箱で）。
- 2026-08-16 10:32: 「内箱と外箱の間の辺変数を 1 に置かない測定量の定義」を記述（`def_full_boundary_response_polynomial`。定義のみで done。74 ブロック・相互参照 72 件）。外箱依存性は新セクション「辺変数を 1 に置かない境界応答多項式の外箱依存性」（todo）へ割った。次はその記述。
- 2026-08-16 10:17: 「内箱と外箱の間の辺変数を 1 に置かない測定量への選び直し」を割り、先頭「境界応答多項式は外箱の点の数え上げしか外箱から受け取らない（明記）」を注意書き（remark、`remark_boundary_response_only_outer_count_survives`）として記述（done。数学的主張でないので SageMath/Lean 対象なし。73 ブロック・相互参照 70 件）。次は新セクション「内箱と外箱の間の辺変数を 1 に置かない測定量の定義」（todo）の記述。
- 2026-08-16 10:02: 「境界応答多項式は外箱に依存しない」の Lean 必要十分版 `NecSuf.boundaryResponsePolynomial_outer_box_independence` と導出 `_fromNecSuf`（`done`。sorry 検査 102 件）。次は台帳の次の todo「内箱と外箱の間の辺変数を 1 に置かない測定量への選び直し」（最小の外箱の定義を含む）の記述。
- 2026-08-16 09:48: 「境界応答多項式は外箱に依存しない」の Lean 具体版 `boundaryResponsePolynomial_outer_box_independence`（安定性の二度適用と配位数の積。`Lean 具体版まで`。sorry 検査 100 件）。次は同セクションの Lean 必要十分版（`NecSuf/BoundaryResponsePolynomial.lean` に可換半環版）と `FromNecSuf` での導出。
- 2026-08-16 09:32: 「境界応答多項式は外箱に依存しない」を SageMath で検証（`記述と SageMath まで`。`sagemath/check/boundary-response-outer-box-independence/` PASS、検証対応 18 件）。次は同セクションの Lean 具体版（`lean/Ising3DCut/` に安定性の定理を二度使う形で置く）。
- 2026-08-16 09:17: 「境界応答多項式は外箱に依存しない」を記述（`記述まで`）。次は同セクションの SageMath 検証。測定量選び直しは新セクション「内箱と外箱の間の辺変数を 1 に置かない測定量への選び直し」（todo）へ割った。

作業前に [README.md](README.md) と リポジトリ直下の [docs/context/](../docs/context/) を全て読むこと。
自動ループで作業する場合は [docs/tasks/auto-loop-runbook.md](docs/tasks/auto-loop-runbook.md) と
[docs/tasks/auto-loop-state.md](docs/tasks/auto-loop-state.md) も読む。

- 2026-08-16: 健全性の橋の 2 番目「極限量を定義する」を記述（`def_limit_quantity_from_finite_box_sequence`、habitat R、唯一の脱出。実対数の代わりに正の実数乗根の極限で書いた——要レビュー）。次は割った 3 番目。
## 直近（2026-08-16 18:45 tick）

- 2026-08-26 15:06: 本流「底の従属性を整除へ代入して分子と箱の値を結ぶ」の Lean 具体版を追加（`lean/Ising3DCut/LimitQuantity/NumeratorDividesTwiceThresholdBoxValueMinusOne.lean`）。`lake build` 成功、未証明依存検査 541 件。次は同主張の Lean 必要十分版。

- 2026-08-26 14:33: 本流「底の従属性を整除へ代入して分子と箱の値を結ぶ」の SageMath 三検査を全 PASS。次は同主張の Lean 具体版。

- 2026-08-26 14:05: 本流「底の従属性を整除へ代入して分子と箱の値を結ぶ」を記述（`claim_numerator_divides_twice_threshold_box_value_minus_one`）。次は同主張の SageMath 検証。

- 2026-08-24 13:37: 本流「冪等式の末尾成立を正の有理数の点数乗という形へ言い換える」の Lean 具体版を前半・後半へ割り、前半（十分性と、隣接立方数の互いに素性・点数による可除性・商の不変性の算術三段）を `lean/Ising3DCut/LimitQuantity/PowerIdentityIffRationalPowerForm.lean` へ書いて build と sorry 検査 389 件を通した。後半は有限積による正の有理数の復元と同値性の完成で、次の tick はここから。
- 2026-08-17 10:00 tick: 本流「対称化した列は q↔1/q で不変である（有限箱の等式）」の Lean 必要十分版 `lean/Ising3DCut/NecSuf/SymmetrizedReciprocalInvariant.lean`（仮定は回文・次数≤E・q≠0・f(1/q)≠0 だけ）と零モデル版の導出 `LimitQuantity/SymmetrizedReciprocalInvariantNullModelFromNecSuf.lean`。sorry 検査 204 件。status done。次は本流「対称化した極限量に対して粗視化 q↦ε_{L,q}(Z_L) は必要でない」に着手。
- 2026-08-17 06:45 tick: 本流「極限量に対して必要でない粗視化を一つ同定する」を 2 つに割った（先頭: 回文性から対称化した量 τ_L(q)=λ(Z_L(q))−(#E_L/2)λ(q) の q↔1/q 不変（有限箱の等式）、次: その箱の極限 α̃ に対して粗視化が必要でない）。対称化しない α には Z_L の単射性から反例が立たない論点を台帳に記録。割った先頭を記述（`claim_symmetrized_prime_exponent_data_is_reciprocal_invariant`、σ_L(q)=2λ(Z_L(q))−#E_L λ(q)∈Λ。check 95 ブロック、build:pdf 26 ページ）。同主張の SageMath 検証 PASS（L=1 で Z_1=2 が定数という例外を検査が発見し、主張に L≥2 の条件を追加）。status `記述と SageMath まで`。次は同主張の Lean 具体版。

- 「増えた辺の変数を 1 に置いてから全変数を 1 に置くことは全変数を 1 に置くことに等しい」の Lean 具体版（`eval_one_comp_outer_edges_to_one`・`fullBoundaryResponse_outer_edges_to_one_then_eval_one`、sorry 検査 127 件）。次は Lean 必要十分版（係数環一般化。ℤ の一意性が使えないので `C` の像の一致を仮定に置く見込み）。

## 09:00 tick

レビューのみ（08:45 tick と同内容）（検査 71 ブロック・SageMath 対応 17 件・sorry 検査 99 件・立場違反語走査・PDF に不備なし）。開始が遅く「境界応答多項式は外箱に依存しない」の記述は未着手。次の tick はその記述を行う。

## 08:45 tick

レビューのみ（08:30 tick と同内容）（検査 71 ブロック・SageMath 対応 17 件・sorry 検査 99 件・立場違反語走査・PDF に不備なし）。開始が遅く「境界応答多項式は外箱に依存しない」の記述は未着手。次の tick はその記述を行う。

## 08:30 tick

レビューのみ（08:15 tick と同内容）（検査 71 ブロック・SageMath 対応 17 件・sorry 検査 99 件・立場違反語走査・PDF に不備なし）。開始が遅く「境界応答多項式は外箱に依存しない」の記述は未着手。次の tick はその記述を行う。

## 08:15 tick

レビューのみ（08:00 tick と同内容）（検査 71 ブロック・SageMath 対応 17 件・sorry 検査 99 件・立場違反語走査・PDF 19 ページに不備なし）。開始が遅く「境界応答多項式は外箱に依存しない」の記述は未着手。次の tick はその記述を行う。

## 08:00 tick

レビューのみ（07:45 tick と同内容）（検査 71 ブロック・SageMath 対応 17 件・sorry 検査 99 件・立場違反語走査・PDF 19 ページに不備なし）。開始が遅く「境界応答多項式は外箱に依存しない」の記述は未着手。次の tick はその記述を行う。

## 07:45 tick

レビューのみ（07:30 tick と同内容）（検査 71 ブロック・SageMath 対応 17 件・sorry 検査 99 件・立場違反語走査・PDF 19 ページに不備なし）。開始が遅く「境界応答多項式は外箱に依存しない」の記述は未着手。次の tick はその記述を行う。

## 07:30 tick

レビューのみ（07:15 tick と同内容）（検査 71 ブロック・SageMath 対応 17 件・sorry 検査 99 件・立場違反語走査・PDF に不備なし）。開始が遅く「境界応答多項式は外箱に依存しない」の記述は未着手。次の tick はその記述を行う。

## 07:00 tick

レビューのみ（検査 71 ブロック・SageMath 対応 17 件・sorry 検査 99 件・立場違反語走査・PDF に不備なし）。開始が遅く「境界応答多項式は外箱に依存しない」の記述は未着手。次の tick はその記述を行う。

## 06:45 tick

レビューのみ（検査 71 ブロック・SageMath 対応 17 件・sorry 検査 99 件・立場違反語走査・PDF に不備なし）。開始が遅く「境界応答多項式は外箱に依存しない」の記述は未着手。次の tick はその記述を行う。

## 06:30 tick

レビューのみ（検査 71 ブロック・SageMath 対応 17 件・sorry 検査 99 件・立場違反語走査・PDF に不備なし）。開始が遅く「境界応答多項式は外箱に依存しない」の記述は未着手。次の tick はその記述を行う。

## 06:15 tick

レビューのみ（検査 71 ブロック・SageMath 対応 17 件・sorry 検査 99 件・立場違反語走査・PDF に不備なし）。開始が遅く「境界応答多項式は外箱に依存しない」の記述は未着手。次の tick はその記述を行う。

## 06:00 tick

レビューのみ（検査 71 ブロック・SageMath 対応 17 件・sorry 検査 99 件・立場違反語走査・PDF に不備なし）。開始が遅く「境界応答多項式は外箱に依存しない」の記述は未着手。次の tick はその記述を行う。

## 05:45 tick

レビューのみ（検査 71 ブロック・SageMath 対応 17 件・sorry 検査 99 件・立場違反語走査・PDF に不備なし）。開始が遅く「境界応答多項式は外箱に依存しない」の記述は未着手。次の tick はその記述を行う。

## 05:30 tick

レビューのみ（検査 71 ブロック・SageMath 対応 17 件・sorry 検査 99 件・立場違反語走査・PDF に不備なし）。開始が遅く「境界応答多項式は外箱に依存しない」の記述は未着手。次の tick はその記述を行う。

## 05:15 tick

レビューのみ（検査 71 ブロック・SageMath 対応 17 件・sorry 検査 99 件・立場違反語走査・PDF に不備なし）。開始が遅く「境界応答多項式は外箱に依存しない」の記述は未着手。次の tick はその記述を行う。

## 05:00 tick

「外箱の拡大に対する境界応答多項式の安定性」の Lean 必要十分版と導出を形式化し、四層完了（`done`）。
sorry 検査 99 件 OK。レビューに不備なし。次はセクション台帳の次の未完了セクション。詳細は台帳「現在地」先頭。

## ゴール設定（2026-08-14 に確定）

**可算コアの同定**：有限格子の可算データの上で、極限で効く部分と極限で潰れる部分を分離する。
正本は [docs/discussion/3次元Isingを可算側で書く/可算コアの同定とは何か.md](../docs/discussion/3次元Isingを可算側で書く/可算コアの同定とは何か.md)。
**帰無モデル（二部性からの回文性・値と台の恒等式・Galois 群の超八面体上限）を先に確定させる。**
これを超える構造だけが内容になる。族は境界条件で添字づける。

当初の本体だった「臨界点を有理数の切断として定める」は、健全性の橋が無いため**降格し、
2026-08-14 に本文から `_old/demoted-critical-point-cut/` へ退避した**。
退避先の README に、降格の理由と既知の欠陥（観測点が箱の角にある／証拠の定義が有限でない／
上界が低温側を特徴づけない／未証明 2 件／辺の定義が規約違反）を列挙してある。
土台の定義（格子点・隣接・箱・内部辺・配位）は共通なので本文に残した。
**本文は主標的だけで構成する。**

2026-08-15 に「2 次元からの事前予言」を記述した。2 次元側の有限式からは、3 次元自由境界族の
既約分解・判別式・分解体と Galois 群・零点の最小多項式次数について具体的な全称命題を導けない。
このため四候補を測定前に落とし、候補選別の記録としてセクションを完了した。候補選別で挙げた
測定量はこの四つで尽きるため、現時点で「小さい箱での厳密測定」の対象は残っていない。
このため同セクションは計算を実行せず完了とした。次の先頭未完了は「測定量の選び直し」であり、
多変数分配多項式と箱の包含写像から、極限で潰れるかを問える候補を一つに絞る。

2026-08-15 に「測定量の選び直し」を記述した。内箱の内部辺と内箱から外へ出る境界辺の変数を保持し、
内箱に接しない辺変数を 1 に置く境界応答多項式を、箱の包含に沿う測定量として選んだ。有限な代入写像が
整係数多項式環の環準同型であることも示した。status は `記述まで`。次の tick は $L'=1,L=2$ の
自由境界箱で、多変数分配多項式・有限代入・環準同型性・境界応答多項式を SageMath で検証する。
2026-08-15 22:15 開始のレビューのみの tick では、境界応答多項式の定義の端点記法を宣言済みの $\partial_0,\partial_1$ に統一した（修正のみ、検査全通過）。次の tick は同セクションの SageMath 検証に着手する。

2026-08-16 に「外箱の拡大に対する境界応答多項式の安定性」を記述し、同日 03:00 の tick で SageMath 検証（`sagemath/check/boundary-response-outer-box-stability/`、内箱 1 点・外箱 8 点・広い外箱 12 点で $R_{L'',L'}=16R_{L,L'}$、PASS）を追加した。status は `記述と SageMath まで`。次の tick は Lean 具体版を行う。

2026-08-15 に「測定量の選び直し」の SageMath 検証を完了した。$L'=1,L=2$ の自由境界箱で、
多変数分配多項式の有限和、内箱に接する辺変数だけを保つ有限代入、加法・乗法・単位元の保存、
代入像と境界応答多項式の直接の有限和の一致を `ZZ` 上で確認した。status は
`記述と SageMath まで`。次の tick は Lean 具体版を行う。

2026-08-15 に「測定量の選び直し」の Lean 具体版を完了した。有限な配位型・辺型上の多変数分配
多項式、保持辺以外を 1 に置く有限代入、各変数の像、加法・乗法・単位元の保存、代入像としての
境界応答多項式を本文と同じ順で形式化し、入口と未証明依存の検査へ登録した。status は
`Lean 具体版まで`。次の tick は Lean 必要十分版と具体版からの導出を行う。

2026-08-16 に「測定量の選び直し」の Lean 必要十分版（係数環を可換半環へ一般化、`Fintype Edge` を除去）と
具体版からの導出（`R := ℤ` への特殊化）を完了し、status を `done` にした（未証明依存検査 96 件）。
主標的に未完了セクションが無くなったので、次の tick は境界応答多項式が箱の包含でどう変わるかを問う
次のセクションを台帳へ切り出す。

2026-08-16 00:45・01:00・01:15・01:30・01:45・02:00・02:15 開始の各 tick はレビューのみ（検査・検証対応 16 件・立場違反語の走査・PDF 生成を再実行、不備なし）。開始が遅く「外箱の拡大に対する境界応答多項式の安定性」の記述には未着手。次の tick は同セクションの記述を行う。

2026-08-15 22:45・23:15・23:45 開始の各 tick はレビューのみ（検査・検証対応 16 件・Lean 未証明依存検査 83 件・立場違反語の走査・PDF 生成を再実行、不備なし）。開始が遅く Lean 必要十分版には未着手。次の tick は Lean 必要十分版と導出を行う。

2026-08-15 21:45 開始のレビューのみの tick では、検査と検証対応を再実行して不備なしを確認し、「測定量の選び直し」の候補の当たり（辺変数の多変数分配多項式と箱の包含写像）を台帳の引き継ぎへ書いた。次の tick は同セクションの記述に着手する。

2026-08-15 のそれ以前のレビューのみの tick では、本文全体を禁止された脱出の記号で機械的に走査し、
検査を再実行して不備なしを確認した。開始が遅く「2 次元からの事前予言」には未着手。次の tick は
同セクションを 1 tick で閉じる大きさに割ってから記述に着手する。

2026-08-15 のレビューのみの tick で、「零点と係数データが決める多項式」の本文・Lean
具体版・必要十分版・導出を再照合し、不備なしを確認した。必須検証は全通過。次の tick は
「2 次元からの事前予言」の記述に着手する。

2026-08-15 に「零点と係数データが決める多項式」の Lean 必要十分版と具体版からの導出を完了した。
必要十分版は、二つの反例に対する観測値の相違と共通の零点データ、および最高次データと重複度込み
零点データからの共通の復元表示だけを仮定する。四層が揃い、次の先頭未完了は「2 次元からの事前予言」である。

2026-08-15 に「零点と係数データが決める多項式」を記述した。相異なる零点だけでは最高次係数と
代数的重複度が落ちることを二つの有限な反例で示し、相異なる零点の有限集合・各零点の正の重複度・
非零の最高次係数を加えれば、代数的数係数多項式が有限積で一意に決まることを証明した。
status は `記述まで` で、次の tick は SageMath 検証を行う。
同日の次 tick で記述をレビュー（不備なし）し、SageMath 検証（`sagemath/check/root-data-determine-polynomial/`、
`QQbar[X]` で 13 件 PASS）を追加した。status は `記述と SageMath まで` で、次の tick は Lean 具体版を行う。
同日の次 tick で本文と SageMath 検証を再照合して不備なしを確認し、Lean 具体版を追加した。
最高次係数と重複度を落とす反例、重複度込みの零点多重集合と最高次係数からの有限積表示、
同じデータを持つ多項式の一致を形式化した。status は `Lean 具体版まで`で、次の tick は必要十分版と導出を行う。
同日の次 tick で Lean 具体版を人手証明と照合して不備なしを確認した（レビューのみ。lake build・no-sorry 通過）。
次の tick は必要十分版と導出を行う。

2026-08-15 に「周期族から整数の算術を落とす」の Lean 必要十分版と具体版からの導出を完了した。
必要十分版は有限な配位型・辺型、破れ数 0 の witness、奇数長の整数 ±1 の輪、全辺破れから
隣接値の相違を得る性質だけを残し、具体版と同じ四段で端点多重度の不一致を示した。四層が揃い、
次の先頭未完了セクションは「零点と係数データが決める多項式」である。

2026-08-15 のレビューのみの tick で「周期族から整数の算術を落とす」の Lean 具体版を人手証明と照合し不備なしを確認した（lake build・no-sorry 71 件通過。必要十分版は未着手。次の tick で行う）。

2026-08-15 に「周期族から整数の算術を落とす」の Lean 具体版を完了した。有限周期後続系の定義、
定数配位、奇数軌道の有限積、全辺破れ配位の不存在、端点多重度の不一致を人手証明と同じ順で
形式化した。status は `Lean 具体版まで` で、次の tick は必要十分版と導出を行う。

2026-08-15 のレビューのみの tick で、同セクションの SageMath 検証のうち奇数軌道の有限積の検査が空虚に通っていた点を直した（次の tick は Lean 具体版）。

2026-08-15 に「周期族から整数の算術を落とす」の SageMath 検証を完了した。軌道長 1・3・5 の
有限周期後続系について、定数配位、奇数軌道の有限積による矛盾、全辺破れ配位の不在、端点多重度の
不一致を `ZZ` と全配位の有限列挙で一段ずつ確認した。status は `記述と SageMath まで` で、
次の tick は Lean 具体版を行う。

2026-08-15 のレビューのみの tick で「周期族から整数の算術を落とす」の記述を照合し不備なしを確認した（SageMath 検証は未着手。次の tick で行う）。

2026-08-15 に「周期族から整数の算術を落とす」を記述した。有限集合・方向の有限集合・各方向の
軌道長が一定の置換だけから辺と多重度を定義し、軌道長が奇数なら全辺破れ配位が存在せず、
定数配位との比較で多重度が回文でないことを有限積だけで示した。整数の加法・順序・座標・剰余類と
禁止された脱出は使っていない。status は `記述まで` で、次の tick は SageMath 検証を行う。

2026-08-15 のレビュー（レビューのみの tick）で、上記の必要十分版の多重集合結合・個数の段と
具体版最終定理の導出を照合し、仮定が具体版の使う性質だけであることを確認した（不備なし）。
次の tick は「周期族から整数の算術を落とす」の記述に着手する。

2026-08-15 に「既約分解の型が決める零点の最小多項式次数」の Lean 必要十分版を完了した。
各因子の零点多重集合・指数・濃度・各零点の次数写像だけを仮定し、反復結合した多重集合の
次数ごとの個数公式を証明した。積多項式の零点多重集合に対する具体版の最終定理も、この抽象定理の
特殊化として導出した。四層が揃い、次は「周期族から整数の算術を落とす」である。

2026-08-15 のレビューで、「既約分解の型が決める零点の最小多項式次数」の Lean 必要十分版
（`NecSuf/NullModel/IrreducibleFactorRootDegrees.lean`）が、具体版の最終定理
`irreducibleFactorProduct_count_rootMinimalPolynomialDegree`（積多項式の零点多重集合の個数公式）を
抽象化していないことを確認した。次の tick は、各因子の零点多重集合・その濃度・各零点の次数写像だけを
仮定して個数公式を出す段を必要十分版へ追加し、具体版の最終定理をその特殊化として導出する
（status は `Lean 具体版まで`）。

2026-08-15 に「既約分解の型が決める零点の最小多項式次数」の Lean 具体版へ、
積多項式の根の多重集合が各既約因子の根を指数回反復した多重集合の結合に一致する補題
（`irreducibleFactorProduct_roots_eq_bind`）を追加した。次はこの多重集合上で最小多項式次数ごとの個数を数え、
本文の最終定理へ結合する。status は結合完了まで `記述と SageMath まで`のままとする。

2026-08-15 の次の tick でも差し戻しを再確認した（レビューのみ）。結合作業は未着手。

2026-08-15 のレビューで、「既約分解の型が決める零点の最小多項式次数」の Lean 具体版の
完了判定を取り消した。最終定理は因子ごとにタグ付けした零点対を数えるだけで、本文の
「相異なる因子は零点を共有しない」と「因子指数が積多項式での代数的重複度になる」を結合していない。
用意済みの重複度補題と零点非共有補題を最終定理へ組み込み、積多項式の全零点を重複度込みで
ちょうど一度数える Lean 具体版へ直すことが次の作業である。status は `記述と SageMath まで`。

2026-08-15 に「既約分解の型が決める零点の最小多項式次数」の Lean 必要十分版（`NecSuf/NullModel/IrreducibleFactorRootDegrees.lean`）と
導出（`NullModel/IrreducibleFactorRootDegreesFromNecSuf.lean`）を追加し四層が揃った（no-sorry 66 件、status done）。

2026-08-15 のレビュー tick で結合定理を本文と照合し不備なしを確認した。結合定理は零点を因子ごとの対として
数えるため零点非共有の補題を使わない（積の零点集合との同一視だけが使う）。必要十分版でもこの区別を保つ。

2026-08-15 に「既約分解の型が決める零点の最小多項式次数」の Lean 具体版で、実際の零点集合と
有限数え上げの型を全単射で結び、既約性・モニック性から最小多項式次数を因子次数へ書き換えて、
本文の主張全体を一本の定理に結合した（no-sorry 登録 64 件）。次の tick は Lean 必要十分版と導出を行う。

2026-08-15 に「既約分解の型が決める零点の最小多項式次数」の Lean 具体版へ、相異なるモニック
既約因子が零点を共有しない補題（`irreducible_monic_eq_of_common_root`）を追加した（no-sorry 登録 63 件）。
代数段の四つの部分はそれぞれ形式化済み。残るのは有限数え上げ段の定理と代数段の補題を結合して
本文の主張を一本の定理にすること。次の tick がそれを行い、済めば `Lean 具体版まで` へ進める。

2026-08-15 に「既約分解の型が決める零点の最小多項式次数」の Lean 具体版へ、既約因子の
累乗における零点の代数的重複度が累乗指数に等しい補題を追加した（no-sorry 登録 62 件）。
残る代数段は、相異なる既約因子が零点を共有しないことである。次の tick が同じ Lean 具体版を続ける。

2026-08-15 に「既約分解の型が決める零点の最小多項式次数」の Lean 具体版へ、標数 0 上の
既約多項式の分離性と代数閉体での分裂から、相異なる零点の個数が因子次数に一致する補題
（`irreducible_rootSet_card_eq_natDegree`）を追加した。残る代数段は因子指数と代数的重複度の一致、
および相異なる既約因子が零点を共有しないことである。次の tick が同じ Lean 具体版を続ける。
2026-08-15 の次 tick で、同ファイルの入れ子になった `namespace Ising3DCut.NullModel` を除去し
（補題が二重名前空間に置かれ no-sorry 登録名と食い違っていた）、標数 0 上の既約多項式を体へ
移したときの各零点の代数的重複度が高々 1 である補題（`irreducible_rootMultiplicity_le_one`）を
追加した（登録 61 件）。残る代数段は因子指数と代数的重複度の一致、および因子間の零点非共有。

2026-08-15 に「既約分解の型が決める零点の最小多項式次数」の Lean 具体版へ、代数段の第一歩として
モニック既約因子の零点の最小多項式次数が因子次数に一致する補題（`minpoly_natDegree_eq_of_irreducible_monic`）を
追加した。残る代数段は標数 0 での分離性（相異なる零点が因子次数個）と代数的重複度＝因子指数である。
次の tick が同じ Lean 具体版を続ける。

2026-08-15 に「既約分解の型が決める零点の最小多項式次数」の Lean 具体版の有限数え上げ段を追加した。
各既約因子の相異なる零点を因子次数で、各零点の反復を因子指数で有限添字化し、任意の次数が
代数的重複度込みで現れる回数を有限和として証明した。既約性から最小多項式・分離性・代数的
重複度を導く代数段は未形式化なので、次の tick が同じ Lean 具体版を続ける。

2026-08-15 の次 tick は着手前レビューで「既約分解の型が決める零点の最小多項式次数」の記述と
SageMath 検証を点検し、本文と検証 13 項目の対応、および検証全通過を確認したが、残り時間が
足りず Lean 具体版には着手しなかった（レビューのみ）。次の tick が同セクションの Lean 具体版を行う。

2026-08-15 に「既約分解の型が決める零点の最小多項式次数」の SageMath 検証を追加した
（`sagemath/check/irreducible-factor-root-degrees/`）。$6(X^2+1)^2(X^3-2)$ について、既約因子の
次数、相異なる零点の個数、最小多項式次数、因子指数と代数的重複度の一致、最終的な次数多重集合を
`ZZ`・`QQbar` の厳密計算で確認した。次の層は Lean 具体版である。

2026-08-15 に「既約分解の型が決める零点の最小多項式次数」を記述した。各既約因子 $P_j$ は
標数 0 上で $\deg P_j$ 個の相異なる零点を持ち、その最小多項式次数は $\deg P_j$、各零点の
代数的重複度は因子の重複度 $e_j$ である。したがって次数 $\deg P_j$ が $e_j\deg P_j$ 回現れる
多重集合は既約分解の型だけで決まる。次の層は SageMath 検証である。

2026-08-15 の次 tick は着手前レビューで「判別式だけでは多項式を決めない」の Lean 必要十分版と
導出を点検し、仮定が具体版の使う性質だけであることと証明順序の一致を確認し、検証
（npm run check・lake build・no-sorry・linkage）を再実行して全通過・不備なしを確認したが、
残り時間が足りず「既約分解の型が決める零点の最小多項式次数」の記述には着手しなかった
（レビューのみ）。次の tick が同セクションの記述を行う。

2026-08-15 に「判別式だけでは多項式を決めない」の Lean 必要十分版と導出を完了し、四層が
揃った。必要十分版は多項式・整数・係数公式を仮定せず、二対象を区別する観測、相異なる二因子への
分解を表す述語、判別式データだけへ縮約した（検査対象は計 57 件）。次の先頭未完了セクションは
「既約分解の型が決める零点の最小多項式次数」である。

2026-08-15 の次 tick は着手前レビューで「判別式だけでは多項式を決めない」の Lean 具体版を
本文と突き合わせ、四段の 1 対 1 対応を確認し、検証（lake build・no-sorry 55 件・
npm run check 55 ブロック・参照 59 件全解決・linkage 12 件）を再実行して全通過・不備なしを
確認したが、残り時間が足りず Lean 必要十分版には着手しなかった（レビューのみ）。
次の tick が同セクションの Lean 必要十分版と導出を行う。

2026-08-15 に「判別式だけでは多項式を決めない」の Lean 具体版を追加した
（`lean/Ising3DCut/NullModel/DiscriminantCounterexample.lean`）。二つの整係数二次式の相違、
相異なる一次因子への分解、係数公式による判別式の計算と一致を、人手証明と同じ順で形式化した。
次の層は Lean 必要十分版である。

2026-08-15 に「判別式だけでは多項式を決めない」の SageMath 検証を追加した
（`sagemath/check/discriminant-counterexample/`）。反例 $X^2-X$ と $X^2+X$ の証明の各段
（一次係数の相違、因数分解と square-free 性、判別式 $b^2-4ac$ がともに $1$）を
`ZZ`・`ZZ[X]` の厳密計算で確認し、すべて通過した。次の層は Lean 具体版である。

2026-08-15 に「判別式だけでは多項式を決めない」を記述した。相異なる整係数二次式
$X^2-X$ と $X^2+X$ はともに重複因子を持たず、square-free 部分は多項式自身であるが、
判別式はともに $1$ である。次の層は SageMath 検証である。

2026-08-15 に「分解体の次数と Galois 群だけでは多項式を決めない」の Lean 必要十分版と導出を
完了し、四層が揃った。必要十分版は多項式・有理数・体・自己同型を落とし、二つの対象と
データ写像の値の相違、分解の述語、次数の値、Galois 群の型の一元性だけへ縮約した
（検査対象は計 54 件）。次の先頭未完了セクションは「判別式だけでは多項式を決めない」である。

2026-08-15 に「分解体の次数と Galois 群だけでは多項式を決めない」の Lean 具体版を追加した。
二つの一次多項式の相違、有理根、$\mathbb Q$ 上での分解、分解体としての $\mathbb Q$ の次数 1、
$\mathbb Q$ の $\mathbb Q$ 自己同型が恒等写像だけであることを人手証明と同じ順で形式化した。
次の層は Lean 必要十分版である。

2026-08-15 に「分解体の次数と Galois 群だけでは多項式を決めない」の SageMath 検証を追加した
（`sagemath/check/splitting-degree-galois-group-counterexample/`）。反例 $X-1$ と $X-2$ の
証明の各段を `QQ`・`QQ[X]` の厳密計算で確認し、すべて通過した。次の層は Lean 具体版である。

2026-08-15 に「決定関係の表を埋める」を一論法ずつへ分割し、最初の
「分解体の次数と Galois 群だけでは多項式を決めない」を記述した。$X-1$ と $X-2$ がともに
分解体 $\mathbb Q$、次数 1、一元 Galois 群を持つ有限な反例である。次の層は SageMath 検証である。

2026-08-15 の次 tick は着手前レビューで「単変数化で潰れる情報の反例」の Lean 必要十分版と
導出を点検し、lake build と no-sorry 検査（51 件）・npm run check・linkage（10 件）を
再実行して全通過・不備なしを確認したが、残り時間が足りず「決定関係の表を埋める」には
着手しなかった（レビューのみ）。次の tick が同セクションに着手する
（着手時にまずセクションを 1 論法へ割り直す）。

2026-08-15 に「単変数化で潰れる情報の反例」の Lean 必要十分版と導出を完了した。
箱・頂点・辺・配位・破れ数・多項式を落とし、共通データ、二つの二点データ、係数写像、
係数の差と四つの有限数え上げだけへ縮約した。四層が揃い、次は「決定関係の表を埋める」である。

2026-08-15 に「単変数化で潰れる情報の反例」の Lean 具体版を追加した。
一辺 2 の自由境界箱を八つの二値と十二本の内部辺として直接定義し、隣接点対では破れ数 4 の
一致・不一致配位数が 20・10、対角点対では 12・18 であることを有限計算で証明した。
符号付き多項式の四次係数が 10 と -6 で異なることまで形式化した。次の層は Lean 必要十分版である。

2026-08-15 に「単変数化で潰れる情報の反例」の SageMath 検証を追加した
（`sagemath/check/same-partition-different-pair-data/`）。$L=2$ の全 $2^8$ 配位の有限列挙で、
分配多項式が標識に依らないこと、破れ数 4 の一致・不一致配位数（20/10 と 12/18）、
四次係数 $10$ と $-6$ による多項式の不一致を `ZZ`・`ZZ[X]` で厳密に確認した。
次の層は Lean 具体版である。

2026-08-15 に「単変数化で潰れる情報の反例」を記述した。自由境界の $L=2$ の同じ箱で、
隣接点対と対角点対を標識した二つのデータは同じ分配多項式を持つが、点対の一致配位数と
不一致配位数の差を係数とする整係数多項式の四次係数が $10$ と $-6$ になる。

## 旧ゴールでの到達点（2026-08-13）

プロジェクトを作成し、本文の最初の版を構造化テキストで書いた。PDF は 8 ページで組めている。
内容は次の五章である。

- **有限箱と配位**：格子点・隣接・箱・内部辺・境界辺・配位・破れ数を定義した。
  箱の外側は $+1$ に固定し、それを破れ数の定義の中だけで使う。
- **分配多項式と原点が負である割合**：$Z_L(x)$ と $N_L(x)$ を $\mathbb{Z}[x]$ の元として定義し、
  有理点で $Z_L(q)\ge1$ を示して $R_L(q)=N_L(q)/Z_L(q)\in\mathbb{Q}$ が定まることを示した。
  この量を確率とも期待値とも呼んでいない。
- **原点を箱の外から分離する辺集合**：道と分離集合を定義し、
  原点が負である配位の破れ辺集合が分離集合を含むことを証明した（これは証明済み）。
  さらに、辺集合を避けた到達集合 $W_F$ と辺境界 $\partial W$ を定義し、
  **極小分離集合が $F=\partial W_F$ を満たすこと**を両包含で証明した（2 tick 目。証明済み）。
  分離集合と極小分離集合は、個別に参照できる独立した定義ブロックとして置いてある。
  これが指数上界（Peierls の数え上げ）の土台になる。
- **格子辺に双対な面**：格子辺の向きと始点が一意に定まることを示し、双対面を
  $\mathbb{Q}^3$ の四頂点の集合として定義した。二面の共通頂点が二つなら面隣接すると定めた。
  三つの座標方向、端点順序の不変性、隣接例と非隣接例を SageMath の厳密演算で検算済み。
- **低温側の証拠と未解決問題**：証拠を「自然数 $C$ と有理数 $q$ の組で、
  極小分離集合の個数が $C^n$ で抑えられ、かつ $3Cq\le1$ を満たすもの」と定義し、
  証拠があれば $R_L(q)\le1/2$ が箱の大きさに依らず成り立つことを示した。

**未証明の主張が 2 つある。** 極小分離集合の個数の指数上界と、Peierls の反転写像による
$R_L(q)$ の上界である。どちらも本文に `todo` を残してあり、それらに依存する主張
（証拠から一様な上界を得る主張）には依存していることを本文に明記してある。
**SageMath 検証は双対面の頂点集合の 1 件が完了している。**

**Lean の置き場所は用意済み（2026-08-13）。** `lean/`（具体版 `Ising3DCut`、必要十分版
`Ising3DCut/NecSuf`）、`lean/scripts/check-no-sorry.sh`、`lean/README.md` があり、
mathlib は 2 次元側と同じ v4.32.1 に固定して `lake build` と検査が通る状態にしてある。
2026-08-14 に「辺の両端の座標和の偶奇」の具体版・必要十分版・導出を初めて形式化し、
入口と検査スクリプトへ 3 定理を登録した。

**セクション完了の条件は四層すべて**（記述・SageMath・Lean 具体版・Lean 必要十分版）である。
2 次元側と同じ運用であり、2026-08-13 のユーザー指示で確定した。Lean は 1 tick に 1 主張が上限。

## この プロジェクト固有の注意

- **立場が姉妹プロジェクトより強い。** 許される非可算への脱出は箱の大きさの極限だけである。
  上限・下限・積分・微分・無限和・級数・指数関数・実対数・逆温度の記号を使わない。
  相・臨界温度・自発磁化などの無限体積の語を主張に使わない。
- **$\mathbb{R}$ 側の定理から含意を借りない。** Duminil-Copin–Tassion の判定条件も
  Peierls の古典的な議論も、結論だけを持ってこない。有限箱の主張として作り直す。
- 2 次元側（`exact-solution-of-2d-ising-model-lambda`）の計算を引き写さない。
  道具立ては共有するが、立場が違うので毎回この立場で書けるかを問う。

## 次回やること

- **2026-08-24 12:06（最新）: 「末尾定数性を分配多項式の冪等式へ言い換える」を四層で閉じた。** 必要十分版はモノイド上の列、非零指数、指定集合上での冪写像の単射性、自然数添字の帰納法だけを使う。次の tick は「末尾で定数になる正の有理点を分類する（冪等式の判定）」の記述層から進める。台帳「現在地」先頭を参照。

- **2026-08-23 18:36（最新）: 「可算コアは素指数データと一対一に対応する」の Lean 具体版を書いて通した（status `Lean 具体版まで`）。** 次の tick は同セクションの Lean 必要十分版と具体版への導出。素指数データの写像が値の衝突を持たないこと（素因数分解の一意性）は具体版では仮定として置いているので、その導出も残っている。台帳「現在地」先頭を参照。

- **2026-08-17 11:02（最新）: 「対称化した極限量に対して粗視化は必要でない」の主張 `claim_coarse_graining_not_necessary_for_symmetrized_limit_quantity` を記述（status `記述まで`）。** 次の tick は同主張の SageMath 検証（$L=2,3$・有理点で $Z_L(q)\neq Z_L(1/q)$ と対称化した列の項の一致）。台帳「現在地」先頭を参照。

- **2026-08-16（最新）: 健全性の橋は「有限箱の列の定義」「極限量の定義（乗根形、唯一の脱出）」「極限量が列だけの関数」の三つまで記述済み。** 次の tick はまず前 tick の懸案「正の実数乗根と実対数のどちらを極限量の正本にするか」を判定し、`claim_limit_quantity_depends_only_on_finite_box_sequence` をレビューしてから、本流の次（極限の存在の証明、または有限箱の言明を極限量の言明へ渡す定理）へ進む。台帳「現在地」先頭を参照。

- **2026-08-16: 標的を二本立てへ組み直した（ユーザーの判断）。**
  **本流は「健全性の橋」**（極限量を定義し、有限箱の主張からその言明へ渡す定理を自作し、
  十分／必要でないの判定を極限量に対して書き下す）。**並行ストリームは「測定量の事前予言」**
  （辺変数を 1 に置かない境界応答多項式について、2 次元の閉形式から測定の前に代数的命題を
  導く。導けなければ候補から落として記録する）。1 tick で本流 1 件、時間が残れば並行 1 件。
  **帰無モデルは並行の相方ではない**（回文性・$Z_L(1)$・係数の非負性・台の両端・
  Galois 群の上限はすべて確定済み）。
  **todo が尽きても小主張を自作しない。** 戻り先は
  [可算コアの同定とは何か.md](../docs/discussion/3次元Isingを可算側で書く/可算コアの同定とは何か.md)。
  この規定が無かった 2026-08-16 は、多変数分配多項式の初等的な性質を自作して四層で証明し続け、
  証明の本数だけが増えていた。同定の判定（十分／必要でない）はどちらも極限量を参照するので、
  **橋が架かるまで何を測っても「潰れた」と判定できない**。

- （2026-08-16 16:00 の tick）「全次数は辺の総数に等しい」の Lean 具体版の前半（全次数 ≤ #E、`fullBoundaryResponse_totalDegree_le_card_edge`）を形式化。次は後半（全辺の単項式の係数 ≥ 2 から全次数 = #E）を示して Lean 具体版を閉じる。

- （2026-08-16 15:00 の tick）「真に依存する」の Lean 具体版を閉じた（`fullBoundaryResponse_degreeOf_eq_one`）。次は同主張の Lean 必要十分版と具体版からの導出。

- （2026-08-16 14:45 の tick）「真に依存する」の Lean 具体版の第二歩（$\tau$ の単項式の係数が 1 以上、`fullBoundaryResponse_one_le_coeff_brokenMonomial`）を形式化。次はこれと `degreeOf_le_one` から次数ちょうど 1 を示して Lean 具体版を閉じる。

- （2026-08-16 02:30 の tick）間隔 15 分では前進 tick が来ない件を台帳の引き継ぎに人間判断待ちとして
  記した（8 tick 連続レビューのみ）。次は「外箱の拡大に対する境界応答多項式の安定性」の記述。

- 2026-08-16 00:45〜01:45 開始の各 tick（レビューのみ）: 検査・SageMath 検証対応 16 件・立場違反語走査・PDF 生成を
  確認し不備なし。次の tick は「外箱の拡大に対する境界応答多項式の安定性」の記述（`todo` → `記述まで`）。
- 2026-08-16 00:30 開始: 検査を再実行して不備なし。台帳へ「外箱の拡大に対する境界応答多項式の安定性」
  （内箱の近傍が外箱に収まれば $R_{L'',L'}=2^{\#V_{L''}-\#V_L}R_{L,L'}$、有限和の分割 1 論法）を
  `todo` で切り出した。次の tick はその記述に着手する。示されれば境界応答多項式は外箱に依存せず、
  極限情報を持たない可能性が高いので、そのあとは測定量の選び直しを再度切り出す。
- 2026-08-15 23:15 開始（レビューのみの tick）: 検査・SageMath 検証対応・Lean 未証明依存検査・PDF 生成を
  確認し不備なし。次の tick は「測定量の選び直し」の Lean 必要十分版と具体版からの導出を行う。
- 2026-08-15 22:45 開始（レビューのみの tick）: 検査・SageMath 再実行・PDF 生成を確認し不備なし。
  次の tick は「測定量の選び直し」の Lean 具体版（多変数分配多項式・有限代入・環準同型を人手証明と
  1 対 1 に）を行う。
- 2026-08-15: 「小さい箱での厳密測定」は候補が残らなかったため計算対象なしとして完了した。
  次の tick は「測定量の選び直し」を進める。
- 2026-08-15（レビューのみの tick）: 「2 次元からの事前予言」が四候補を落としただけで残った量を明示しておらず、
  次の「小さい箱での厳密測定」の対象が本文上で未定義と判明。次の tick は測定対象を確定するセクションを台帳へ
  割り出してから着手する（台帳「引き継ぎ」参照）。
- 2026-08-15（レビューのみの tick）: 「零点と係数データが決める多項式」の Lean 必要十分版と導出を確認（不備なし、`done`）。
  次は「2 次元からの事前予言」に着手する。
- 2026-08-15（レビューのみの tick）: 「周期族から整数の算術を落とす」の Lean 必要十分版を確認（不備なし、`done`）。
  次は「零点と係数データが決める多項式」の記述に着手する。
- 2026-08-15（レビューのみの tick）: 積多項式の零点多重集合の結合補題を確認（不備なし）。
  次は同補題を「既約分解の型が決める零点の最小多項式次数」の最終定理へ接続する。
[docs/tasks/auto-loop-state.md](docs/tasks/auto-loop-state.md) のセクション台帳が正本である。
2026-08-15 に、周期族の頂点へ $\mathbb Z/L\mathbb Z^3$ の代数構造を持たせる流儀を検討し、
**採らないと決めた**（証明が使っているのは「後続を $L$ 回で戻る」と「$L$ が奇数」だけで、
剰余環の乗法・商の構成・平行移動の群は使っていない）。代わりに、有限二部後続系の部分単射を
「軌道の長さが $L$ の置換」へ強める形で一般化する。理由・採るべき条件・
「説明に効く道具と証明に要る道具は別」という観察は
[不要な構造を持ち込まない.md](../docs/discussion/3次元Isingを可算側で書く/不要な構造を持ち込まない.md)
の「周期族に群構造を持たせる筋」にある。台帳へ「周期族から整数の算術を落とす」を追加した。
次の tick は「単変数化で潰れる情報の反例」の Lean 必要十分版と、具体版からの導出を行う。
2026-08-15 の次 tick は着手前レビューで同セクションの Lean 具体版を本文と突き合わせ、
lake build と no-sorry 検査（49 件）を再実行して全通過・不備なしを確認したが、残り時間が
足りず Lean 必要十分版には着手しなかった（レビューのみ）。次の tick が必要十分版と導出を行う。
2026-08-15 の次 tick は着手前レビューで「有理点の値が多項式を決めること」の Lean 必要十分版と
導出を点検し、lake build と no-sorry 検査（48 件）を再実行して全通過・不備なしを確認したが、
残り時間が足りず「単変数化で潰れる情報の反例」の記述には着手しなかった（レビューのみ）。
次の tick が同セクションの記述を行う。
2026-08-15 に「有理点の値が多項式を決めること」の Lean 必要十分版と導出を完了し、四層が揃った。
必要十分版は多項式・有理数・素因数分解を落とし、データ写像の単射性、根の構成、根の個数上界だけへ
縮約した。次は「単変数化で潰れる情報の反例」の記述である。
2026-08-15 に「有理点の値が多項式を決めること」の Lean 具体版の不備を修正した。
一意性全体を既製定理へ委ねず、差多項式が相異な標本点を根に持つ段と、根の個数が
次数上界を超えるため差が零多項式になる段を別補題に分けた。次の層は Lean 必要十分版である。
2026-08-15 の次 tick は着手前レビューで「有理点の値が多項式を決めること」の Lean 具体版を
人手証明と突き合わせ、lake build と no-sorry 検査（46 件）の全通過を確認したが、
一意性の段（差の多項式の根の個数と次数の比較の二段）が mathlib の既製定理
`Polynomial.eq_of_natDegree_lt_card_of_eval_eq` へ丸ごと委ねられている不備を発見した
（1 対 1 対応の要件違反）。残り時間が足りず修正には着手しなかった（レビューのみ）。
次の tick はまずこの段を自前の二段で書き直してから、Lean 必要十分版へ進む。
2026-08-15 に「有理点の値が多項式を決めること」の Lean 具体版を追加した。素指数データの
単射性から評価値の一致を得る段と、相異なる次数より一つ多い有理点で一致する次数以下の
多項式が等しいことを形式化した。次の層は Lean 必要十分版である。
2026-08-15 の次 tick は着手前レビューで「有理点の値が多項式を決めること」の SageMath 検証を
再実行して PASS を確認し、npm run check（48 ブロック・参照 56 件全解決）と linkage（9 件）も
全通過・不備なしを確認したが、残り時間が足りず Lean 具体版には着手しなかった（レビューのみ）。
次の tick が同セクションの Lean 具体版を行う。
2026-08-15 に「有理点の値が多項式を決めること」の SageMath 検証を追加した。
自由境界の $L=1,2$ について、正の有理点での値の正値性、有限台の素指数データから値への復元、
相異なる $\#E_L+1$ 点での値による `QQ[X]` 上の補間と一意性を厳密に確認した。
次の層は Lean 具体版である。
2026-08-15 の次 tick は着手前レビューで「有理点の値が多項式を決めること」の記述を点検し、
npm run check（48 ブロック・参照 56 件全解決）と linkage（8 件）を再実行して全通過・
不備なしを確認したが、残り時間が足りず SageMath 検証には着手しなかった（レビューのみ）。
次の tick が同セクションの SageMath 検証を行う。
2026-08-15 に「有理点の値が多項式を決めること」を記述した。正の有理数の素指数データを
有限台の整数列として定義し、素因数分解の一意性と多項式の根の個数評価だけを使って、
相異なる $\#E_L+1$ 個の正の有理点でのデータが分配多項式を一意に決めることを示した。
次の層は SageMath 検証である。

2026-08-15 の次 tick は着手前レビューで「Galois 群の上限」の Lean 必要十分版と導出を点検し、
lake build と no-sorry 検査（45 件）を再実行して全通過・不備なしを確認したが、残り時間が
足りず「有理点の値が多項式を決めること」の記述には着手しなかった（レビューのみ）。
次の tick が同セクションの記述を行う。
2026-08-15 に「Galois 群の上限」の Lean 必要十分版と具体版からの導出を完了し、四層が揃った。
必要十分版は群の忠実な置換作用、不動点のない対合、両者の可換性だけを残した。
次の先頭未完了セクションは「有理点の値が多項式を決めること」である。
2026-08-15 に「Galois 群の上限」の Lean 具体版の忠実性の不備を修正した。忠実性を仮定として
受け取るのをやめ、非固定根が分解体を生成することから、根上で一致する二つの代数自己同型が
生成される部分代数の全元で一致することを証明した。次の層は Lean 必要十分版である。
2026-08-15 に「Galois 群の上限」の Lean 具体版を完了した。非固定根上の逆数対合、Galois
自己同型による根の置換、逆数との可換、根への作用の忠実性を人手証明と同じ順で形式化した。
次の層は Lean 必要十分版である。
2026-08-15 の次 tick のレビューで、この具体版が人手証明の証明している「根への作用の忠実性」
（分解体が根で生成されるから全根を固定する自己同型は恒等写像）を仮定 `hfaithful` として
受け取っており、この段が形式化されていない不備を発見した（検証は全通過だが 1 対 1 対応の
要件違反）。次の tick はまず忠実性の段を具体版の中で証明してから、Lean 必要十分版へ進む。
2026-08-15 の次 tick は着手前レビューで「Galois 群の上限」の SageMath 検証 4 本を再実行して
すべて通過・不備なしを確認したが、残り時間が足りず Lean 具体版には着手しなかった
（レビューのみ）。次の tick が「Galois 群の上限」の Lean 具体版を行う。
2026-08-15 に「Galois 群の上限」の SageMath 検証を完了した。$L=1,2$ の実際の分配多項式で
回文性、非零根の逆数閉性、固定根を除いた二元対分割を確認し、$L=2$ の分解体の全自己同型で
逆数対の保存と作用の忠実性を厳密に検証した。次の層は Lean 具体版である。
2026-08-15 の次 tick は着手前レビューで「Galois 群の上限」の記述の不備 1 件
（逆数が根であることの導出で α^{#E_L}≠0 で割るステップの省略）を修正し、
npm run check と linkage の全通過を確認した。残り時間が足りず SageMath 検証には
着手しなかった（レビューと修正のみ）。次の tick が「Galois 群の上限」の SageMath 検証を行う。
2026-08-15 に「Galois 群の上限」を記述した。回文性から相異なる非固定根が逆数対へ分かれ、
分解体の Galois 群が逆数対を保つ置換群へ単射になることを示した。`-1` が根になり得る場合と
重複根を正しく扱うため、有理な固定根を除いた相異なる根の集合を明示した。次の層は SageMath 検証である。
2026-08-15 の次 tick は着手前レビューで「全スピン反転による多重度の偶数性」の Lean 必要十分版と
導出を点検し、lake build と no-sorry 検査（42 件）を再実行して全通過・不備なしを確認したが、
残り時間が足りず「Galois 群の上限」の記述には着手しなかった（レビューのみ）。
次の tick が「Galois 群の上限」の記述を行う。
2026-08-15 に「全スピン反転による多重度の偶数性」の Lean 必要十分版と導出を完了し、四層が揃った。
必要十分版は有限型上の不動点のない対合だけを仮定し、二元軌道への分割を具体版と同じ順で示す。
次の先頭未完了セクションは「Galois 群の上限」である。
2026-08-15 に「全スピン反転による多重度の偶数性」の Lean 具体版を修正した。
一般の置換の不動点定理への依存を除き、水準集合を明示的な二元軌道の互いに素な族へ分割して
個数を有限和で数える、人手証明と同じ最終段へ置き換えた。次の層は Lean 必要十分版である。
2026-08-15 に「全スピン反転による多重度の偶数性」の Lean 具体版まで完了した。
全スピン反転が破れ辺集合と破れ数を保つ不動点のない対合であり、各破れ数の水準集合が
二元軌道へ分割されることを、$L=1,2$ の全配位について有限集合と `ZZ` だけで一段ずつ確認した。
Lean では対合性、破れ辺集合と破れ数の不変性、原点での不動点不存在、水準集合上の位数 2 の置換、
固定点が無いことによる多重度の 2 の倍数性を人手証明と同じ順で形式化した。次の層は Lean 必要十分版である。
2026-08-15 の次 tick のレビューで、この Lean 具体版の最終定理が偶数性を mathlib の
素数冪位数の置換の不動点定理へ委ねており、人手証明の「二元軌道への分割」を自前で
形式化していない不備を発見した（1 対 1 対応の要件違反）。次の tick はまずこの最終段を
二元軌道の分割で書き直してから、Lean 必要十分版へ進む。
2026-08-14 の Lean 具体版 tick の着手前レビューで、README の辺定義に関する旧状態の記述と、
SageMath 検証に残っていた旧定義名・本文にない上付き記号を現行本文へ揃えた。本文の主張は変えていない。
2026-08-14 に帰無モデルの最初のセクション「二部性からの回文性」の記述と SageMath 検証を完了した。
本文冒頭に主標的の章を新設し、自由境界の族（外側に値を割り当てず内部辺だけを数える。
既存の外側固定の族とは別の族）を定義したうえで、座標和が奇数の側だけ反転する写像が
全単射で各内部辺の破れを反転することから
$\Omega^{\mathrm{free}}_L(m)=\Omega^{\mathrm{free}}_L(\#E_L-m)$ を証明した。
「奇数周期では回文でない」は別セクションへ割り出した（周期境界の族の定義が要るため）。
SageMath 検証（`sagemath/check/free-boundary-palindrome/`）は証明の各段を
$L=1,2$ の全数列挙で確かめ、回文性は $L=3$（配位 $2^{27}$）まで層転送の独立な方法で確認した。
Lean では最初の四主張「辺の両端の座標和の偶奇」「奇数側だけ反転する写像は全単射である」
「奇数側だけ反転する写像は各辺の破れを反転する」「奇数側だけ反転すると破れ数は補数になる」を、
それぞれ具体版・必要十分版・導出で形式化済み（検査への登録は計 15 定理）。
破れ数補数の形式化では、点と辺の有限性を全単射（点 ↔ 各座標の値の三つ組、
辺 ↔ 次の点も箱内にある始点と方向の組）から計算可能に構成し、破れ辺集合を有限集合の
filter として定義した。必要十分版は「辺の全体が有限」と「二条件が各辺で互いの否定」だけを仮定する。
2026-08-14 に五番目の主張「多重度は回文である」も同じ三層で形式化し、回文性のセクションは
四層すべてが揃って完了した。
2026-08-14 に「奇数周期では回文でない」の記述を書いた。周期境界の族（周期辺 $E^{\mathrm{per}}_L$ は
始点に条件を置かず、周期端点写像は端で第 $i$ 成分を 0 へ巻き戻す。量は上付き per で区別）を
別の族として定義し、定数配位から $\Omega^{\mathrm{per}}_L(0)\ge1$、方向 1 の一周 $L$ 辺の積
（全部破れているなら $(-1)^L$、同時に整数の二乗）から奇数 $L$ で
$\Omega^{\mathrm{per}}_L(\#E^{\mathrm{per}}_L)=0$ を示し、回文性が $m=0$ で崩れることを証明した。
この反例の SageMath 検証も追加した。奇数周期 $L=1,3,5$ の一周の全配位で積の証明を
一段ずつ確かめ、$L=1$ の周期箱の全配位で回文性が崩れること、$L=2$ の周期箱の全配位で
回文性が保たれることを `ZZ` の厳密計算で確認した。
2026-08-14 に「奇数周期では回文でない」の最初の主張「定数配位は周期辺を破らない」を
Lean で形式化した（具体版・必要十分版・導出。検査への登録は計 21 定理）。具体版で
周期辺・周期端点写像（端で 0 へ巻き戻す二分岐）・周期族の破れ数と多重度を定義したので、
二番目の主張「奇数周期ではすべての周期辺を破る配位は無い」も Lean で形式化した。
具体版は方向 1 の一周の隣接値がすべて異なることを全辺破れの仮定から導き、必要十分版は
奇数個の整数 ±1 の輪の有限積だけへ落とした。
三番目の主張「奇数周期では多重度は回文でない」も形式化した。具体版は前二主張から
Ω(0) ≥ 1 と Ω(#E) = 0 を引いて等しいと仮定した矛盾を取り、必要十分版は
「1 以上の自然数と 0 に等しい自然数は等しくない」だけへ落とした。導出を含めて
検査への登録は計 27 定理。これで「奇数周期では回文でない」のセクションは四層が揃い完了した。
2026-08-14 に「箱の定義から整数の算術を落とせるか」の記述を完了した。有限集合、三方向の
部分後続写像、辺の端点、二色塗り分けだけからなる有限二部後続系を定義し、片側の色だけで
符号反転する対合が破れ辺集合を補集合へ移すことから、多重度の回文性を証明した。整数の加法・
順序・座標和は使わず、部分後続写像の単射性も回文性そのものには不要だと判明した。
2026-08-14 に同セクションの SageMath 検証を完了した
（`sagemath/check/bipartite-successor-palindrome/`）。証明の四段（対合性・破れの反転・
補集合化・補数）と回文性を、一方向の道・整数の箱 L=2・succ が単射でない星の三つの系の
全数列挙で厳密に確かめた。箱 L=2 では多重度が自由境界の検証と一致することを校正し、
星の例で「単射性は回文性に不要」の観察も確認した。
次 tick の着手前レビューで、箱 L=2 の多重度が自由境界の検証と一致するという記録に対し、
検証コードが辺数と配位総数しか比較していない不備を見つけた。自由境界で得た多重度の
全係数との一致を明示的に検査するよう修正し、係数ごとの一致を確認した。
2026-08-14 に同セクションの Lean 具体版を完了した。有限二部後続系を人手証明と同じ具体度で
定義し、色 1 反転の対合性、各辺の破れの反転、破れ辺集合の補集合化、破れ数の補数、
水準集合の全単射、多重度の回文性を同じ順で形式化した。後続写像の単射性は定義に含むが、
証明では使わない。
2026-08-14 に同セクションの Lean 必要十分版と、具体版がその特殊化であることの導出を完了した
（`lean/Ising3DCut/NecSuf/StructuralCore/`。検査への登録は計 30 定理）。必要十分版は
方向の添字集合・始点の部分集合・後続写像とその単射性・値が整数 ±1 であることを仮定せず、
二つの端点写像を備えた有限な辺型、両端で色が異なる二色塗り分け、
値の反転が対合であること、反転後の不一致が反転前の一致と同値であることだけを仮定して、
具体版と同じ六段の順で回文性を示した。これで「箱の定義から整数の算術を落とせるか」の
四層が揃い、完了した。旧「値と台の恒等式」は四つの論法に分けた。
2026-08-14 に最初の「分配多項式の 1 での値」の記述を完了した。
自由境界の分配多項式を有限和で定義し、破れ数ごとの水準集合が配位集合を分割することから
$Z_L(1)=2^{\#V_L}$ を示した。
2026-08-14 に同セクションの SageMath 検証を完了した
（`sagemath/check/partition-value-at-one/`）。証明の四行を $L=1,2$ の全数列挙で
一行ずつ確かめ、$L=3$（配位 $2^{27}$）は層転送で $Z_3(1)=2^{27}$ を確認した。
多項式は `ZZ[X]` の元として作り、値と区別した。次の層は Lean 具体版である。
2026-08-14 に同セクションの Lean 具体版を完了した。
整数係数の分配多項式への 1 の代入、多重度の有限和、水準集合による配位全体の分割、
各点への二値割当の数え上げを、人手証明の四行と同じ順で形式化した。
2026-08-14 に同セクションの Lean 必要十分版と導出を完了し、四層が揃って完了した
（検査への登録は計 33 定理）。必要十分版は有限型・自然数値の重み・重みの上界・
係数の半環だけを仮定して、水準多項式の 1 での値が全体の元の個数であることを
具体版と同じ順で示した。減法を使わないので整数係数は本質的でないと判明した。
2026-08-14 に「分配多項式の係数の非負性」を記述した。自然数
$m\in\{0,\ldots,\#E_L\}$ に対し、係数を取る写像の有限和に対する加法性と
多重度の定義から $[X^m]Z_L(X)=\Omega_L(m)\in\mathbb N$ を示した。
2026-08-14 に同セクションの SageMath 検証を完了した
（`sagemath/check/partition-coefficients-nonnegative/`）。証明の四行を $L=1,2$ の
全数列挙で全係数について一行ずつ確かめ、$L=3$（配位 $2^{27}$）は層転送で
全 55 係数の $[X^m]Z_3(X)=\Omega_3(m)\in\mathbb N$ を確認した。
2026-08-14 に同セクションの Lean 具体版を完了した。係数写像の有限和への加法性、
単項式の係数、クロネッカーのデルタの縮約、自然数の整数への埋め込みによる非負性を、
人手証明の四行と同じ順で形式化した。次の層は Lean 必要十分版である。
同日の次 tick は着手前レビューで Lean 具体版に不備なしを確認したが、残り時間が足りず
必要十分版には着手しなかった（レビューのみ）。次 tick が必要十分版を行う。
2026-08-14 に同セクションの Lean 必要十分版と導出を完了し、四層が揃った
（`lean/Ising3DCut/NecSuf/NullModel/PartitionCoefficientsNonnegative.lean` と
`lean/Ising3DCut/NullModel/PartitionCoefficientsNonnegativeFromNecSuf.lean`。検査への登録は計 36 件）。
必要十分版は点・辺・値 ±1・破れ数を仮定せず、有限型上の自然数値の重み、有限和の上端、
半環上の水準多項式だけで係数と水準集合の個数の一致を示し、非負性の行だけ整数へ特殊化した。
次の先頭未完了セクションは「分配多項式の台の両端」で、次の層は記述である。
同日の次 tick は着手前レビューで必要十分版と導出に不備なしを確認したが、残り時間が足りず
「台の両端」の記述には着手しなかった（レビューのみ）。次 tick が記述を行う。
2026-08-14 に「分配多項式の台の両端」を記述した。相異なる二つの定数配位から
$\Omega_L(0)\ge2$ を示し、二部性に基づく奇数側反転を適用した相異なる二つの配位から
$\Omega_L(\#E_L)\ge2$ を示した。係数と多重度の一致、および分配多項式を定める有限和の範囲から、
非零係数の最小次数は 0、最大次数は $\#E_L$ である。次の層は SageMath 検証である。
同日の次 tick は着手前レビューで「台の両端」の記述に不備なしを確認したが、残り時間が足りず
SageMath 検証には着手しなかった（レビューのみ）。次 tick が SageMath 検証を行う。
2026-08-15 に同セクションの SageMath 検証を完了した
（`sagemath/check/partition-support-endpoints/`）。定数配位二つの破れ数が 0 であること、
奇数側反転後の二配位が相異なり全辺を破ること、両端の多重度が 2 以上であること、
両端係数が非零で有限和の外側の係数が 0 であることを、$L=1,2$ の有限集合・`ZZ`・`ZZ[X]` で
一段ずつ厳密に確認した。次の層は Lean 具体版である。
同日の次 tick は着手前レビューで同検証（4 本）を再実行してすべて通過し不備なしを確認したが、
残り時間が足りず Lean 具体版には着手しなかった（レビューのみ）。次 tick が Lean 具体版を行う。
2026-08-15 に同セクションの Lean 具体版を完了した
（`lean/Ising3DCut/NullModel/PartitionSupportEndpoints.lean`。検査への登録は計 37 件）。
本文の $L\ge2$ を明示的な前提とし、定数二配位の相異性と破れ数 0、奇数側反転像の相異性と
破れ数 $\#E_L$、両端の多重度が 2 以上であること、係数と多重度の一致、有限和外の係数が
0 であることを人手証明と同じ順で形式化した。次の層は Lean 必要十分版である。
同日の次 tick は着手前レビューで Lean 具体版を本文と突き合わせ、lake build と no-sorry 検査
（37 件）を再実行して不備なしを確認したが、残り時間が足りず必要十分版には着手しなかった
（レビューのみ）。次 tick が Lean 必要十分版を行う。
2026-08-15 に同セクションの Lean 必要十分版と導出を完了し、四層が揃った
（`lean/Ising3DCut/NecSuf/NullModel/PartitionSupportEndpoints.lean` と
`lean/Ising3DCut/NullModel/PartitionSupportEndpointsFromNecSuf.lean`。検査への登録は計 39 件）。
必要十分版は格子・辺・値 ±1・定数配位・二部性を仮定せず、有限型上の自然数値の重み、
両端の水準集合の個数が 2 以上であること、有限和の範囲だけから、両端係数と範囲外係数を
具体版と同じ順で示した。次の先頭未完了セクションは「全スピン反転による多重度の偶数性」である。
同日の次 tick は着手前レビューで必要十分版と導出を点検し、lake build と no-sorry 検査（39 件）を
再実行して全通過・不備なしを確認したが、残り時間が足りず「全スピン反転による多重度の偶数性」の
記述には着手しなかった（レビューのみ）。次 tick が記述を行う。

## 自動ループ

- 2026-08-28 11:34（本流）: 「剰余類ごとの値が食い違うなら極限量は存在しない」の Lean 必要十分版と具体導出を追加し、四層を閉じた。Hausdorff 位相空間の一列に対し、無限へ飛ぶ二つの定数部分列が異なる値を持つことだけで極限の非存在が従う。次の本流はゴール文書から引き直す。

- 2026-08-27 23:34（本流）: 末尾周期的な正の有理点の分類を三つに割り、先頭として有理点 2 が末尾周期的にならないことを記述した。各箱の値が法 4 で 2 なので、周期冪等式の両辺に現れる素数 2 の指数 $(L+p)^3$ と $L^3$ が一致せず矛盾する。次は SageMath 検証。

- 2026-08-27 21:35（並行）: 各 city の残存端子の完全被覆を全 city にわたる内部辺集合へ束ね、terminal graph 全体の内部辺に含まれることを Lean で示した。次は既存の外部辺集合と合わせて完全マッチングを作る。

- 2026-08-27 21:33（本流）: 末尾周期性と、周期だけ離れた二箱の分配多項式について点数を交換した冪等式との同値を記述した（`claim_eventually_periodic_iff_power_identity`）。次は同主張の SageMath 検証。

- 2026-08-27 21:31（レビュー）: 末尾周期性の定義にあった未証明の「末尾定数性を真に含む」という結論を削り、周期 1 に固定すると末尾定数性に一致する一般化であることだけを述べる形へ修正した。周期が 1 より大きい非定数例の存在は主張しない。

- 2026-08-27 13:32（本流）: 自由境界の三次元箱の辺数を `card_edge` で閉じた。辺を方向と始点へ分け、固定方向の始点数を三方向について足して `3 * (L - 1) * L ^ 2` を得た。次はこの辺数と破れ数の多重度を有限箱等式へ入れ、偶数分母の素数二の非整除を接続する。

- 2026-08-26 22:33（本流）: 残る候補の有理点 2 分の 1 でも点数乗表示が末尾で成り立たないことを記述した。回文性による $2^{\#E_L}Z_L(1/2)=Z_L(2)$ と、有理点 2 の値が法 4 で 2 になることを合わせた有限計算である。次は同主張の SageMath 検証。

- 2026-08-26 20:37（並行）: 周期境界の平面正方格子で、一辺が二以上なら各頂点の出入り四辺が相異なることを Lean で閉じた。次はこの四辺が接続辺集合を尽くすことを示す。
- 2026-08-26 20:33（本流）: ゴール文書から「有理点 2 では点数乗表示は末尾で成り立たない」を引き直して記述した。破れ数ゼロと一の多重度から有限箱値が法 4 で 2 になる一方、正の整数の二乗以上は奇数か 4 の倍数なので点数乗表示に矛盾する。次は同主張の SageMath 検証。
- 2026-08-26 13:37（本流）: 「点数乗表示の底は閾値の箱の値から一意に決まる」の Lean 必要十分版と具体導出を追加して四層を閉じた。箱・有理数・順序・冪を落とすと、対象集合上で単射な一つの観測が同じ値を持つ二対象を区別することだけが残る。次は「底の従属性を整除へ代入して分子と箱の値を結ぶ」の記述。
- 2026-08-26 10:03（本流）: 「箱の大きさに依存しない整除から正の有理点一以外を排除できるか判定する」の SageMath 層を閉じた。任意の正の自然数の分子に対して底を分子に一を足した値として構成し、正値性・二倍した差の等式・最終整除を `ZZ` で一段ずつ確認した。次は同主張の Lean 具体版。

launchd は 15 分ごと（毎時 0/15/30/45 分）に呼び、**実際に走る間隔は tick 本体が決める**。
既定は 15 分で、中断（打ち切り・異常終了）が 2 回続くと 15→30→45→60 分と伸び、
正常終了すると 1 段戻る。1 tick の持ち時間は間隔から 3 分引いた長さで、間隔に連動して伸びる。
2 次元側のループ（毎時 5 分と 35 分）と衝突しないよう、**専用の git worktree**
（`~/git/masaori/math-ising-3d-cut-loop`）で作業して `origin/main` へ push する。
起動は `~/.local/bin/ising-3d-cut-loop-launcher.sh`（リポジトリ外）、ログは
`~/Library/Logs/ising-3d-cut-auto-loop/auto-loop.log`。詳細は runbook の「起動の仕組み」。
2026-08-15 に「既約分解の型が決める零点の最小多項式次数」の Lean 具体版で、有限積そのものの
零点多重集合へ最小多項式次数を写し、次数ごとの出現回数が既約因子の `指数 × 次数` の有限和に
一致する最終定理を追加した。前 tick の零点結合補題が本文の個数公式へ接続され、status は
`Lean 具体版まで`。次の tick は必要十分版がこの追加段も同じ手順で抽象化しているかを確認する。

2026-08-16 01:15・01:30 開始の各 tick はレビューのみ（検査・検証対応 16 件・立場違反語走査・PDF に不備なし）。
次の tick は「外箱の拡大に対する境界応答多項式の安定性」の記述に着手する。

2026-08-16 02:00 開始のレビューのみの tick では、検査・SageMath 対応・立場違反語走査・PDF に不備なし。
次の tick は「外箱の拡大に対する境界応答多項式の安定性」の記述（status `todo` → `記述まで`）に着手する。

2026-08-16 02:45 開始の tick で「外箱の拡大に対する境界応答多項式の安定性」を記述した（status `記述まで`）。
変数集合の一致 $A_{L'',L'}=A_{L,L'}$ と $R_{L'',L'}=2^{\#V_{L''}-\#V_L}R_{L,L'}$ を、代入の環準同型性と
配位の制限による全単射で示した（`npm run check` 71 ブロック、PDF 19 ページ）。次の tick は同セクションを
SageMath で検証する（例: $L'=1,L=2,L''=3$ の自由境界箱、`ZZ` 上の有限和）。
# 2026-08-18 12:03 tick

本流「既約分解の型は極限量に効かないか」を記述した。$Z_2$ の既約因子の次数・重複度の有限多重集合 $\{(1,4),(2,2),(4,1)\}$ と、ずらした族 $Z'_2=Z_3$ の $\{(1,14),(40,1)\}$ が異なる一方、末尾ずらしにより極限量が一致する反例である。次は既存の因数分解 check に新主張の対象ラベルを追加して SageMath 層を閉じる。
- 2026-08-24 08:02: 本流をゴール文書から引き直し、「有限箱の量が定数列になる正の有理点は一だけ」を記述した。箱一では常に値が二なので、定数列なら箱二で分配多項式の値が一点での値と一致し、非負係数と正次数の正係数による狭義単調性から有理点が一に決まる。次は同主張の SageMath 検証。
- 2026-08-24 08:06（並行）: 完全マッチングで外部辺として選ばれなかった元の辺の一方の端子は内部辺で覆われることを Lean で証明した。次はもう一方の端子と束ねる。
- 2026-08-19 13:33: 本流「零点集合は極限量に必要でない反例」の Lean 具体版を閉じ status `Lean 具体版まで`。$Z_2$ と $Z'_2=Z_3$ の零点の最小多項式次数集合 $\{1,2,4\}$・$\{1,40\}$ の不一致を決定計算し、末尾ずらし極限定理と束ねた `root_set_does_not_determine_limit_quantity` を形式化。レビュー修正なし、Lean build・sorry 検査通過。次 tick は Lean 必要十分版。並行はまとめ締切のため見送り。
- 2026-08-23 17:04: 本流「十分な粗視化は素指数データを復元する（左逆写像の構成）」の Lean 必要十分版と具体版への導出を閉じた。正の有理数・順序・代数構造を落とし、対象述語と対象上で衝突を持たない写像だけから、具体版と同じ五段で一意な復元写像を構成した。次 tick は「可算コアは素指数データと一対一に対応する」の記述から進める。
- 2026-08-24 01:03: 本流「実際の Ising 有限箱データ上で十分な粗視化の最小性を判定する」の非十分性の証人条件を Lean 具体版まで進めた。実際の分配多項式の有理点での値について、十分性の否定と「極限量が異なる二点が全ての正の箱で同じ粗視化値を持つ」ことの同値を本文と同順に証明した。次は Lean 必要十分版。
- 2026-08-24 10:33: 本流の未完了セクション「末尾で定数になる正の有理点を分類する」を、可算側への言い換えと、その上での判定の二つに割り、先頭の言い換えを記述した（`claim_eventually_constant_iff_power_identity`、status `記述まで`）。有限箱の量の列が末尾で定数であることは、ある閾値以後すべての箱で $Z_L(q)^{\#V_{L+1}}=Z_{L+1}(q)^{\#V_L}$ が成り立つことと同値であり、判定が正の実数乗根の比較から整数の等式へ移る。次は同主張の SageMath 検証。まとめ締切のため並行ストリームは見送った。
- 2026-08-25 05:06（本流）: 「破れ数ゼロの配位数が 2 であることを確定する」の定値性を必要十分化し、四層を閉じた。`NecSuf.NullModel.value_eq_root_of_rank_predecessor` は箱・辺・次元 3・スピン値を落とし、階数零の根の一意性と値を保つ低階数の前任点だけを仮定する。具体導出 `eq_zeroSite_value_of_brokenCount_zero_from_necSuf` は座標和と一座標を減らす辺を与える。次の本流は底の既約分母が 2 の冪であることから分母が一かの判定、並行は残った端子と外部辺の対応。
- 2026-08-25 10:35（本流）: 「破れ数がちょうど 1 の配位は存在しない」の Lean 具体版で、辺の向きを固定した連鎖の仮定は箱の正方形を渡せないと分かった（人手証明は四辺を向きと無関係につなぎ、一方の場合は三本目を、他方では一本目を逆向きに使う）。仮定を「辺が二点を結ぶ」向きによらない述語 `Connects` へ書き直し、`value_eq_of_connects_of_not_broken` を挟んで連鎖を組み直した。続けて後半の土台 `SquareAroundEdge.lean` を追加し、元と異なる方向を選ぶ `otherAxis`、一座標だけ増減する `shiftUp` / `shiftDown` とその成分の補題、二方向のずらしの可換性 `shiftUp_comm`、減らして増やすと戻る `shiftUp_shiftDown` を証明した。次は四隅と三辺を構成して連鎖の仮定へ渡し、多重度零まで閉じる。
- 2026-08-25 15:04（本流）: 「既約分母の 2 の指数が 1 の場合を判定する」の必要十分版からの導出を追加し、四層を閉じた。具体版が法 4 の評価と素因子指数の釣り合いから作る等式を、既存の抽象定理 `NecSuf.false_of_nontrivial_common_divisor_of_one_plus` へ渡した。箱・分配多項式・素因子分解を落とすと、1 より大きい共通因子が補正項と総量をともに割る一方で差が 1 になることの不両立だけが残る。次の本流は、分母が一に確定した底の形から正の有理点一以外を排除できるかの判定。
- 2026-08-25 18:33（本流）: 「分子は隣接する二つの箱の底の点数乗の差を割る」の Lean 具体版を追加した。既約分母 1 の有理数が分子と等しいこと（`eq_num_of_den_eq_one`）、既約分母 1 と破れ数ゼロの配位数 2 を法 $a$ の合同式へ入れて底の点数乗が 2 へ合同になること（`base_power_congr_two`）、隣接二箱の合同式から差の整除を出すこと（`dvd_base_power_difference_of_congr_two`）を人手証明の三段と 1 対 1 に並べ、全体を `rational_power_point_numerator_divides_base_power_difference` にまとめた。次は同主張の Lean 必要十分版。
- 2026-08-25 20:03（本流）: 「分子は頂点数差だけの点数乗から一を引いた数の二倍を割る」の SageMath 層を閉じた。隣接する三次元箱の頂点数差、二箱の合同を結ぶ変形、差の因数分解と整除を三つの `ZZ` 検査へ分けて全 PASS。次は同主張の Lean 具体版。
- 2026-08-25 20:06（並行）: 選ばれた端点・元辺の組の有限集合 `selectedEndpointIncidences` を定義し、その個数が頂点ごとの選択接続辺数の和に等しいことを `card_selectedEndpointIncidences` で示した。次は元辺への射影の各繊維が両端点の二元であることを示す。
- 2026-08-26 01:04（本流）: 「底の冪から 1 を引いた数は指数を自然数倍した冪から 1 を引いた数を割る」の Lean 必要十分版と具体導出を追加し、四層を閉じた。整数固有性を落とすと可換環の減法・積・自然数冪だけが残る。次は「底の冪から 1 を引いた数の最大公約数は指数の最大公約数に対応する」の記述。
- 2026-08-26 05:04（本流）: 「還元を繰り返して指数の最大公約数へ到達する」の Lean 必要十分版と具体導出を追加し、四層を閉じた。冪差・整数・最大公約数を落とすと、自然数で添字づけた値への可換な二項演算と指数差への一段還元だけが残る。次は「到達した形を底の指数の最大公約数乗から一を引いた数へ書き換える」の記述。
# Slack配送経路

- 2026-08-27 15:36（本流）: 有理点の分母を割る二以外の素数も、隣接二箱の有限和と整数等式から底の分母を割らないことを Lean 具体版で閉じ、全素数の非整除から底の既約分母を一に定めた。次はこの結論を最終分類定理へ渡す。

- 自動tickの報告は旧Workflow Builder triggerを使わず、`slack route-post math`が解決するHex-AIの明示routeだけへ送る。
- launchd の非対話環境でも上記経路を解決できるよう、tick の明示 PATH に `~/.agent-shims` を含める。対話シェルの初期化へ依存させない。
- 2026-08-27 18:34: 分母一・分母二の有限箱接続を `eq_one_of_cross_power_identity_from_free_box_numerator_connections` で束ね、箱に依存しない二つの分子整除から有理点を一に定める束ね定理の残る二仮定を閉じた。次はその二つの分子整除を先行する合同式から接続する。
- 2026-08-28 12:32: `claim_eventually_periodic_limit_quantity_only_at_one` の SageMath 層を追加した。剰余類値の全一致／相異なる二値の存在の排他的な場合分けと、全一致から末尾定数性を経て既存分類へ接続する有限算術を `ZZ`・`QQ` で検査し、二検査すべて PASS、linkage 102 件。次は同主張の Lean 具体版。
