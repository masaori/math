import { defineBlocks, displayMath, math, paragraph } from "../schema.ts";

export default defineBlocks([
  {
    id: "arithmetic_tools_definition_prime_exponent_logarithmic_group",
    kind: "definition",
    title: { text: "有限台素指数写像の素指数加法群" },
    labels: ["def_prime_exponent_logarithmic_group"],
    habitat: "Lambda",
    statement: [
      paragraph([
        "素数全体の集合を ",
        math(String.raw`\mathcal P`),
        " とし、各 ",
        math(String.raw`p\in\mathcal P`),
        " に形式的生成元 ",
        math(String.raw`\ell_p`),
        " を割り当てる。有限台をもつ整数係数写像全体からなる素指数加法群を",
      ]),
      displayMath(String.raw`\Lambda:=\bigoplus_{p\in\mathcal P}\mathbb Z\,\ell_p`),
      paragraph([
        "で定める。すなわち ",
        math(String.raw`\Lambda`),
        " の元は、有限個の素数を除いて零となる写像 ",
        math(String.raw`\mathcal P\to\mathbb Z`),
        " であり、加法は各素数成分での整数加法である。この定義は曲面、格子、スピン、実対数を用いない。",
      ]),
    ],
  },
]);
