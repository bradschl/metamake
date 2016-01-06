
#include <iostream>

#include "baz/BazClass.h"
#include "bar/barFile.h"

int main(void)
{
    {
        Baz::BazClass b;
        b.doSomething();
    }

    BarFile_goToBar();

    std::cout << "main()\n";
    return 0;
}

