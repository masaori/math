/**
 * **散文の語の初出の全数走査**（検査 O の台帳が、本論文の定義する語彙をどれだけ覆っているかを
 * 台帳と独立な拾い方で測るための道具）。
 *
 * ## なぜもう一つ別の拾い方が要るのか
 *
 * 検査 O（`definition-order-model.ts`）は台帳（`definition-order-terms.ts`）に載せた語だけを追う。
 * 台帳は本文を人が読んで作ったので、その網羅性が検査の強さの上限になる。
 * cycle 29 は**記号**の側に台帳と独立な全数走査を足したが、あちらが見るのは数式ノードだけで、
 * **散文の語の初出は依然として台帳しか見ていなかった**。ここはその穴を埋める。
 *
 * ## 定義の位置をどう決めるか（機械で決まる形に絞る）
 *
 * 記号の走査が `:=` の左辺を定義の位置としたのと同じ発想で、**語を名づけている場所**を
 * 字面の規則だけで決める。日本語で採ったのは次の 4 つである。
 *
 * - `:=` を含む数式ノードの直前の地の文（「過渡欠損を $T_{\mathrm{def}}:=\dots$ と定める」）。
 * - 名づけの言い回し（「〜と呼ぶ」「〜であるという」「〜とは、」）の直前。
 * - 名づけの言い回しと同じ文にある鉤括弧の中身（「良い点」「悪い点」）。
 * - 定義ブロックの題（`kind` が `definition` のブロック）。題を「、」「・」「と」で割る。
 *
 * 英語は語順が違い、名づけた語が定義式の直前に来ない（"Define the vanishing depth of a
 * direction $P$ by $\theta(P):=\dots$" のように、語は動詞の直後で、定義式との間に別の数式が挟まる）。
 * そこで英語では**言い回しの直後**を取る。
 *
 * ## 語をどう切り出すか
 *
 * 日本語は分かち書きしないので、形態素解析なしに名詞句の左端を当てることはできない。
 * そこで**右端だけを信用する**——助詞・句読点・空白で区切り、末尾が平仮名で終わるものは
 * 語ではない（動詞・接続詞の断片である）として落とす。この規則は
 * 「ずれ指数」「過渡欠損」「消滅深度」を拾い、「したがって」「を取る」「と書き」を落とす
 * （どちらも実データで確認した）。左端は「を」「の」「と」の直後で切るので、
 * **左に付いた修飾は落ちることがある**（「$n$ 段目の全域木数」→「全域木数」）。
 *
 * ## 何を見ないか
 *
 * - 記号は見ない（そちらは `definition-order-symbol-model.ts` の担当）。
 * - 語の**意味**は見ない。同じ字面が別の対象を指していても区別できない。
 *   実際そういう例がある（命題 D の「塔」は円分塔、定義ブロックの「塔」はグラフ塔）ので、
 *   免除表に理由を書いて外す。
 * - 平仮名で終わる語（「voltage 割り当て」）は原理的に拾えない。
 */

/** 走査対象のブロック 1 つ分（文書順に並べたもの）。 */
export type VocabularyBlock = {
  readonly index: number;
  readonly id: string;
  readonly kind: string;
  readonly title: string;
  /** 題・主張・証明を文書順に並べたノード列。数式は `math` として位置だけ残す。 */
  readonly nodes: readonly { readonly kind: "text" | "math"; readonly value: string }[];
};

/** 語 1 つ分の走査結果。 */
export type VocabularyTrace = {
  readonly term: string;
  /** 名づけている場所。 */
  readonly definedAt: VocabularyBlock;
  /** どの手がかりで拾ったか。 */
  readonly via: string;
  /** その語が初めて現れたブロック。 */
  readonly firstAt: VocabularyBlock;
};

