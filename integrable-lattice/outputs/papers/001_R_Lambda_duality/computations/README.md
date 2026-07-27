# 検証計算への参照

**実体は `integrable-lattice/sagemath/check/<dir>/` に置いたままである。** ここにはパスと実行手順、
および論文の主張との対応を書く。

## 実行手順

各ディレクトリで次を実行する（SageMath 10.6）。

```bash
cd integrable-lattice/sagemath/check/<dir>
sage <script>.sage > <script>.out 2>&1
```

各ディレクトリは本プロジェクトの規約により **`README.md`（対象・手順・結論・限界）＋ 実行ログ `*.out`** をもつ。

## 対応の機械検証

論文の主張（構造化テキストのブロック）と検証ディレクトリの対応は、各ブロックの
`verification` フィールドで宣言する。対応が切れていないことは次で機械検証する。

```bash
cd integrable-lattice && node sagemath/tools/verify-check-linkage.ts
```

検査内容:

1. `verification` が指すディレクトリが**実在**すること
2. そのディレクトリが**規約**（`README.md` ＋ `.out`）を満たすこと
3. `sagemath/check/` の各ディレクトリが**少なくとも 1 つのブロックから参照**されていること
4. `lean` が指す定理名が Lean ソースに**実在**すること（`lean/` が無ければスキップ）

**本ツールは対応の生死だけを見る。数学的な正しさは見ない。**

## 対応表（本論文の主張 ↔ 検証ディレクトリ）

| 論文の主張（ラベル） | 検証ディレクトリ |
|---|---|
| `paper_claim_resultant`（終結式表示） | `cycle14_T1_vp_two_var`, `cycle15_T1_monsky_shape` |
| `paper_def_massieu`（Massieu Φ ∈ Λ） | `D_phi_lambda`, `potts_phi` |
| `paper_prop_A`（v_p の最終周期性） | `cycle3_T1_period_bound`, `D-U2_padic_law` |
| `paper_prop_B`（π(p,1) の精密公式） | `cycle3_T3_period` |
| `paper_prop_C`（周期の上界・Wall 反例） | `cycle3_T3_period` |
| `paper_prop_N`（Newton 多角形） | `D-U2_padic_law` |
| `paper_prop_L`（LTE） | `cycle7_T1_lte` |
| `paper_prop_D`（双対命題 D） | `cycle5_T1_mahler`, `cycle9_T1_spanning_tree`, `cycle15_T1_monsky_shape`, `cycle6_T1_padic_mahler` |
| `paper_prop_V`（Λ 側非自明性の判定） | `cycle14_T1_vp_two_var` |
| `paper_prop_T`（τ(L) の 2 進付値） | `cycle13_T1_tau_v2`, `cycle10_T1_vp_law`, `cycle14_T1_tau_general`, `cycle15_T3_tau_d3` |
| `paper_prop_W`（非退化塔の閉形式） | `cycle14_T3_two_var`, `cycle14_T3_Zl2_tower`, `cycle12_T3_nonzero_mu_p`, `cycle13_T3_criterion_proof` |
| `paper_remark_asymmetry`（決定可能性の非対称） | `cycle10_T3_lehmer` |

**20 / 27 ディレクトリが本論文の主張に紐づいている。**

## 本論文に紐づかない 7 件と、その理由

次の 7 件は `sagemath/check/` にあるが、**本論文の主張には紐づかない**。無理に参照を張らず、
理由をここに記録する。

| ディレクトリ | 紐づかない理由 |
|---|---|
| `C-U3_bethe_qqbar` | XXZ 鎖の有限 N スペクトルが $\overline{\mathbb{Q}}$ に住むことの実証。**paper-plan 001**（有限 N の可算決定可能性）の材料であって、本論文（ℝ/Λ 双対）の主張ではない |
| `apply_higher_spin_qqbar` | スピン1 Babujian–Takhtajan 鎖での同様の実証。同じく paper-plan 001 の材料 |
| `cycle3_T2_chiral_potts` | カイラル Potts の有限 N スペクトル。T2 トラック（未解決模型の厳密解）の探索で、本論文の射程外 |
| `cycle6_T2_superintegrable` | 超可積分点の Onsager 構造を Dolan–Grady 関係式で判定。T2 トラック |
| `cycle7_T2_dispersion` | Onsager 分散関係の抽出。T2 トラック |
| `cycle11_T2` | XXZ 2 マグノンの $\overline{\mathbb{Q}}$ 帰属。T2 トラック |
| `cycle12_T2_onsager_qqbar` | 2 次元 Ising Onsager 解の有限 L 構造の可算 Reframe。**T1 トラックだが対象が別**（Ising の転送行列であって、本論文の整数スペクトル曲線 $P$ の二素点ではない）。paper-plan 001 側の材料 |

**これらは削除しない。** 別の論文企画（`outputs/paper-plans/001_finite_N_decidable_unsolved.md`）の
根拠として生きているためである。`verify-check-linkage.ts` は孤立として報告するが、
これは「本論文に紐づかない」という事実の報告であって、エラーではない（終了コードは 0）。
