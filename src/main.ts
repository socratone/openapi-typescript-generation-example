import { findPetsByStatus } from './generated/sdk.gen';

const init = async () => {
  const result = await findPetsByStatus({
    query: {
      status: ['available'],
    },
  });

  console.log(result.data);
};

init();