const HIRAGANA = /\p{Script=Hiragana}/u;
const DELIMITER = /[。、，；：（）()「」『』［］\[\]]/u;
const TRAILING_PARTICLE = /(?:を|は|が|の|に|で|と|も|へ|や|から|まで|より)+$/u;
const LEADING_PARTICLE = /^(?:を|は|が|の|に|で|と|も|へ|や)+/u;
const JAPANESE_TERM_CHARS =
  /^[\p{Script=Han}\p{Script=Katakana}\p{Script=Hiragana}A-Za-z0-9々ー・'′ _^{}\\Λℤℓ]+$/u;

/** 日本語の語として通す形か。**末尾が平仮名なら語ではない**というのが判定の中心。 */
export const isJapaneseTerm = (candidate: string): boolean => {
  if (candidate.length < 2 || candidate.length > 24) return false;
  if (!JAPANESE_TERM_CHARS.test(candidate)) return false;
  const last = [...candidate].at(-1)!;
  if (HIRAGANA.test(last)) return false;
  return [...candidate].some((c) => !HIRAGANA.test(c));
};

const cutAfterLast = (text: string, marks: readonly string[]): string => {
  let out = text;
  for (const mark of marks) {
    const at = out.lastIndexOf(mark);
    if (at >= 0) out = out.slice(at + mark.length);
  }
  return out;
};

/** 名づけの目印の直前から、日本語の語を 1 つ切り出す。 */
export const japaneseTermBefore = (head: string): string | undefined => {
  let s = head.replace(/\s+$/u, "");
  const quoted = /(?:「([^」]+)」|（([^）]+)）)$/u.exec(s);
  if (quoted !== null) s = (quoted[1] ?? quoted[2])!;
  else {
    s = s.replace(TRAILING_PARTICLE, "");
    for (let i = s.length - 1; i >= 0; i -= 1) {
      if (DELIMITER.test(s[i]!)) {
        s = s.slice(i + 1);
        break;
      }
    }
  }
  s = cutAfterLast(s.replace(TRAILING_PARTICLE, ""), ["を", "の", "と"])
    .replace(LEADING_PARTICLE, "")
    .trim();
  return isJapaneseTerm(s) ? s : undefined;
};

/** 英語で語句の左端に立てない語（冠詞・前置詞・定義の動詞）。 */
const ENGLISH_STOP_WORDS = new Set([
  "a", "an", "the", "of", "by", "for", "in", "on", "to", "with", "and", "or", "as", "is",
  "are", "be", "when", "which", "that", "this", "we", "its", "it", "at", "from", "into",
  "let", "put", "define", "denote", "call", "called", "set", "if", "then", "there", "all",
  "each", "every", "such", "here", "where", "whose", "than", "so",
]);

/** 名づけの言い回しの直後から、英語の名詞句を 1 つ切り出す。 */
export const englishPhraseAfter = (tail: string): string | undefined => {
  const sentence = tail.split(/[.;]/u)[0] ?? "";
  const words: string[] = [];
  for (const raw of sentence.trim().split(/\s+/u)) {
    const word = raw.replace(/[.,;:()"'`]/gu, "");
    if (word === "") break;
    if (/[$\\]/u.test(word)) break;
    if (ENGLISH_STOP_WORDS.has(word.toLowerCase())) {
      if (words.length > 0) break;
      continue;
    }
    words.push(word);
    if (words.length >= 4) break;
  }
  if (words.length === 0) return undefined;
  const phrase = words.join(" ");
  return phrase.length < 3 ? undefined : phrase;
};

const JAPANESE_NAMING =
  /と呼ぶ|と呼ばれる|と呼び|と定義する|と名づける|と名付ける|であるという|とは、/gu;
const ENGLISH_NAMING =
  /(?:is|are) called|we call|[Dd]efine the|[Dd]enote the|[Dd]enotes the/gu;

/** ブロック 1 つの中で、語を名づけている場所を全部返す。 */
export const namingSitesIn = (
  block: VocabularyBlock,
  locale: string,
): { readonly term: string; readonly via: string }[] => {
  const sites: { term: string; via: string }[] = [];
  // 数式ノードは位置だけ残して中身を伏せる。地の文の連結で語が偶然つながるのを防ぐ。
  const joined = block.title + " " + block.nodes
    .map((n) => (n.kind === "text" ? n.value : " § "))
    .join("");

  if (locale === "ja") {
    for (let i = 0; i < block.nodes.length; i += 1) {
      const node = block.nodes[i]!;
      if (node.kind !== "math" || !node.value.includes(":=")) continue;
      const previous = block.nodes[i - 1];
      if (previous === undefined || previous.kind !== "text") continue;
      const term = japaneseTermBefore(previous.value);
      if (term !== undefined) sites.push({ term, via: ":=" });
    }
    for (const match of joined.matchAll(JAPANESE_NAMING)) {
      const head = joined.slice(0, match.index).replace(/である$/u, "");
      const term = japaneseTermBefore(head);
      if (term !== undefined) sites.push({ term, via: match[0].trim() });
      // 同じ文に鉤括弧で並ぶ語（「良い点」、…「悪い点」と呼ぶ）。
      const sentence = head.slice(head.lastIndexOf("。") + 1);
      for (const quoted of sentence.matchAll(/「([^」]+)」/gu)) {
        if (isJapaneseTerm(quoted[1]!)) {
          sites.push({ term: quoted[1]!, via: `${match[0].trim()}（鉤括弧）` });
        }
      }
    }
  } else {
    for (const match of joined.matchAll(ENGLISH_NAMING)) {
      const term = englishPhraseAfter(joined.slice(match.index + match[0].length, match.index + 120));
      if (term !== undefined) sites.push({ term, via: match[0].trim() });
    }
  }

  if (block.kind === "definition" && block.title !== "") {
    const pieces = locale === "ja"
      ? block.title.split(/[、，・]|と(?=[^\s])/u)
      : block.title.split(/,| and /u);
    for (const piece of pieces) {
      const term = locale === "ja"
        ? piece.trim()
        : piece.trim().replace(/^[Tt]he /u, "");
      const ok = locale === "ja"
        ? isJapaneseTerm(term)
        : term.length >= 3 && !/[$\\]/u.test(term);
      if (ok) sites.push({ term, via: "定義ブロックの題" });
    }
  }
  return sites;
};

/** そのブロックの地の文（題を含む）。語の初出を探すときの走査対象。 */
export const proseOf = (block: VocabularyBlock): string =>
  block.title + " " + block.nodes.filter((n) => n.kind === "text").map((n) => n.value).join(" ");

/** 文書順に走査して、名づけられた語ごとに初出と定義位置を返す。 */
export const traceVocabulary = (
  blocks: readonly VocabularyBlock[],
  locale: string,
): VocabularyTrace[] => {
  const named = new Map<string, { block: VocabularyBlock; via: string }>();
  for (const block of blocks) {
    for (const site of namingSitesIn(block, locale)) {
      if (!named.has(site.term)) named.set(site.term, { block, via: site.via });
    }
  }
  const traces: VocabularyTrace[] = [];
  for (const [term, { block, via }] of named) {
    const first = blocks.find((b) => proseOf(b).toLowerCase().includes(term.toLowerCase()));
    if (first === undefined) continue;
    traces.push({ term, definedAt: block, via, firstAt: first });
  }
  traces.sort((a, b) => a.definedAt.index - b.definedAt.index || a.term.localeCompare(b.term));
  return traces;
};

/** 初出が名づけの位置より前にある語。 */
export const usedBeforeNaming = (traces: readonly VocabularyTrace[]): VocabularyTrace[] =>
  traces.filter((t) => t.firstAt.index < t.definedAt.index);

const normalizeTerm = (face: string): string => face.replaceAll(/[\s{}]/gu, "").toLowerCase();

/**
 * その語が台帳の字面のどれかに覆われているか。
 *
 * **記号の走査と違い、ここは包含で見る**（双方向）。切り出した語は名詞句なので、
 * 台帳の字面より長くなったり短くなったりする（「Massieu 自由エントロピーの Λ 帰属」と
 * 「Massieu 自由エントロピー」、「なら型 III」と「型 III」）。記号のときに部分一致を
 * 禁じたのは、裸の 1 記号が飾りつきの字面に飲まれるのを防ぐためで、語にその危険はない
 * （2 文字以上を要求しているので、1 文字の偶然の一致は起きない）。
 */
export const coveredByLedger = (term: string, faces: readonly string[]): boolean => {
  const t = normalizeTerm(term);
  if (t.length < 2) return false;
  return faces.some((face) => {
    const f = normalizeTerm(face);
    return f.length >= 2 && (t.includes(f) || f.includes(t));
  });
};
