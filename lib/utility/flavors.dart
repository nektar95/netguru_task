enum Flavor { dev, prod }

Flavor appFlavor = Flavor.dev;

void setAppFlavor(Flavor flavor) {
  appFlavor = flavor;
}

Flavor getAppFlavor() => appFlavor;
